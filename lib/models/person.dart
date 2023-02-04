// ignore_for_file: constant_identifier_names

class Person {
  final String id;
  final String login;
  final String name;
  final String lastname;
  final String acess;
  final String status;
  final String password;

  Person(
      {required this.id,
      required this.login,
      required this.name,
      required this.lastname,
      required this.acess,
      required this.status,
      required this.password});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: (json['id'] as int).toString(),
        login: json['login'] as String,
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        acess: json['access'] as String,
        status: json['status'] as String,
        password: '');
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $name, login: $login}';
  }
}

enum AcessPerson {
  DENTISTA,
  FUNCIONARIO;
}

enum StatusPerson {
  ATIVO,
  INATIVO;
}

AcessPerson toAcessPerson(String value) {
  return AcessPerson.values.firstWhere((element) =>
      element.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}

StatusPerson toStatusPerson(String value) {
  return StatusPerson.values.firstWhere((element) =>
      element.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}
