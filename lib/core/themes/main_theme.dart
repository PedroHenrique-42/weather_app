import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
);
