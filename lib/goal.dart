import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Goal extends PositionComponent with CollisionCallbacks {
  Goal({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(50),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.green;

    canvas.drawRect(
      size.toRect(),
      paint,
    );
  }
}