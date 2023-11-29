class WallType {
  bool up;
  bool right;
  bool down;
  bool left;

  WallType(
      {required this.up,
      required this.right,
      required this.down,
      required this.left});

  int wallTpyeNumber = 0;

  int getWallTypeNumber() {
    if (up && !right && !down && !left) {
      wallTpyeNumber = 1;
      return wallTpyeNumber;
    }

    if (!up && right && !down && !left) {
      wallTpyeNumber = 2;
      return wallTpyeNumber;
    }

    if (!up && !right && down && !left) {
      wallTpyeNumber = 3;
      return wallTpyeNumber;
    }

    if (!up && !right && !down && left) {
      wallTpyeNumber = 4;
      return wallTpyeNumber;
    }

    if (up && right && !down && !left) {
      wallTpyeNumber = 5;
      return wallTpyeNumber;
    }

    if (up && !right && down && !left) {
      wallTpyeNumber = 6;
      return wallTpyeNumber;
    }

    if (up && !right && !down && left) {
      wallTpyeNumber = 7;
      return wallTpyeNumber;
    }

    if (!up && right && down && !left) {
      wallTpyeNumber = 8;
      return wallTpyeNumber;
    }

    if (!up && right && !down && left) {
      wallTpyeNumber = 9;
      return wallTpyeNumber;
    }

    if (!up && !right && down && left) {
      wallTpyeNumber = 10;
      return wallTpyeNumber;
    }

    if (up && right && down && !left) {
      wallTpyeNumber = 11;
      return wallTpyeNumber;
    }

    if (up && right && !down && left) {
      wallTpyeNumber = 12;
      return wallTpyeNumber;
    }

    if (up && !right && down && left) {
      wallTpyeNumber = 13;
      return wallTpyeNumber;
    }

    if (!up && right && down && left) {
      wallTpyeNumber = 14;
      return wallTpyeNumber;
    }

    if (up && right && down && left) {
      wallTpyeNumber = 15;
      return wallTpyeNumber;
    }

    return 0;
  }
}
