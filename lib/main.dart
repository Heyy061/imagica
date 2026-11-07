import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: PhotoGame(),
        ),
      ),
    ),
  );
}