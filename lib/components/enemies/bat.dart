import 'dart:async';

import 'package:dino_run/components/custom_hitbox.dart';
import 'package:dino_run/constants/constants.dart';
import 'package:dino_run/dino_run.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bat extends SpriteAnimationComponent with HasGameRef<DinoRun> {
  Bat({required super.position})
      : super(size: Vector2(144, 90), anchor: Anchor.bottomLeft);

  final double _speed = 600;

  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 125,
    height: 70,
  );

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    position.y = game.size.y / 2;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Enemies/Bat/Flying (46x30).png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: Constants.stepTime,
        textureSize: Vector2(46, 30),
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
