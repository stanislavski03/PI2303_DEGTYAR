import 'dart:io';
import 'classes/Machine.dart';
import 'classes/Resources.dart';
import 'classes/Enums.dart';

void main() {
  Resources resources = Resources(100, 200, 300, 500);
  Machine machine = Machine(resources);

  print('ПРОГРАММА УПРАВЛЕНИЯ КОФЕМАШИНОЙ');

  bool isWorking = true;

  while (isWorking) {
    print('\nДоступные команды:');
    print('1 - Приготовить эспрессо');
    print('2 - Приготовить американо');
    print('3 - Приготовить капучино');
    print('4 - Приготовить латте');
    print('5 - Добавить ресурсы');
    print('6 - Выйти из программы');

    stdout.write('Введите команду: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        machine.makeCoffeeByType(CoffeeType.espresso);
        break;

      case '2':
        machine.makeCoffeeByType(CoffeeType.americano);
        break;

      case '3':
        machine.makeCoffeeByType(CoffeeType.cappuccino);
        break;

      case '4':
        machine.makeCoffeeByType(CoffeeType.latte);
        break;

      case '5':
        print('\nДОБАВЛЕНИЕ РЕСУРСОВ');
        stdout.write('Введите количество кофейных зерен (г): ');
        int coffee = int.parse(stdin.readLineSync() ?? '0');

        stdout.write('Введите количество молока (мл): ');
        int milk = int.parse(stdin.readLineSync() ?? '0');

        stdout.write('Введите количество воды (мл): ');
        int water = int.parse(stdin.readLineSync() ?? '0');

        stdout.write('Введите количество денег (руб): ');
        int cash = int.parse(stdin.readLineSync() ?? '0');

        machine.fillResources(coffee, milk, water, cash);
        break;

      case '6':
        isWorking = false;
        print('Программа завершена');
        break;

      default:
        print('Неизвестная команда');
    }
  }
}
