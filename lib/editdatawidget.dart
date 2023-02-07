import 'package:flutter/material.dart';
import 'models/person.dart';
import 'services/api_service.dart';

enum Gender { male, female }

enum Status { positive, dead, recovered }

class EditDataWidget extends StatefulWidget {
  EditDataWidget(this.person);

  final Person person;

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  _EditDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  String id = '';
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  String acess = 'FUNCIONARIO';
  AcessPerson _acess = AcessPerson.FUNCIONARIO;

  @override
  void initState() {
    id = widget.person.id;
    _nameController.text = widget.person.name;
    acess = widget.person.acess;
    if (widget.person.acess == 'FUNCIONARIO') {
      _acess = AcessPerson.FUNCIONARIO;
    } else {
      _acess = AcessPerson.DENTISTA;
    }
    _loginController.text = widget.person.login;
    _lastNameController.text = widget.person.lastname;
    _passwordController.text = widget.person.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Pessoas'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Nome'),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Nome',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor inserir o nome';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Sobrenome'),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  hintText: 'Sobrenome',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor inserir o sobrenome';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Senha'),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Senha',
                                ),
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Acesso'),
                              ListTile(
                                title: const Text('Dentista'),
                                leading: Radio(
                                  value: AcessPerson.DENTISTA,
                                  groupValue: _acess,
                                  onChanged: (AcessPerson? value) {
                                    setState(() {
                                      _acess = value!;
                                      acess = 'DENTISTA';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Funcionário'),
                                leading: Radio(
                                  value: AcessPerson.FUNCIONARIO,
                                  groupValue: _acess,
                                  onChanged: (AcessPerson? value) {
                                    setState(() {
                                      _acess = value!;
                                      acess = 'FUNCIONARIO';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    api.updatePerson(
                                        id,
                                        Person(
                                            id: '',
                                            login: _loginController.text,
                                            name: _nameController.text,
                                            lastname: _lastNameController.text,
                                            acess: acess,
                                            status: '',
                                            password:
                                                _passwordController.text));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Salvar',
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
