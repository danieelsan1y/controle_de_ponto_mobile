import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';

import '../model/person.dart';

class ApiService {
  final String apiUrl = "http://192.168.100.30:8080/person";

  Future<List<Person>> getPersons() async {
    Response res = await get(apiUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Person> persons =
          body.map((dynamic item) => Person.fromJson(item)).toList();
      return persons;
    } else if (res.statusCode == 404) {
      return <Person>[];
    } else {
      throw "Failed to load person list";
    }
  }

  Future<Person> getPersonById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      print("GetPersonByID:" + id);
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a person');
    }
  }

  Future<Person> createPerson(Person person) async {
    Map data = {
      'name': person.name,
      'login': person.login,
      'lastname': person.lastname,
      'acess': person.acess,
      'status': person.status,
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post person');
    }
  }

  Future<Person> updatePerson(String id, Person person) async {
    Map data = {
      'name': person.name,
      'login': person.login,
      'lastname': person.lastname,
      'acess': person.acess,
      'status': person.status,
    };

    final Response response = await put(
      '$apiUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a person');
    }
  }

  Future<void> deletePerson(String id) async {
    Response res = await delete('$apiUrl/$id');

    if (res.statusCode == 200) {
      print("Person deleted");
    } else {
      throw "Failed to delete a person.";
    }
  }
}
