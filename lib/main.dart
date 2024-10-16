import 'package:flutter/material.dart';
import 'pages/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
