import 'dart:io';
import '../models/Resources.dart';

class ConsoleView {
  void showMenu() {
    print('\n--- МЕНЮ ---');
    print('1. Эспрессо');
    print('2. Американо');
    print('3. Капучино');
    print('4. Латте');
    print('5. Добавить ресурсы');
    print('6. Состояние');
    print('7. Выход');
  }

  String? getUserInput() {
    stdout.write('Выберите пункт: ');
    return stdin.readLineSync();
  }

  void showMessage(String message) {
    print(message);
  }

  void showError(String message) {
    print('Ошибка: $message');
  }

  void showResources(Resources res) {
    print('\n--- РЕСУРСЫ ---');
    print('Кофе: ${res.coffeeBeans} г');
    print('Молоко: ${res.milk} мл');
    print('Вода: ${res.water} мл');
    print('Деньги: ${res.cash} руб');
  }

  Map<String, int> getAddResourcesInput() {
    print('\n--- ДОБАВЛЕНИЕ РЕСУРСОВ ---');

    stdout.write('Кофе (г): ');
    int coffee = int.parse(stdin.readLineSync() ?? '0');

    stdout.write('Молоко (мл): ');
    int milk = int.parse(stdin.readLineSync() ?? '0');

    stdout.write('Вода (мл): ');
    int water = int.parse(stdin.readLineSync() ?? '0');

    stdout.write('Деньги (руб): ');
    int cash = int.parse(stdin.readLineSync() ?? '0');

    return {'coffee': coffee, 'milk': milk, 'water': water, 'cash': cash};
  }
}
