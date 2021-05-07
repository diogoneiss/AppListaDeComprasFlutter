import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lista de compras',
          home: Home(),
        );
      },
    );
  }
}
