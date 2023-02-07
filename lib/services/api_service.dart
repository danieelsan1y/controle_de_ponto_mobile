import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';

import '../models/person.dart';

class ApiService {
  final String apiUrl = "http://192.168.100.30:8080/person";
  final String pathDisable = "/status/inactivate/";
  final String pathEnable = "/status/activate/";

  Future<List<Person>> getPerson() async {
    Response res = await get(apiUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Person> persons =
          body.map((dynamic item) => Person.fromJson(item)).toList();
      return persons;
    } else if (res.statusCode == 404) {
      return <Person>[];
    } else {
      throw "Failed to load persons list";
    }
  }

  Future<Person> getPersonById(String id) async {
    final response = await get('$apiUrl/$id');

    if (response.statusCode == 200) {
      print("GetpersonByID:" + id);
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
      'access': person.acess,
      'password': person.password
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post persons');
    }
  }

  Future<Person> updatePerson(String id, Person person) async {
    Map data = {
      'name': person.name,
      'login': person.login,
      'lastname': person.lastname,
      'access': person.acess,
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

  Future<void> deletePerson(String id, String status) async {
    Response res;
    if (status == 'ATIVO') {
      res = await put('$apiUrl$pathDisable$id');
    } else {
      res = await put('$apiUrl$pathEnable$id');
    }
    if (res.statusCode == 200) {
      print("Person disabled");
    } else {
      throw "Failed to disabled a person.";
    }
  }
}
