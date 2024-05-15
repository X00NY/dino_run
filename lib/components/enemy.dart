import 'dart:async';

import 'package:dino_run/constants/constants.dart';
import 'package:flame/components.dart';

enum EnemyType {
  bat,
  chicken,
  rino,
}

class EnemyData {
  final String imageName;
  final double textureWidth;
  final double textureHeight;
  final int amount;
  final double speed;
  final double yPos;
  final double scaleSize;

  EnemyData({
    required this.imageName,
    required this.textureWidth,
    required this.textureHeight,
    required this.amount,
    required this.speed,
    required this.yPos,
    required this.scaleSize,
  });
}

class Enemy extends SpriteAnimationComponent with HasGameRef {
  late double _speed;
  late EnemyData _enemyData;

  final Map<EnemyType, EnemyData> enemyDetails = {
    EnemyType.bat: EnemyData(
      imageName: 'Enemies/Bat/Flying (46x30).png',
      textureWidth: 46,
      textureHeight: 30,
      amount: 7,
      speed: 400,
      yPos: 150,
      scaleSize: 8
    ),
    EnemyType.chicken: EnemyData(
      imageName: 'Enemies/Chicken/Run (32x34).png',
      textureWidth: 32,
      textureHeight: 34,
      amount: 14,
      speed: 500,
      yPos: 0,
      scaleSize: 6
    ),
    EnemyType.rino: EnemyData(
      imageName: 'Enemies/Rino/Run (52x34).png',
      textureWidth: 52,
      textureHeight: 34,
      amount: 6,
      speed: 600,
      yPos: 0,
      scaleSize: 6
    ),
  };
  Enemy(EnemyType enemytype) : super() {
    _enemyData = enemyDetails[enemytype]!;
  }

  @override
  FutureOr<void> onLoad() {
    _speed = _enemyData.speed;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(_enemyData.imageName),
      SpriteAnimationData.sequenced(
        amount: _enemyData.amount,
        stepTime: stepTime,
        textureSize: Vector2(_enemyData.textureWidth, _enemyData.textureHeight),
      ),
    );
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    // Set the enemy height to be 1/10th of the screen height
    var enemyHeightProportion = 1 / _enemyData.scaleSize;
    height = size.y * enemyHeightProportion;

    // Set the enemy width to be proportional to its height based on the texture's aspect ratio
    final textureAspectRatio =
        _enemyData.textureWidth / _enemyData.textureHeight;
    width = height * textureAspectRatio;

    final groundLevelPosition = size.y * 0.88;

    // Position the enemy on the ground level
    position.x = game.size.x + width;
    position.y = groundLevelPosition - height - _enemyData.yPos;

    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    position.x -= _speed * dt;
    super.update(dt);

    if (position.x < -width) {
      position.x = game.size.x + width;
    }
  }
}
