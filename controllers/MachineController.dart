import '../models/Resources.dart';
import '../models/ICoffee.dart';
import '../models/Coffee.dart';
import '../models/Enums.dart';
import '../views/ConsoleView.dart';

class MachineController {
  Resources _resources;
  ConsoleView _view;

  MachineController(this._resources, this._view);

  void run() {
    bool isWorking = true;

    while (isWorking) {
      _view.showMenu();
      String? input = _view.getUserInput();

      switch (input) {
        case '1':
          makeCoffee(CoffeeType.espresso);
          break;
        case '2':
          makeCoffee(CoffeeType.americano);
          break;
        case '3':
          makeCoffee(CoffeeType.cappuccino);
          break;
        case '4':
          makeCoffee(CoffeeType.latte);
          break;
        case '5':
          addResources();
          break;
        case '6':
          _view.showResources(_resources);
          break;
        case '7':
          isWorking = false;
          _view.showMessage('Программа завершена');
          break;
        default:
          _view.showError('Неизвестная команда');
      }
    }
  }

  void makeCoffee(CoffeeType type) {
    ICoffee? coffee = createCoffee(type);

    if (coffee == null) {
      _view.showError('Ошибка создания кофе');
      return;
    }

    if (canMakeCoffee(coffee)) {
      _resources.coffeeBeans -= coffee.coffeeBeans();
      _resources.milk -= coffee.milk();
      _resources.water -= coffee.water();
      _resources.cash += coffee.cash();

      _view.showMessage('Ваш кофе готов!');
    } else {
      _view.showError('Недостаточно ресурсов');
      _view.showMessage('Нужно:');
      _view.showMessage('-Кофе: ${coffee.coffeeBeans()} г');
      _view.showMessage('-Молоко: ${coffee.milk()} мл');
      _view.showMessage('-Вода: ${coffee.water()} мл');
      _view.showResources(_resources);
    }
  }

  bool canMakeCoffee(ICoffee coffee) {
    return (_resources.coffeeBeans >= coffee.coffeeBeans()) &&
        (_resources.milk >= coffee.milk()) &&
        (_resources.water >= coffee.water());
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

  void addResources() {
    var data = _view.getAddResourcesInput();
    _resources.coffeeBeans += data['coffee']!;
    _resources.milk += data['milk']!;
    _resources.water += data['water']!;
    _resources.cash += data['cash']!;

    _view.showMessage('Ресурсы добавлены');
    _view.showResources(_resources);
  }
}
