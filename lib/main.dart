// ignore_for_file: prefer_const_constructors

import 'package:demo/Signup.dart';

import 'package:demo/dropdown.dart';
import 'package:demo/name.dart';
import 'package:demo/splesh_screen.dart';
import 'package:demo/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {'/': (context) => Splesh_screen()},
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
  
}
