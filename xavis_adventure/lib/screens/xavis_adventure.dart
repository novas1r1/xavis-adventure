import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xavis_adventure/components/player_component.dart';
import 'package:xavis_adventure/layers/background_layer.dart';

class XavisAdventure extends BaseGame with KeyboardEvents {
  late PlayerComponent player;
  late BackgroundLayer background;

  @override
  Future<void> onLoad() async {
    final backgroundSprite = await Sprite.load('bg_game.png');
    final backgroundBorderSprite = await Sprite.load('bg_game_border.png');
    background = BackgroundLayer(backgroundSprite, backgroundBorderSprite);

    final playerSize = Vector2.all(50.0);
    final initialPlayerPosition = Vector2(125, 275);
    final playerSprite = await Sprite.load('player/player_dryer.png');

    player = PlayerComponent(
      position: initialPlayerPosition,
      size: playerSize,
      sprite: playerSprite,
    );

    add(player);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    player.render(canvas);
  }

  @override
  void onKeyEvent(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      player.move(MoveDirection.right);
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      player.move(MoveDirection.left);
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      player.move(MoveDirection.up);
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      player.move(MoveDirection.down);
    }
  }
}
