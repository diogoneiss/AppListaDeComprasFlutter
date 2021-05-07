import 'package:flutter/material.dart';
import 'package:todo_application/ui/login_screen.dart';
import '../model/user_instance.dart';
import 'dart:convert';
import './cart_list_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './login_screen.dart';

class CadastroScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<CadastroScreenPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        body: functionBody());
  }

  Widget functionBody() {
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
                height: 70,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
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
                    Text('Já possui conta?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
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

}

