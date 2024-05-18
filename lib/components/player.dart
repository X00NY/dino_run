import 'dart:async';

import 'package:dino_run/components/custom_hitbox.dart';
import 'package:dino_run/components/digi_life.dart';
import 'package:dino_run/components/enemies/bat.dart';
import 'package:dino_run/components/enemies/chicken.dart';
import 'package:dino_run/components/enemies/rino.dart';
import 'package:dino_run/constants/constants.dart';
import 'package:dino_run/dino_run.dart';
import 'package:flame/collisions.dart';
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
    with HasGameRef<DinoRun>, CollisionCallbacks {
  Player({
    required super.position,
  }) : super(size: Vector2.all(96), anchor: Anchor.bottomCenter);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation fallAnimation;
  late final SpriteAnimation hitAnimation;

  final double _jumpForce = 900;
  final double _gravity = 1700;
  double _speedY = 0;
  double _yMax = 0;
  bool _gothit = false;

  CustomHitbox hitbox = CustomHitbox(
    offsetX: 20,
    offsetY: 20,
    width: 60,
    height: 70,
  );

  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    _yMax = game.size.y * 0.88;

    _loadAllAnimations();
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));

    current = PlayerState.running;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updateState();
    _updatePos(dt);
    if (game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is DigiLife) {
      other.removeFromParent();
      if (game.health < 3) {
        game.health++;
      }
    } else if (other is Rino || other is Chicken || other is Bat) {
      _getHit();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void _updateState() async {
    if (_gothit) {
      current = PlayerState.hit;
      await animationTicker!.completed;
      _gothit = false;
    } else if (_speedY < 0) {
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
    hitAnimation = _playerSpriteAnimation('Hit', 7)..loop = false;

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
      PlayerState.jumping: jumpAnimation,
      PlayerState.falling: fallAnimation,
      PlayerState.hit: hitAnimation,
    };
  }

  void jump() {
    if (isOnGround()) _speedY = -_jumpForce;
  }

  void _getHit() async {
    _gothit = true;
    game.health--;
  }
}
