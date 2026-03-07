import 'dart:async';

class CoffeeMaker {
  Future<void> heatWater() async {
    print('Нагрев воды...');
    await Future.delayed(Duration(seconds: 3));
    print('Вода нагрета');
  }

  Future<void> brewCoffee() async {
    print('Заваривание кофе...');
    await Future.delayed(Duration(seconds: 5));
    print('Кофе заварен');
  }
}
