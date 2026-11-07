import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imagica/collectible.dart';
import 'package:imagica/goal.dart';

class Player extends PositionComponent
    with KeyboardHandler, CollisionCallbacks, HasGameRef {
  final VoidCallback onCollect;
  final VoidCallback onWin;

  Player({
    required Vector2 position,
    required this.onCollect,
    required this.onWin,
  }) : super(position: position, size: Vector2.all(80), anchor: Anchor.center);

  final double speed = 240;

  final Set<LogicalKeyboardKey> keysPressed = {};
  late SpriteSheet spriteSheet;

  SpriteAnimation? idleAnimation;
SpriteAnimation? upAnimation;
SpriteAnimation? downAnimation;
SpriteAnimation? sideAnimation;

SpriteAnimationComponent? animationComponent;

bool isMoving = false;

 @override
Future<void> onLoad() async {
  await super.onLoad();

  final image = await game.images.load('player/player.png');

  spriteSheet = SpriteSheet(
    image: image,
    srcSize: Vector2(64, 64),
  );

  // Row 0 = idle/front
  idleAnimation = spriteSheet.createAnimation(
    row: 0,
    from: 0,
    to: 6,
    stepTime: 0.15,
    loop: true,
  );

  // Change these ONLY if your sprite sheet has different rows.
  downAnimation = spriteSheet.createAnimation(
    row: 1,
    from: 0,
    to: 6,
    stepTime: 0.15,
    loop: true,
  );

  upAnimation = spriteSheet.createAnimation(
    row: 2,
    from: 0,
    to: 6,
    stepTime: 0.15,
    loop: true,
  );

  // Use one side animation and flip it for left/right.
  sideAnimation = spriteSheet.createAnimation(
    row: 3,
    from: 0,
    to: 6,
    stepTime: 0.15,
    loop: true,
  );

 animationComponent = SpriteAnimationComponent(
  animation: idleAnimation!,
  size: size,
  anchor: Anchor.center,
);

animationComponent!.position = size / 2;

  add(animationComponent!);
}


  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    this.keysPressed
      ..clear()
      ..addAll(keysPressed);

    return true;
  }

 @override
void update(double dt) {
  super.update(dt);

  final direction = Vector2.zero();

  if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
      keysPressed.contains(LogicalKeyboardKey.keyW)) {
    direction.y -= 1;
  }

  if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
      keysPressed.contains(LogicalKeyboardKey.keyS)) {
    direction.y += 1;
  }

  if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
      keysPressed.contains(LogicalKeyboardKey.keyA)) {
    direction.x -= 1;
  }

  if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
      keysPressed.contains(LogicalKeyboardKey.keyD)) {
    direction.x += 1;
  }

  // Not moving
  if (direction.length == 0) {
    animationComponent?.animation = idleAnimation!;
    return;
  }

  direction.normalize();

  position += direction * speed * dt;

  // -------------------------
 // ANIMATION DIRECTION
// -------------------------

if (direction.x < 0) {
  // LEFT
  animationComponent!.animation = sideAnimation!;
  animationComponent!.scale.x = -1;
} 
else if (direction.x > 0) {
  // RIGHT
  animationComponent!.animation = sideAnimation!;
  animationComponent!.scale.x = 1;
} 
else if (direction.y < 0) {
  // UP
  animationComponent!.animation = upAnimation!;
  animationComponent!.scale.x = 1;
} 
else if (direction.y > 0) {
  // DOWN
  animationComponent!.animation = downAnimation!;
  animationComponent!.scale.x = 1;
}
}
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Collectible) {
      other.removeFromParent();
      onCollect();
    }

    if (other is Goal) {
      onWin();
    }
  }
}
