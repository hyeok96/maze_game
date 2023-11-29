import 'package:get/get.dart';
import 'package:maze_game/src/controller/maze_game_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MazeGameController>(MazeGameController());
  }
}
