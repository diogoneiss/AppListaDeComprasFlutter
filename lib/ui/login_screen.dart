import 'package:flutter/material.dart';
import '../model/user_instance.dart';
import 'dart:convert';
import './cart_list_screen.dart';
import './cadastro_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<List<String>> listOfUsers;

  @override
  void initState() {
    super.initState();
    _updateUsers();
  }

  _updateUsers() {
    setState(() {
      listOfUsers = _getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de compras',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
        ),
        body: FutureBuilder<List<String>>(
            future: listOfUsers,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return functionBody(snapshot.data);
            }));
  }

  Widget functionBody(List<String> listOfUsers) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome de usuário',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroScreenPage()));
              },
              textColor: Colors.green,
              child: Text('Esqueci a senha, recadastrar'),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text('Login'),
                  onPressed: () async {
                    print(nameController.text);
                    print(passwordController.text);
                    User current = new User(
                        username: nameController.text,
                        password: passwordController.text);
                    int logged = await validUser(current, listOfUsers);


                    //verificar se está no DB e, se estiver, ir pra home
                    if (logged == 0)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    else if (logged == 1)
                      passwordController.text = "Senha invalida..";
                    else
                      nameController.text = "Usuario nao encontrado..";
                  },
                )),
            Container(
                child: Row(
              children: <Widget>[
                Text('Não possui conta?'),
                FlatButton(
                  textColor: Colors.green,
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => CadastroScreenPage()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
          ],
        ));
  }

  /// Retorno 0: sucesso
  /// Retorno 1: senha incorreta
  /// Retorno 2: usuario nao encontrado
  Future<int> validUser(User current, List<String> listOfUsers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String pw = current.password;
    String user = current.username;

    //chamada da api


    String dbPassword = prefs.getString(user);

    if (!listOfUsers.contains(user)) {
      return 2;
    } else if (dbPassword.compareTo(pw) == 0) {
      return 0;
    } else
      return 1;
  }

  Future<List<String>> _getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // iterate over the list and map each object in list to Img by calling Img.fromJson
    List<String> userList = prefs.getKeys().toList();
    print(userList);
    return userList;
  }
}
