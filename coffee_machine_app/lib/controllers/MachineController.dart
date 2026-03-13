import '../models/Resources.dart';
import '../models/ICoffee.dart';
import '../models/Coffee.dart';
import '../models/Enums.dart';
import '../services/CoffeeMaker.dart';
import '../services/NotificationService.dart';

class MachineController {
  Resources _resources;
  CoffeeMaker _coffeeMaker;
  late NotificationService _notifications;

  MachineController(this._resources, this._coffeeMaker) {
    _notifications = NotificationService();
  }

  bool canMakeCoffee(ICoffee coffee) {
    if (_resources.coffeeBeans < coffee.coffeeBeans()) {
      _notifications.showError('Недостаточно кофе');
      return false;
    }
    if (_resources.milk < coffee.milk()) {
      _notifications.showError('Недостаточно молока');
      return false;
    }
    if (_resources.water < coffee.water()) {
      _notifications.showError('Недостаточно воды');
      return false;
    }
    if (_resources.cash < coffee.cash()) {
      _notifications.showError('Недостаточно денег');
      return false;
    }
    return true;
  }

  ICoffee? createCoffee(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return Espresso();
      case CoffeeType.americano:
        return Americano();
      case CoffeeType.cappuccino:
        return Cappuccino();
      case CoffeeType.latte:
        return Latte();
    }
  }

  Future<bool> makeCoffee(CoffeeType type) async {
    ICoffee? coffee = createCoffee(type);

    if (coffee == null) {
      _notifications.showError('Ошибка создания кофе');
      return false;
    }

    if (!canMakeCoffee(coffee)) return false;

    _resources.coffeeBeans -= coffee.coffeeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();
    _resources.cash -= coffee.cash();

    try {
      await _coffeeMaker.heatWater(
        onStatus: (msg) => _notifications.showProgress(msg),
      );

      if (type == CoffeeType.espresso || type == CoffeeType.americano) {
        await _coffeeMaker.brewCoffee(
          onStatus: (msg) => _notifications.showProgress(msg),
        );
      } else {
        await Future.wait([
          _coffeeMaker.brewCoffee(
            onStatus: (msg) => _notifications.showProgress(msg),
          ),
          _coffeeMaker.frothMilk(
            onStatus: (msg) => _notifications.showProgress(msg),
          ),
        ]);
        await _coffeeMaker.mixCoffeeAndMilk(
          onStatus: (msg) => _notifications.showProgress(msg),
        );
      }

      _notifications.showSuccess('${type.toString().toUpperCase()} готов!');
      return true;
    } catch (e) {
      _notifications.showError('Ошибка приготовления');
      return false;
    }
  }

  void addResources(int coffee, int milk, int water, int cash) {
    _resources.coffeeBeans += coffee;
    _resources.milk += milk;
    _resources.water += water;
    _resources.cash += cash;
    _notifications.showSuccess('Ресурсы добавлены');
  }
}
