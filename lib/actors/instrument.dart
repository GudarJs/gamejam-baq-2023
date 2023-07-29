import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Instrument extends PositionComponent {
  Instrument() : super() {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }

}
