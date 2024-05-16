import 'dart:async';

import 'package:dino_run/components/enemy.dart';
import 'package:dino_run/components/player.dart';
import 'package:dino_run/components/score.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class DinoRun extends FlameGame with TapDetector {
  late final Player player;
  late final Score _scoreText;
  int score = 0;
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

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
    add(parallax);

    player = Player();
    add(player);

    var enemy = Enemy(EnemyType.rino);
    add(enemy);
    add(_scoreText);

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    player.jump();
    super.onTapDown(info);
  }

  @override
  void update(double dt) {
    score += (1000 * dt).toInt();
    _scoreText.text = score.toString();
    super.update(dt);
  }
}
