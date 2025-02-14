enum EqualizerMode {
  flat,
  rock,
  pop,
  jazz,
  classical;
}

extension EqualizerLevels on EqualizerMode {
  List<double> get levels {
    switch (this) {
      case EqualizerMode.flat:
        return [0, 0, 0, 0, 0];
      case EqualizerMode.rock:
        return [3, 5, -2, 4, 1];
      case EqualizerMode.pop:
        return [5, 3, 1, -1, -2];
      case EqualizerMode.jazz:
        return [-2, 3, 5, 2, 1];
      case EqualizerMode.classical:
        return [4, -1, -3, 5, 3];
    }
  }

  String get name {
    switch (this) {
      case EqualizerMode.flat:
        return "Flat";
      case EqualizerMode.rock:
        return "Rock";
      case EqualizerMode.pop:
        return "Pop";
      case EqualizerMode.jazz:
        return "Jazz";
      case EqualizerMode.classical:
        return "Classical";
    }
  }
}
