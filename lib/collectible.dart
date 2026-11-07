import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Collectible extends PositionComponent
    with CollisionCallbacks {
  Collectible({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(30),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      CircleHitbox(),
    );
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.amber;

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
}