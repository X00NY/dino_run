import 'package:dino_run/dino_run.dart';
import 'package:flame/components.dart';

class Score extends TextComponent with HasGameRef<DinoRun> {
  Score() : super();
  late String score;

  @override
  void update(double dt) {
    score = game.score.toString();
    text = score;
    position = Vector2((game.size.x / 2) - width / 2, 20);
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    
    score = game.score.toString();
    text = score;
    position = Vector2((game.size.x / 2) - width / 2, 20);
    super.onGameResize(size);
  }
}
