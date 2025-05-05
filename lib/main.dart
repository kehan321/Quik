import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quik/view/view.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Qwik',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: UrlLauncherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

