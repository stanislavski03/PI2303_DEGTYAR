class Machine {
  int _coffeeBeans = 0;
  int _milk = 0;
  int _water = 0;
  int _cash = 0;

  int COFFEE_BEANS_AMOUNT = 50;
  int MILK_AMOUNT = 0;
  int WATER_AMOUNT = 100;

  Machine(this._coffeeBeans, this._milk, this._water, this._cash);

  int get coffeeBeans => _coffeeBeans;
  set coffeeBeans(int value) {
    if (value >= 0) {
      _coffeeBeans = value;
    }
  }

  int get milk => _milk;
  set milk(int value) {
    if (value >= 0) {
      _milk = value;
    }
  }

  int get water => _water;
  set water(int value) {
    if (value >= 0) {
      _water = value;
    }
  }

  int get cash => _cash;
  set cash(int value) {
    if (value >= 0) {
      _cash = value;
    }
  }

  bool isAvailableResources() {
    return (_coffeeBeans >= COFFEE_BEANS_AMOUNT) &&
        (_water >= WATER_AMOUNT) &&
        (_milk >= MILK_AMOUNT);
  }

  void _subtractResources() {
    _coffeeBeans -= 50;
    _water -= 100;
  }

  void makingCoffee() {
    if (isAvailableResources()) {
      _subtractResources();
      _cash += 150;
      print('Эспрессо готов');
    } else {
      print('Недостаточно ресурсов для приготовления эспрессо');
      print('Нужно: кофе - 50г, вода - 100мл');
      print('Есть: кофе - $_coffeeBeans г, вода - $_water мл');
    }
  }
}
