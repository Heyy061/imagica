import 'package:flame/events.dart' show HasKeyboardHandlerComponents;
import 'package:flame/game.dart';
import 'package:flame/components.dart';

import 'player.dart';
import 'collectible.dart';
import 'goal.dart';

class PhotoGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late Player player;
 
  late TextComponent scoreText;
  int score = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // BACKGROUND
    final backgroundImage = await images.load('environments/background.png');

    add(
      SpriteComponent(
        sprite: Sprite(backgroundImage),
        size: size,
        position: Vector2.zero(),
        priority: -100,
      ),
    );

    // SCORE
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      priority: 100,
    );

    add(scoreText);

    // PLAYER
    player = Player(
      position: Vector2(100, 200),
      onCollect: () {
        score++;
        scoreText.text = 'Score: $score';
      },
      onWin: () {
        print('🎉 YOU WIN!');
      },
    );

   
    add(player);
   
  }
}
