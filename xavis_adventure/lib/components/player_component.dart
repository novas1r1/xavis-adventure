import 'package:flame/components.dart';

enum MoveDirection {
  right,
  left,
  up,
  down,
}

enum MovingState {
  idle,
  left,
  right,
  up,
  down,
}

const _moving_animation_step_time = 0.1;
const _moving_distance = 50.0;
const _moving_steps = 10;
const _moving_duration_per_step_ms = 500;

class PlayerComponent extends SpriteAnimationGroupComponent {
  final Vector2 position;

  PlayerComponent({
    required this.position,
  }) : super(position: position, animations: {}) {
    anchor = Anchor.center;
  }

  @override
  Future<void>? onLoad() async {
    size = Vector2.all(50.0);
    await _loadMovingAnimation();
    return super.onLoad();
  }

  Future<void> _loadMovingAnimation() async {
    final idleAnimation = await _loadIdleAnimation();
    final rightAnimation = await _loadRightAnimation();
    final leftAnimation = await _loadLeftAnimation();
    final downAnimation = await _loadDownAnimation();
    final upAnimation = await _loadUpAnimation();
    animations = {
      MovingState.idle: idleAnimation,
      MovingState.right: rightAnimation,
      MovingState.left: leftAnimation,
      MovingState.down: downAnimation,
      MovingState.up: upAnimation,
    };
    current = MovingState.idle;
  }

  Future<SpriteAnimation> _loadIdleAnimation() async {
    final idleSprite = await Sprite.load('player/player_dryer.png');
    return SpriteAnimation.spriteList([idleSprite], stepTime: 1.0);
  }

  Future<SpriteAnimation> _loadRightAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_right.png');
    final spriteWalk = await Sprite.load('player/player_dryer_walk_right.png');
    return SpriteAnimation.spriteList(
      [sprite, spriteWalk],
      stepTime: _moving_animation_step_time,
    );
  }

  Future<SpriteAnimation> _loadLeftAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_left.png');
    final spriteWalk = await Sprite.load('player/player_dryer_walk_left.png');
    return SpriteAnimation.spriteList(
      [sprite, spriteWalk],
      stepTime: _moving_animation_step_time,
    );
  }

  Future<SpriteAnimation> _loadDownAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_down.png');
    final spriteWalk = await Sprite.load('player/player_dryer_walk_down.png');
    return SpriteAnimation.spriteList(
      [sprite, spriteWalk],
      stepTime: _moving_animation_step_time,
    );
  }

  Future<SpriteAnimation> _loadUpAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_up.png');
    final spriteWalk = await Sprite.load('player/player_dryer_walk_up.png');
    return SpriteAnimation.spriteList(
      [sprite, spriteWalk],
      stepTime: _moving_animation_step_time,
    );
  }

  void move(MoveDirection direction) {
    switch (direction) {
      case MoveDirection.right:
        current = MovingState.right;
        final vectorStep = Vector2(_moving_distance / _moving_steps, 0);
        _move(vectorStep);
        break;
      case MoveDirection.left:
        current = MovingState.left;
        final vectorStep = Vector2(-1 * (_moving_distance / _moving_steps), 0);
        _move(vectorStep);
        break;
      case MoveDirection.up:
        current = MovingState.up;
        final vectorStep = Vector2(0, -1 * (_moving_distance / _moving_steps));
        _move(vectorStep);
        break;
      case MoveDirection.down:
        current = MovingState.down;
        final vectorStep = Vector2(0, _moving_distance / _moving_steps);
        _move(vectorStep);
        break;
    }
  }

  Future<void> _move(Vector2 vectorStep) async {
    final stepDurationMs = _moving_duration_per_step_ms ~/ _moving_steps;

    Stream.periodic(Duration(milliseconds: stepDurationMs), (v) => v + 1)
        .take(_moving_steps)
        .listen((step) {
      if (step >= _moving_steps) {
        current = MovingState.idle;
      } else {
        position += vectorStep;
      }
    });
  }
}
