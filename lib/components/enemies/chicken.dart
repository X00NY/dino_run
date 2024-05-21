import 'dart:async';

import 'package:dino_run/components/custom_hitbox.dart';
import 'package:dino_run/constants/constants.dart';
import 'package:dino_run/dino_run.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Chicken extends SpriteAnimationComponent with HasGameRef<DinoRun> {
  Chicken({required super.position})
      : super(size: Vector2(96, 102), anchor: Anchor.bottomLeft);

  final double _speed = 500;

  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 20,
    width: 80,
    height: 70,
  );

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/Chicken/Run (32x34).png'),
      SpriteAnimationData.sequenced(
        amount: 14,
        stepTime: Constants.stepTime,
        textureSize: Vector2(32, 34),
      ),
    );

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
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
