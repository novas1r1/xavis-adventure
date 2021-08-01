import 'package:flame/components.dart';

enum MoveDirection {
  right,
  left,
  up,
  down,
}

enum MovingState {
  idle,
  idleLeft,
  idleRight,
  idleUp,
  idleDown,
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
  }) : super(
          position: position,
          animations: {}, // requires initial set, can be empty and set later as well
        ) {
    anchor = Anchor.center;
  }

  bool get _isMoving => ![
        MovingState.idle,
        MovingState.idleDown,
        MovingState.idleLeft,
        MovingState.idleRight,
        MovingState.idleUp
      ].contains(current);

  @override
  Future<void>? onLoad() async {
    size = Vector2.all(50.0);
    await _loadMovingAnimation();
    return super.onLoad();
  }

  Future<void> _loadMovingAnimation() async {
    final idleAnimation = await _loadIdleAnimation();

    final rightAnimation = await _loadRightAnimation();
    final idleRightAnimation = await _loadIdleRightAnimation();
    final leftAnimation = await _loadLeftAnimation();
    final idleLeftAnimation = await _loadIdleLeftAnimation();
    final downAnimation = await _loadDownAnimation();
    final idleDownAnimation = await _loadIdleDownAnimation();
    final upAnimation = await _loadUpAnimation();
    final idleUpAnimation = await _loadIdleUpAnimation();

    animations = {
      MovingState.idle: idleAnimation,
      MovingState.right: rightAnimation,
      MovingState.idleRight: idleRightAnimation,
      MovingState.left: leftAnimation,
      MovingState.idleLeft: idleLeftAnimation,
      MovingState.down: downAnimation,
      MovingState.idleDown: idleDownAnimation,
      MovingState.up: upAnimation,
      MovingState.idleUp: idleUpAnimation,
    };

    current = MovingState.idle;
  }

  void move(MoveDirection direction) {
    if (_isMoving) {
      return;
    }
    switch (direction) {
      case MoveDirection.right:
        current = MovingState.right;
        final vectorStep = Vector2(_moving_distance / _moving_steps, 0);
        _move(vectorStep, MoveDirection.right);
        break;
      case MoveDirection.left:
        current = MovingState.left;
        final vectorStep = Vector2(-1 * (_moving_distance / _moving_steps), 0);
        _move(vectorStep, MoveDirection.left);
        break;
      case MoveDirection.up:
        current = MovingState.up;
        final vectorStep = Vector2(0, -1 * (_moving_distance / _moving_steps));
        _move(vectorStep, MoveDirection.up);
        break;
      case MoveDirection.down:
        current = MovingState.down;
        final vectorStep = Vector2(0, _moving_distance / _moving_steps);
        _move(vectorStep, MoveDirection.down);
        break;
    }
  }

  Future<void> _move(Vector2 vectorStep, MoveDirection direction) async {
    // calculate ms for each step
    final stepDurationMs = _moving_duration_per_step_ms ~/ _moving_steps;

    // per step, move the player
    Stream.periodic(Duration(milliseconds: stepDurationMs), (v) => v + 1)
        .take(_moving_steps)
        .listen((step) {
      if (step >= _moving_steps) {
        switch (direction) {
          case MoveDirection.right:
            current = MovingState.idleRight;
            break;
          case MoveDirection.left:
            current = MovingState.idleLeft;
            break;
          case MoveDirection.up:
            current = MovingState.idleUp;
            break;
          case MoveDirection.down:
            current = MovingState.idleDown;
            break;
          default:
            current = MovingState.idle;
            break;
        }
      } else {
        position += vectorStep;
      }
    });
  }

  Future<SpriteAnimation> _loadIdleAnimation() async {
    final idleSprite = await Sprite.load('player/player_dryer.png');
    return SpriteAnimation.spriteList([idleSprite], stepTime: 1.0);
  }

  Future<SpriteAnimation> _loadIdleRightAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_right.png');
    return SpriteAnimation.spriteList(
      [sprite],
      stepTime: _moving_animation_step_time,
    );
  }

  Future<SpriteAnimation> _loadRightAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_right.png');
    final spriteWalk = await Sprite.load('player/player_dryer_walk_right.png');
    return SpriteAnimation.spriteList(
      [sprite, spriteWalk],
      stepTime: _moving_animation_step_time,
    );
  }

  Future<SpriteAnimation> _loadIdleLeftAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_left.png');
    return SpriteAnimation.spriteList(
      [sprite],
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

  Future<SpriteAnimation> _loadIdleDownAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_down.png');
    return SpriteAnimation.spriteList(
      [sprite],
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

  Future<SpriteAnimation> _loadIdleUpAnimation() async {
    final sprite = await Sprite.load('player/player_dryer_up.png');
    return SpriteAnimation.spriteList(
      [sprite],
      stepTime: _moving_animation_step_time,
    );
  }
}
