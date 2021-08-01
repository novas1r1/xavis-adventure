import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xavis_adventure/components/enemy_flame_component.dart';
import 'package:xavis_adventure/components/player_component.dart';
import 'package:xavis_adventure/layers/background_layer.dart';

class XavisAdventure extends BaseGame with KeyboardEvents, HasCollidables {
  late PlayerComponent player;
  late BackgroundLayer background;
  late List<EnemyFlameComponent> flameEnemies;

  @override
  Future<void> onLoad() async {
    // create background
    final backgroundSprite = await Sprite.load('bg_game.png');
    final backgroundBorderSprite = await Sprite.load('bg_game_border.png');
    background = BackgroundLayer(backgroundSprite, backgroundBorderSprite);

    add(ScreenCollidable());

    // create player
    player = PlayerComponent();
    add(player);

    // add enemies
    flameEnemies = [];
    final horizontalEnemy = EnemyFlameComponent(
      position: Vector2(500, 500),
      moveDirection: EnemyMoveDirection.vertical,
    );
    flameEnemies.add(horizontalEnemy);
    add(horizontalEnemy);

    final verticalEnemy = EnemyFlameComponent(
      position: Vector2(300, 300),
      moveDirection: EnemyMoveDirection.horizontal,
    );

    flameEnemies.add(verticalEnemy);
    add(verticalEnemy);
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
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
