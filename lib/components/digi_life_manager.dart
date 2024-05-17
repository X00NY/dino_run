import 'dart:async';
import 'dart:math';

import 'package:dino_run/components/digi_life.dart';
import 'package:dino_run/dino_run.dart';
import 'package:flame/components.dart';

class DigiLifeManager extends Component with HasGameRef<DinoRun> {
  late Timer _timer;

  @override
  FutureOr<void> onLoad() {
    _timer = Timer(10, repeat: true, onTick: () {
      _spawnLife();
    });
    _timer.start();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    if (game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  double getRandomDoubleInRange(double min, double max) {
    final random = Random();
    return min + (random.nextDouble() * (max - min));
  }

  void _spawnLife() {
    final posY = getRandomDoubleInRange(0.5, 0.88);
    game.world
        .add(DigiLife(position: Vector2(game.size.x, game.size.y * posY)));
  }
}
