import 'dart:async';

import 'package:dino_run/dino_run.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class DigiLife extends SpriteComponent
    with HasGameRef<DinoRun>, CollisionCallbacks {
  DigiLife({required super.position})
      : super(size: Vector2(60, 38), anchor: Anchor.bottomCenter);

  final double _speed = 200;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = Sprite(game.images.fromCache('Items/digi.png'));
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= _speed * dt;
    if (position.x < -width) {
      removeFromParent();
    }
    if (game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
