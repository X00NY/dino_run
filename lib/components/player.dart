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
    with HasGameRef<DinoRun>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation fallAnimation;

  double _speedY = 0.0;
  //double _yMax = 0.0;

  final double _gravity = 9.8;
  final double _jumpForce = 260;
  final double _terminalVelocity = 300;

  bool isOnGround = false;
  bool hasJumped = false;

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    current = PlayerState.running;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMouvement(dt);
    _updatePlayerState();
    _applyGravity(dt);

    super.update(dt);
  }

  void _updatePlayerState() {
    if (_speedY < 0) {
      current = PlayerState.jumping;
    } else if (_speedY > 0) {
      current = PlayerState.falling;
    } else {
      current = PlayerState.running;
    }
  }

  void _updatePlayerMouvement(double dt) {
    if (hasJumped && isOnGround) jump(dt);

    if (_speedY> _gravity) isOnGround = false;
  }

  void _applyGravity(double dt) {
    _speedY += _gravity;
    _speedY = _speedY.clamp(-_jumpForce, _terminalVelocity);
    position.y += _speedY * dt;
  }

  @override
  void onGameResize(Vector2 size) {
    height = width = size.y / 8;
    position.x = 150;
    position.y = size.y - height * 2;
    super.onGameResize(size);
    //_yMax = position.y;
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

  void jump(double dt) {
    _speedY = -_jumpForce;
    position.y += _speedY * dt;
    isOnGround = false;
    hasJumped = false;
  }
}
