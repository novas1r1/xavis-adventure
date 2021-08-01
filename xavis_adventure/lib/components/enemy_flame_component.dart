import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:xavis_adventure/components/player_component.dart';

enum EnemyMoveDirection {
  vertical,
  horizontal,
}

class EnemyFlameComponent extends SpriteAnimationComponent
    with Hitbox, Collidable {
  static const double speed = 100.0;

  final Vector2 position;
  final EnemyMoveDirection moveDirection;

  EnemyFlameComponent({
    required this.position,
    required this.moveDirection,
  }) : super(position: position);

  late EnemyMoveDirection currentDirection;
  late bool _moveForward;

  @override
  Future<void>? onLoad() async {
    currentDirection = moveDirection;

    size = Vector2.all(50.0);

    animation = await _loadAnimation();
    _moveForward = false;
    addShape(HitboxRectangle());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    switch (moveDirection) {
      case EnemyMoveDirection.vertical:
        if (_moveForward) {
          position.y += dt * speed;
        } else {
          position.y -= dt * speed;
        }
        break;
      case EnemyMoveDirection.horizontal:
        if (_moveForward) {
          position.x += dt * speed;
        } else {
          position.x -= dt * speed;
        }
        break;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is ScreenCollidable) {
      log('CRASH');
      _moveForward = !_moveForward;
    } else if (other is PlayerComponent) {
      // TODO
      log('CRASH');
    }
  }

  Future<SpriteAnimation> _loadAnimation() async {
    final sprite1 = await Sprite.load('enemies/flames/flame_1.png');
    final sprite2 = await Sprite.load('enemies/flames/flame_2.png');
    final sprite3 = await Sprite.load('enemies/flames/flame_3.png');
    return SpriteAnimation.spriteList(
      [sprite1, sprite2, sprite3],
      stepTime: 0.1,
    );
  }
}
