import 'dart:async';

import 'package:dino_run/dino_run.dart';
import 'package:flame/components.dart';

enum PlayerState {
  idle,
  running,
  jumping,
  falling,
  hit,
  appearing,
  disappearing,
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<DinoRun> {
  Player({super.size, super.position});

  late final SpriteAnimation idleAnimation;

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    idleAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/Ninja Frog/Idle (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: 11, stepTime: stepTime, textureSize: Vector2.all(32)));

    animations = {
      PlayerState.idle: idleAnimation,
    };

    current = PlayerState.idle;
    return super.onLoad();
  }
}
