import 'dart:async';

class CoffeeMaker {
  Future<void> heatWater() async {
    print('Нагрев воды...');
    await Future.delayed(Duration(seconds: 3));
    print('Вода нагрета');
  }
}
