import 'package:controle_de_ponto_mobile/service/person_service.dart';
import 'package:flutter/material.dart';

import '../model/person.dart';

final service = ApiService();
Future<List<Person>> futurePersons = service.getPersons();
List<Person>? persons;

class PersonList extends StatelessWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    loadList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pessoas'),
      ),
      body: ListView.builder(
        itemCount: persons?.length,
        itemBuilder: ((context, index) =>
            Text(persons?.elementAt(index).login ?? "Null")),
      ),
    );
  }
}

Future<List<Person>> loadList() async {
  Future<List<Person>> futurePersons = service.getPersons();
  futurePersons.then((casesList) {
    persons = casesList;
  });
  return futurePersons;
}
