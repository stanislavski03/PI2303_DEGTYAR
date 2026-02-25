import 'dart:io';
import 'classes/Machine.dart';

void main() {
  Machine machine = Machine(100, 200, 300, 500);

  print('ПРОГРАММА УПРАВЛЕНИЯ КОФЕМАШИНОЙ');

  bool isWorking = true;

  while (isWorking) {
    print('\nДоступные команды:');
    print('1 - Приготовить эспрессо');
    print('2 - Добавить ресурсы');
    print('3 - Выйти из программы');

    stdout.write('Введите команду: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        machine.makingCoffee();
        break;

      case '2':
        print('\nДОБАВЛЕНИЕ РЕСУРСОВ');
        stdout.write('Введите количество кофейных зерен (г): ');
        int coffee = int.parse(stdin.readLineSync() ?? '0');

        stdout.write('Введите количество молока (мл): ');
        int milk = int.parse(stdin.readLineSync() ?? '0');

        stdout.write('Введите количество воды (мл): ');
        int water = int.parse(stdin.readLineSync() ?? '0');

        machine.coffeeBeans += coffee;
        machine.milk += milk;
        machine.water += water;
        break;

      case '3':
        isWorking = false;
        break;

      default:
        print('Неизвестная команда');
    }
  }
}
