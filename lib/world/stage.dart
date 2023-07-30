import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Stage extends PositionComponent {
  Stage({required size, required position})
      : super(size: size, position: position) {
    debugMode = false;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }
}
