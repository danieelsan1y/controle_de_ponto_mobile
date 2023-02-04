import 'package:flutter/material.dart';
import 'models/person.dart';

class CasesList extends StatelessWidget {
  final List<Person> cases;
  CasesList({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cases == null ? 0 : cases.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('${cases[index].name} ${cases[index].lastname}'),
              subtitle: Text(cases[index].acess),
            ),
          ));
        });
  }
}
