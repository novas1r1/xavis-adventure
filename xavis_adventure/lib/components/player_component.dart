import 'package:flame/components.dart';

enum MoveDirection {
  right,
  left,
  up,
  down,
}

class PlayerComponent extends SpriteAnimationComponent {
  final Vector2 position;

  PlayerComponent({
    required this.position,
  }) : super(position: position) {
    anchor = Anchor.center;
  }

  late SpriteAnimation _walkDownAnimation;
  late SpriteAnimation _walkUpAnimation;
  late SpriteAnimation _walkRightAnimation;
  late SpriteAnimation _walkLeftAnimation;

  @override
  Future<void>? onLoad() async {
    size = Vector2.all(50.0);
    final sprite = await Sprite.load('player/player_dryer.png');

    animation = await SpriteAnimation.spriteList(
      [sprite],
      stepTime: 1.0,
    );

    // animation walking right
    final spriteRight = await Sprite.load('player/player_dryer_right.png');
    final spriteWalkRight =
        await Sprite.load('player/player_dryer_walk_right.png');

    _walkRightAnimation = await SpriteAnimation.spriteList(
      [spriteRight, spriteWalkRight],
      stepTime: 0.1,
    );

    // animation walking left
    // final spriteLeft = await Sprite.load('player/player_dryer_left.png');
    // final spriteWalkLeft =
    //     await Sprite.load('player/player_dryer_walk_left.png');

    // // animation walking down
    // final spriteDown = await Sprite.load('player/player_dryer_down.png');
    // final spriteWalkDown =
    //     await Sprite.load('player/player_dryer_walk_down.png');

    // // animation walking up
    // final spriteUp = await Sprite.load('player/player_dryer_up.png');
    // final spriteWalkUp = await Sprite.load('player/player_dryer_walk_up.png');
    return super.onLoad();
  }

  void move(MoveDirection direction) {
    switch (direction) {
      case MoveDirection.right:
        position += Vector2(50, 0);
        animation = _walkRightAnimation;
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
