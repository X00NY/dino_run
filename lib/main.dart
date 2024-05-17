import 'package:dino_run/dino_run.dart';
import 'package:dino_run/overlays/game_over.dart';
import 'package:dino_run/overlays/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();

  runApp(
    GameWidget<DinoRun>.controlled(
      gameFactory: DinoRun.new,
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
        'GameOver': (_, game) => GameOver(
              game: game,
              score: game.finalScore,
            ),
      },
      initialActiveOverlays: const ['MainMenu'],
    ),
  );
}
