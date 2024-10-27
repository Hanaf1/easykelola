import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/main_screen.dart';

void main() {
  // Atur status bar dan navigation bar transparan
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        canvasColor: Colors.white
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
