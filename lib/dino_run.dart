import 'dart:async';

import 'package:dino_run/components/digi_life_manager.dart';
import 'package:dino_run/components/enemy_manager.dart';
import 'package:dino_run/components/player.dart';
import 'package:dino_run/overlays/hud.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class DinoRun extends FlameGame with TapDetector, HasCollisionDetection {
  late Player _player;
  EnemyManager? enemyManager;
  DigiLifeManager? digiLifeManager;

  double _score = 0;
  double finalScore = 0;
  int health = 3;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    camera = CameraComponent.withFixedResolution(width: 1152, height: 648);
    camera.viewfinder.anchor = Anchor.topLeft;
    initializeGame(true);
    return super.onLoad();
  }

  void initializeGame(bool loadHud) async {
    for (var child in world.children) {
      child.removeFromParent();
    }
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('Backgrounds/plx-1.png'),
        ParallaxImageData('Backgrounds/plx-2.png'),
        ParallaxImageData('Backgrounds/plx-3.png'),
        ParallaxImageData('Backgrounds/plx-4.png'),
        ParallaxImageData('Backgrounds/plx-5.png'),
        ParallaxImageData('Backgrounds/plx-6.png'),
      ],
      baseVelocity: Vector2(5, 0),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(2, 0),
    );
    world.add(parallax);

    _player = Player(
      position: Vector2(128, size.y * 0.88),
    );
    world.add(_player);

    enemyManager = EnemyManager();
    world.add(enemyManager!);

    digiLifeManager = DigiLifeManager();
    world.add(digiLifeManager!);

    if (loadHud) {
      camera.viewport.add(Hud());
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    _player.jump();
    super.onTapDown(info);
  }

  @override
  void update(double dt) {
    _score += (100 * dt);
    if (health <= 0) {
      finalScore = _score;
      overlays.add('GameOver');
    }
    super.update(dt);
  }

  void reset() {
    _score = 0;
    health = 3;
    enemyManager?.removeFromParent();
    digiLifeManager?.removeFromParent();
    initializeGame(true);
  }

  int get score => _score.toInt();
}
