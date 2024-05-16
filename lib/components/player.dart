import 'dart:async';

import 'package:dino_run/constants/constants.dart';
import 'package:dino_run/dino_run.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

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
    with HasGameRef<DinoRun>, KeyboardHandler, CollisionCallbacks {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation fallAnimation;
  Vector2 hitboxPos = Vector2.zero();
  Vector2 hitboxSize = Vector2.zero();

  double _gravity = 0.0;
  double _speedY = 0;
  double _yMax = 0;
  //final double _realWidthRatio = 20 / 32;

  @override
  FutureOr<void> onLoad() {
    debugPrint(width.toString());
    debugMode = true;

    _loadAllAnimations();
    add(RectangleHitbox(position: hitboxPos, size: hitboxSize));

    current = PlayerState.running;

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    var groundLvl = size.y * 0.88;
    _gravity = size.y * 2.5;
    height = width = size.y / 6;
    position.x = 150;
    position.y = groundLvl - height;
    _yMax = position.y;
    hitboxPos =
        Vector2(width - (width * (1 - 0.62)), height - (height * (1 - 0.75)));
    hitboxSize = Vector2(width * 0.62, height * 0.75);
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    _updateState();
    _updatePos(dt);
    super.update(dt);
  }

  void _updateState() {
    if (_speedY < 0) {
      current = PlayerState.jumping;
    } else if (_speedY > 0) {
      current = PlayerState.falling;
    } else {
      current = PlayerState.running;
    }
  }

  void _updatePos(double dt) {
    _speedY += _gravity * dt;
    position.y += _speedY * dt;
    if (isOnGround()) {
      position.y = _yMax;
      _speedY = 0;
    }
  }

  bool isOnGround() {
    return (position.y >= _yMax);
  }

  SpriteAnimation _playerSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/Ninja Frog/$state (32x32).png'),
      SpriteAnimationData.sequenced(
          amount: amount, stepTime: stepTime, textureSize: Vector2.all(32)),
    );
  }

  void _loadAllAnimations() {
    idleAnimation = _playerSpriteAnimation('Idle', 11);
    runAnimation = _playerSpriteAnimation('Run', 12);
    jumpAnimation = _playerSpriteAnimation('Jump', 1);
    fallAnimation = _playerSpriteAnimation('Fall', 1);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
      PlayerState.jumping: jumpAnimation,
      PlayerState.falling: fallAnimation,
    };
  }

  void jump() {
    if (isOnGround()) _speedY = -(game.size.y * 1.5);
  }
}
