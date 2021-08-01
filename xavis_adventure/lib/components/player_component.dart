import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:xavis_adventure/components/enemy_flame_component.dart';

enum MoveDirection {
  right,
  left,
  up,
  down,
}

enum PlayerState {
  idle,
  idleLeft,
  idleRight,
  idleUp,
  idleDown,
  walkLeft,
  walkRight,
  walkUp,
  walkDown,
  die,
}

const _moving_animation_step_time = 0.1;
const _moving_distance = 50.0;
const _moving_steps = 10;
const _moving_duration_per_step_ms = 500;

class PlayerComponent extends SpriteAnimationGroupComponent
    with Hitbox, Collidable {
  Vector2 _initialPlayerPosition = Vector2(125, 275);
  final respawnTimer = Timer(2);

  // requires initial set, can be empty and set later as well
  PlayerComponent() : super(animations: {}) {
    anchor = Anchor.center;
  }

  bool get _isMoving => ![
        PlayerState.idle,
        PlayerState.idleDown,
        PlayerState.idleLeft,
        PlayerState.idleRight,
        PlayerState.idleUp,
        PlayerState.die,
      ].contains(current);

  @override
  Future<void>? onLoad() async {
    size = Vector2.all(50.0);
    position = _initialPlayerPosition;
    await _loadMovingAnimation();

    addShape(HitboxRectangle());

    return super.onLoad();
  }

  Future<void> _loadMovingAnimation() async {
    final idleAnimation = await _loadIdleAnimation();
    final idleRightAnimation = await _loadIdleRightAnimation();
    final idleLeftAnimation = await _loadIdleLeftAnimation();
    final idleDownAnimation = await _loadIdleDownAnimation();
    final idleUpAnimation = await _loadIdleUpAnimation();

    final rightAnimation = await _loadRightAnimation();
    final leftAnimation = await _loadLeftAnimation();
    final downAnimation = await _loadDownAnimation();
    final upAnimation = await _loadUpAnimation();

    final dieAnimation = await _loadDieAnimation();

    animations = {
      // idle
      PlayerState.idle: idleAnimation,
      PlayerState.idleRight: idleRightAnimation,
      PlayerState.idleLeft: idleLeftAnimation,
      PlayerState.idleDown: idleDownAnimation,
      PlayerState.idleUp: idleUpAnimation,
      // walk
      PlayerState.walkRight: rightAnimation,
      PlayerState.walkLeft: leftAnimation,
      PlayerState.walkDown: downAnimation,
      PlayerState.walkUp: upAnimation,
      // other
      PlayerState.die: dieAnimation,
    };

    current = PlayerState.idle;
  }

  void move(MoveDirection direction) {
    if (_isMoving) {
      return;
    }
    switch (direction) {
      case MoveDirection.right:
        current = PlayerState.walkRight;
        final vectorStep = Vector2(_moving_distance / _moving_steps, 0);
        _move(vectorStep, MoveDirection.right);
        break;
      case MoveDirection.left:
        current = PlayerState.walkLeft;
        final vectorStep = Vector2(-1 * (_moving_distance / _moving_steps), 0);
        _move(vectorStep, MoveDirection.left);
        break;
      case MoveDirection.up:
        current = PlayerState.walkUp;
        final vectorStep = Vector2(0, -1 * (_moving_distance / _moving_steps));
        _move(vectorStep, MoveDirection.up);
        break;
      case MoveDirection.down:
        current = PlayerState.walkDown;
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
            current = PlayerState.idleRight;
            break;
          case MoveDirection.left:
            current = PlayerState.idleLeft;
            break;
          case MoveDirection.up:
            current = PlayerState.idleUp;
            break;
          case MoveDirection.down:
            current = PlayerState.idleDown;
            break;
          default:
            current = PlayerState.idle;
            break;
        }
      } else {
        position += vectorStep;
      }
    });
  }

  @override
  void update(double dt) {
    // TODO fix: when player dies, wait for 2 seconds -> respawn
    // Currently not working using timer
    if (current == PlayerState.die && position != _initialPlayerPosition) {
      respawnTimer.start();
      if (respawnTimer.finished) {
        position = _initialPlayerPosition;
      }
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is EnemyFlameComponent) {
      playerDies();
    }
  }

  void playerDies() {
    log('PLAYER DIED');
    current = PlayerState.die;
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

  Future<SpriteAnimation> _loadDieAnimation() async {
    final sprite = await Sprite.load('player/player_dead.png');
    return SpriteAnimation.spriteList(
      [sprite],
      stepTime: _moving_animation_step_time,
    );
  }
}
