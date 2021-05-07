import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'cart_list_screen.dart';
import 'login_screen.dart';
class Home extends StatelessWidget {
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
      body: LoginPage(),
    );
  }
}
