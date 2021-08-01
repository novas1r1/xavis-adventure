import 'package:flame/components.dart';

enum MoveDirection {
  right,
  left,
  up,
  down,
}

class PlayerComponent extends SpriteComponent {
  final Vector2 position;
  final Vector2 size;
  final Sprite sprite;

  PlayerComponent({
    required this.position,
    required this.size,
    required this.sprite,
  }) : super(position: position, size: size, sprite: sprite) {
    anchor = Anchor.center;
  }

  void move(MoveDirection direction) {
    switch (direction) {
      case MoveDirection.right:
        position += Vector2(50, 0);
        break;
      case MoveDirection.left:
        position += Vector2(-50, 0);
        break;
      case MoveDirection.up:
        position += Vector2(0, -50);
        break;
      case MoveDirection.down:
        position += Vector2(0, 50);
        break;
    }
  }
}
