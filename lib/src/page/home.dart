import 'package:flutter/material.dart';
import 'package:maze_game/src/page/mazeGamePage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MazeGamePage(),
    );
  }
}
