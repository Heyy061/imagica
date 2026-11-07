import 'package:flame/events.dart' show HasKeyboardHandlerComponents;
import 'package:flame/game.dart';
import 'package:flame/components.dart';

import 'player.dart';
import 'collectible.dart';
import 'goal.dart';

class PhotoGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late Player player;
 late SpriteComponent background;
  late TextComponent scoreText;
  int score = 0;

@override
Future<void> onLoad() async {
  await super.onLoad();

  // BACKGROUND
  final backgroundImage =
      await images.load('environments/background1.png');

  final background = SpriteComponent(
    sprite: Sprite(backgroundImage),
    position: Vector2.zero(),
    size: size,
    priority: -100,
  );

  add(background);

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
      // win logic
    },
  );

  add(player);
}

@override
void onGameResize(Vector2 gameSize) {
  super.onGameResize(gameSize);

  if (isLoaded) {
    background.size = gameSize;
  }
}
}
