import 'package:get/get.dart';
import 'package:maze_game/src/mazeGame.dart';

import '../core/game_state.dart';

class MazeGameController extends GetxController {
  final Rx<GameState> _state = Rx(Init());
  GameState get state => _state.value;

  RxInt _level = 3.obs;
  int get level => _level.value;
  final RxBool _finish = false.obs;
  bool get finish => _finish.value;
  RxInt _right = 0.obs;
  int get right => _right.value;
  final RxInt _bottom = 0.obs;
  int get bottom => _bottom.value;

  void onTapGameLevel(int level) {
    _state.value = Playing();
    if (level == 1) {
      _level = 3.obs;
      _right = 190.obs;

      setNewGame();
    }
    if (level == 2) {
      _level = 13.obs;
      setNewGame();
    }
    if (level == 3) {
      _level = 17.obs;
      setNewGame();
    }
  }

  late MazeGame _game;
  MazeGame get game => _game;

  MazeGame newGameInstance() {
    return MazeGame(finish: finish, level: level);
  }

  void setNewGame() {
    _game = newGameInstance();
  }

  void endGame() {
    _state.value = GameOver();
  }

  void returnSelectPage() {
    _state.value = Init();
  }

  void replayGame() {
    _state.value = Playing();
    setNewGame();
  }
}
