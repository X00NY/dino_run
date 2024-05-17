import 'dart:async';

import 'package:dino_run/dino_run.dart';
import 'package:flame/components.dart';

enum HeartState {
  available,
  unavailable,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameRef<DinoRun> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    required super.position,
    required super.size,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite('Items/heart.png',
        srcPosition: Vector2(0, 0), srcSize: Vector2(96, 96));
    final unavailableSprite = await game.loadSprite('Items/heart.png',
        srcPosition: Vector2(96, 0), srcSize: Vector2(96, 96));

    sprites = {
      HeartState.available: availableSprite,
      HeartState.unavailable: unavailableSprite,
    };

    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (game.health < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    if (game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
