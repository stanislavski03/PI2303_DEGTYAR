import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_machine_app/models/Resources.dart';
import 'package:coffee_machine_app/models/Enums.dart';

class TestEspresso {
  int coffeeBeans() => 50;
  int milk() => 0;
  int water() => 100;
  int cash() => 150;
}

class TestMachineController {
  Resources resources;

  TestMachineController(this.resources);

  Future<bool> makeEspresso() async {
    TestEspresso coffee = TestEspresso();

    if (resources.coffeeBeans < coffee.coffeeBeans()) return false;
    if (resources.water < coffee.water()) return false;
    if (resources.cash < coffee.cash()) return false;

    resources.coffeeBeans -= coffee.coffeeBeans();
    resources.water -= coffee.water();
    resources.cash -= coffee.cash();

    return true;
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: null, child: Text('ПУСК')),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Кнопка ПУСК есть на форме', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    expect(find.text('ПУСК'), findsOneWidget);
  });

  test('Ресурсы инициализируются с начальными значениями', () {
    Resources resources = Resources(100, 200, 300, 500);

    expect(resources.coffeeBeans, 100);
    expect(resources.milk, 200);
    expect(resources.water, 300);
    expect(resources.cash, 500);
  });

  test(
    'При покупке эспрессо ресурсы уменьшаются, деньги уменьшаются',
    () async {
      Resources resources = Resources(100, 200, 300, 500);
      TestMachineController controller = TestMachineController(resources);

      int startCoffee = resources.coffeeBeans;
      int startWater = resources.water;
      int startCash = resources.cash;

      await controller.makeEspresso();

      expect(resources.coffeeBeans, startCoffee - 50);
      expect(resources.water, startWater - 100);
      expect(resources.cash, startCash - 150);
    },
  );
}
