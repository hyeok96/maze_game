import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maze_game/initBinding.dart';
import 'package:maze_game/src/page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      home: const Home(),
    );
  }
}
