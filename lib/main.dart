import 'dart:html';

import 'package:flutter/material.dart';
import 'package:github_api_project/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gitApp',
      theme: ThemeData(
        brightness: Brightness.light, primarySwatch: Colors.yellow,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: const MainScreen(),
    );
  }
}

