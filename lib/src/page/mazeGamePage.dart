import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:maze_game/src/controller/maze_game_controller.dart';
import 'package:maze_game/src/mazeGame.dart';

import '../core/game_state.dart';

class MazeGamePage extends StatefulWidget {
  const MazeGamePage({super.key});

  @override
  State<MazeGamePage> createState() => _MazeGamePageState();
}

class _MazeGamePageState extends State<MazeGamePage> {
  late final MazeGameController _controller = Get.find<MazeGameController>();

  @override
  void initState() {
    super.initState();
    _controller.setNewGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _gameWodget()),
    );
  }

  Widget _gameWodget() {
    return Obx(
      () {
        GameState state = _controller.state;
        if (state is Init) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Mazegame"),
                TextButton(
                    onPressed: () {
                      _controller.onTapGameLevel(1);
                    },
                    child: const Text("쉬움")),
                TextButton(
                    onPressed: () {
                      _controller.onTapGameLevel(2);
                    },
                    child: const Text("보통")),
                TextButton(
                    onPressed: () {
                      _controller.onTapGameLevel(3);
                    },
                    child: const Text("어려움")),
              ],
            ),
          );
        }
        return SafeArea(
          child: Stack(
            children: [
              GameWidget(game: _controller.game),
              if (state is Playing)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("aa");
                          _controller.stopGame();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _controller.game.movePlayer(type: "up");
                              },
                              child: const Text("위")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _controller.game.movePlayer(type: "left");
                                  },
                                  child: const Text("왼쪽")),
                              ElevatedButton(
                                  onPressed: () {
                                    _controller.game.movePlayer(type: "right");
                                  },
                                  child: const Text("오른쪽")),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _controller.game.movePlayer(type: "down");
                              },
                              child: const Text("아래")),
                        ],
                      ),
                    ],
                  ),
                ),
              if (state is Stop) dialog(_controller),
              if (state is GameOver) _gameEndWidget(_controller)
            ],
          ),
        );
      },
    );
  }
}

Widget _gameEndWidget(MazeGameController controller) {
  return Container(
    color: Colors.black.withOpacity(0.7),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Congratulations!!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                controller.totalTime,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                controller.returnSelectPage();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "selectPage",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                controller.reStartGame();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "one more",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget dialog(MazeGameController controller) {
  return Container(
    color: Colors.black.withOpacity(0.7),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("OUT?"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                controller.returnSelectPage();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "selectPage",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                controller.replayGame();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
