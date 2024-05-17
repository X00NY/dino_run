import 'dart:async';
import 'dart:math';

import 'package:dino_run/components/enemies/bat.dart';
import 'package:dino_run/components/enemies/chicken.dart';
import 'package:dino_run/components/enemies/rino.dart';
import 'package:dino_run/dino_run.dart';
import 'package:flame/components.dart';

class EnemyManager extends Component with HasGameRef<DinoRun> {
  late Random _random;
  late Timer _timer;
  late int _spawnLvl;

  @override
  FutureOr<void> onLoad() {
    _spawnLvl = 0;
    _random = Random();
    _timer = Timer(4, repeat: true, onTick: () {
      _spawnRandomEnemy();
    });
    _timer.start();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    var newSpawnLvl = game.score ~/ 500;
    if (_spawnLvl < newSpawnLvl) {
      _spawnLvl = newSpawnLvl;

      var newWaitTime = 4 / (1 + (0.1 * _spawnLvl));

      _timer.stop();
      _timer = Timer(newWaitTime, repeat: true, onTick: () {
        _spawnRandomEnemy();
      });
      _timer.start();
    }
    if (game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  void _spawnRandomEnemy() {
    final randomNbr = _random.nextInt(3);
    final enemyPos = Vector2(game.size.x, game.size.y * 0.88);
    switch (randomNbr) {
      case 0:
        game.world.add(Bat(position: enemyPos));
        break;
      case 1:
        game.world.add(Chicken(position: enemyPos));
        break;
      case 2:
        game.world.add(Rino(position: enemyPos));
        break;
    }
  }
}
