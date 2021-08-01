import 'package:flame/game.dart';
import 'package:flame/layers.dart';
import 'package:flame/sprite.dart';

class BackgroundLayer extends PreRenderedLayer {
  final Sprite spriteBg;
  final Sprite spriteBgBox;

  BackgroundLayer(this.spriteBg, this.spriteBgBox) : super();

  @override
  void drawLayer() {
    spriteBg.render(canvas, position: Vector2(0, 0));
    spriteBgBox.render(canvas, position: Vector2(50, 200));
  }
}
