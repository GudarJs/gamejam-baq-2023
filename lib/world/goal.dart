import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Goal extends PositionComponent {
  Goal({required size, required position}) : super(size: size, position: position) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    add(RectangleHitbox());
  }

}
