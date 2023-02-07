import 'package:flutter/material.dart';
import 'detailwidget.dart';
import 'models/person.dart';

class PersonList extends StatelessWidget {
  final List<Person> persons;
  PersonList({super.key, required this.persons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: persons == null ? 0 : persons.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWidget(persons[index])),
              );
            },
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('${persons[index].name} ${persons[index].lastname}'),
              subtitle: Text(persons[index].acess),
            ),
          ));
        });
  }
}
