import 'package:flutter/material.dart';
import 'dart:async';
import 'adddatawidget.dart';
import 'caseslist.dart';
import 'models/person.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de usuários',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lista de Usuários'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  List<Person> casesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: Container(
          child: Center(
              child: FutureBuilder<List<Person>>(
            future: loadList(),
            builder: (context, AsyncSnapshot<List<Person>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("feature builder");
              print(snapshot.connectionState);
              return casesList.length > 0
                  ? CasesList(cases: casesList)
                  : Center(
                      child: Text('No data found, tap plus button to add!',
                          style: Theme.of(context).textTheme.headline6));
            },
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Person>> loadList() async {
    print("load list");
    Future<List<Person>> futureCases = api.getPerson();
    futureCases.then((casesList) {
      print("setState");
      //setState(() {
      this.casesList = casesList;
      //});
    });
    return futureCases;
  }

  Future<void> _getData() async {
    setState(() {
      loadList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
