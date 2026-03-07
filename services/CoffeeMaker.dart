import 'dart:async';

class CoffeeMaker {
  CoffeeMaker() {
    print('Инициализация кофемашины...');
  }

  factory CoffeeMaker.create() {
    print('Создание кофемашины через фабричный метод');
    return CoffeeMaker();
  }

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

  Future<void> frothMilk() async {
    print('Взбивание молока...');
    await Future.delayed(Duration(seconds: 5));
    print('Молоко взбито');
  }

  Future<void> mixCoffeeAndMilk() async {
    print('Смешивание кофе с молоком...');
    await Future.delayed(Duration(seconds: 3));
    print('Кофе смешан с молоком');
  }
}
