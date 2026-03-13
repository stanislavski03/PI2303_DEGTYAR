import '../models/Resources.dart';
import '../models/ICoffee.dart';
import '../models/Coffee.dart';
import '../models/Enums.dart';
import '../services/CoffeeMaker.dart';

class MachineController {
  Resources _resources;
  CoffeeMaker _coffeeMaker;

  MachineController(this._resources, this._coffeeMaker);

  bool canMakeCoffee(ICoffee coffee) {
    return (_resources.coffeeBeans >= coffee.coffeeBeans()) &&
        (_resources.milk >= coffee.milk()) &&
        (_resources.water >= coffee.water()) &&
        (_resources.cash >= coffee.cash());
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

  Future<bool> makeCoffee(
    CoffeeType type,
    Function(String) onStatusUpdate,
  ) async {
    ICoffee? coffee = createCoffee(type);

    if (coffee == null) return false;

    if (!canMakeCoffee(coffee)) {
      onStatusUpdate('Недостаточно ресурсов');
      return false;
    }

    _resources.coffeeBeans -= coffee.coffeeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();
    _resources.cash -= coffee.cash();

    await _coffeeMaker.heatWater();

    if (type == CoffeeType.espresso || type == CoffeeType.americano) {
      await _coffeeMaker.brewCoffee();
    } else {
      await Future.wait([_coffeeMaker.brewCoffee(), _coffeeMaker.frothMilk()]);
      await _coffeeMaker.mixCoffeeAndMilk();
    }

    return true;
  }
}
