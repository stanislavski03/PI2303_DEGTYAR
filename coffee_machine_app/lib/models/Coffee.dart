import 'ICoffee.dart';

class Espresso implements ICoffee {
  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 100;

  @override
  int cash() => 150;
}

class Americano implements ICoffee {
  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 150;

  @override
  int cash() => 180;
}

class Cappuccino implements ICoffee {
  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 100;

  @override
  int water() => 100;

  @override
  int cash() => 200;
}

class Latte implements ICoffee {
  @override
  int coffeeBeans() => 50;

  @override
  int milk() => 200;

  @override
  int water() => 100;

  @override
  int cash() => 250;
}
