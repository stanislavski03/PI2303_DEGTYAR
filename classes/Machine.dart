import 'Resources.dart';
import 'ICoffee.dart';
import 'Coffee.dart';
import 'Enums.dart';

class Machine {
  Resources _resources;

  Machine(this._resources);

  void fillResources(int coffee, int milk, int water, int cash) {
    _resources.coffeeBeans += coffee;
    _resources.milk += milk;
    _resources.water += water;
    _resources.cash += cash;
  }

  bool isAvailableResources(ICoffee coffee) {
    return (_resources.coffeeBeans >= coffee.coffeeBeans()) &&
        (_resources.milk >= coffee.milk()) &&
        (_resources.water >= coffee.water());
  }

  void _makeCoffee(ICoffee coffee) {
    _resources.coffeeBeans -= coffee.coffeeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();
    _resources.cash += coffee.cash();
  }

  void makeCoffeeByType(CoffeeType type) {
    ICoffee? coffee;

    switch (type) {
      case CoffeeType.espresso:
        coffee = Espresso();
        break;
      case CoffeeType.americano:
        coffee = Americano();
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        break;
      case CoffeeType.latte:
        coffee = Latte();
        break;
    }

    if (isAvailableResources(coffee)) {
      _makeCoffee(coffee);
      print('Ваш кофе готов');
    } else {
      print('Недостаточно ресурсов для ${type.toString().toUpperCase()}');
      print(
        'Нужно: кофе - ${coffee.coffeeBeans()}г, молоко - ${coffee.milk()}мл, вода - ${coffee.water()}мл',
      );
      print(
        'Есть: кофе - ${_resources.coffeeBeans}г, молоко - ${_resources.milk}мл, вода - ${_resources.water}мл',
      );
    }
  }
}
