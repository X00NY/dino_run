import 'dart:async';

import 'package:dino_run/components/score.dart';
import 'package:dino_run/dino_run.dart';
import 'package:dino_run/overlays/heart.dart';
import 'package:flame/components.dart';

class Hud extends PositionComponent with HasGameRef<DinoRun> {
  Hud({
    super.priority = 5,
  });

  late Score _scoreComponent;

  @override
  FutureOr<void> onLoad() async {
    _scoreComponent = Score(position: Vector2(game.size.x / 2, 0));
    add(_scoreComponent);

    for (var i = 1; i <= game.health; i++) {
      final positionX = 80 * i;
      await add(HeartHealthComponent(
        heartNumber: i,
        position: Vector2(positionX.toDouble(), 20),
        size: Vector2.all(64),
      ));
    }
    return super.onLoad();
  }
}
