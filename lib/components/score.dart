import 'dart:async';

import 'package:dino_run/dino_run.dart';
import 'package:flame/components.dart';

class Score extends TextComponent with HasGameRef<DinoRun> {
  Score() : super();
  late String score;

  @override
  FutureOr<void> onLoad() {
    score = game.score.toString();
    text = 'SCORE: $score';
    position = Vector2(100, 20);
    return super.onLoad();
  }
}
