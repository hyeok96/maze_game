import 'dart:async';

import 'package:get/get.dart';
import 'package:maze_game/src/mazeGame.dart';

import '../core/game_state.dart';

class MazeGameController extends GetxController {
  final Rx<GameState> _state = Rx(Init());
  GameState get state => _state.value;

  RxInt _level = 9.obs;
  int get level => _level.value;
  final RxBool _finish = false.obs;
  bool get finish => _finish.value;
  RxDouble _right = 900.0.obs;
  double get right => _right.value;
  RxDouble _bottom = 1300.0.obs;
  double get bottom => _bottom.value;
  final RxInt _seconds = 0.obs;
  int get seconds => _seconds.value;
  final RxInt _min = 0.obs;
  int get min => _min.value;
  final RxInt _hour = 0.obs;
  int get hour => _hour.value;

  final RxString _totalTime = "".obs;
  String get totalTime => _totalTime.value;

  late Timer _timer;

  void onTapGameLevel(int level) {
    _hour.value = 0;
    _min.value = 0;
    _seconds.value = 0;
    _state.value = Playing();
    double levelNum = double.parse(level.toString());
    if (level == 1) {
      _level = 9.obs;
      _right = (_right + 1 * (levelNum - 1.0)) as RxDouble;
      _bottom = (_bottom + 1 * (levelNum - 1.0)) as RxDouble;
      setNewGame();
    }
    if (level == 2) {
      _level = 13.obs;
      _right = (_right + 400 * (levelNum - 1.0)) as RxDouble;
      _bottom = (_bottom + 400 * (levelNum - 1.0)) as RxDouble;
      setNewGame();
    }
    if (level == 3) {
      _level = 17.obs;
      _right = (_right + 400 * (levelNum - 1.0)) as RxDouble;
      _bottom = (_bottom + 400 * (levelNum - 1.0)) as RxDouble;
      setNewGame();
    }
    setTimer();
  }

  late MazeGame _game;
  MazeGame get game => _game;

  MazeGame newGameInstance() {
    return MazeGame(finish: finish, level: level, right: right, bottom: bottom);
  }

  void setNewGame() {
    _game = newGameInstance();
  }

  void endGame() {
    _state.value = GameOver();
    stopTimer();
    showTime();
  }

  void returnSelectPage() {
    _state.value = Init();
  }

  void reStartGame() {
    _state.value = Playing();
    _hour.value = 0;
    _min.value = 0;
    _seconds.value = 0;
    setNewGame();
    setTimer();
  }

  void setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds.value++;
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void showTime() {
    String Hour = (seconds / 3600).floor().toString();
    String Min = (seconds / 60).floor().toString();
    String Second = (seconds % 60).toString();

    if (Hour.length != 2) {
      Hour = "0$Hour";
    }
    if (Min.length != 2) {
      Min = "0$Min";
    }
    if (Second.length != 2) {
      Second = "0$Second";
    }

    _totalTime.value = "$Hour : $Min : $Second";
  }

  void stopGame() {
    _state.value = Stop();
    _timer.cancel();
  }

  void replayGame() {
    _state.value = Playing();
    setTimer();
  }
}
