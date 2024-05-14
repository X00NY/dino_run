import 'dart:async';

import 'package:dino_run/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class DinoRun extends FlameGame {
  late final Player player;
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    player = Player(size: Vector2.all(64), position: Vector2(100, 200))..priority=10;
    add(player);

    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('Backgrounds/plx-1.png'),
        ParallaxImageData('Backgrounds/plx-2.png'),
        ParallaxImageData('Backgrounds/plx-3.png'),
        ParallaxImageData('Backgrounds/plx-4.png'),
        ParallaxImageData('Backgrounds/plx-5.png'),
        ParallaxImageData('Backgrounds/plx-6.png'),
      ],
      baseVelocity: Vector2(3, 0),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(2, 0),
    );
    add(parallax);
    return super.onLoad();
  }
}
