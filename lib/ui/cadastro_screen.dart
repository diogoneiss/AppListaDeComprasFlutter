import 'package:flutter/material.dart';
import '../model/user_instance.dart';
import 'dart:convert';
import './cart_list_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<CadastroPage> {
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
                  'Cadastro',
                  style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Seu user Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: false,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'sua senha',
                ),
              ),
            ),

            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Cadastrar '),
                  onPressed: () async {
                    print(nameController.text);
                    print(passwordController.text);
                    User current = new User(
                        username: nameController.text,
                        password: passwordController.text);

                    newUser(current);


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                  },
                )),
            Container(
                child: Row(
                  children: <Widget>[
                    Text('Não possui conta?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
          ],
        ));
  }


  void newUser(User current) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String pw = current.password;
    String user = current.username;

    //chamada da api


    prefs.setString(user, pw);

  }

  Future<List<String>> _getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // iterate over the list and map each object in list to Img by calling Img.fromJson
    List<String> userList = prefs.getKeys().toList();

    return userList;
  }
}

