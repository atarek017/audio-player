
import 'package:audio_player/src/screens/detail_audio_page.dart';
import 'package:audio_player/src/screens/my_home_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Adio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: const MyHomePage(),
    );
  }
}