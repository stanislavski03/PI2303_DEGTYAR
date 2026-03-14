import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/Enums.dart';
import '../models/ICoffee.dart';
import '../services/NotificationService.dart';
import '../widgets/resource_display.dart';

class CoffeeMachineScreen extends StatefulWidget {
  const CoffeeMachineScreen({super.key});

  @override
  State<CoffeeMachineScreen> createState() => _CoffeeMachineScreenState();
}

class _CoffeeMachineScreenState extends State<CoffeeMachineScreen> {
  late AppState _appState;
  late NotificationService _notifications;
  int selectedCoffee =
      0; // 0 - эспрессо, 1 - американо, 2 - капучино, 3 - латте
  bool isMakingCoffee = false;

  final TextEditingController _moneyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _notifications = NotificationService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifications.setContext(context);
    });
  }

  CoffeeType _getCoffeeTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return CoffeeType.espresso;
      case 1:
        return CoffeeType.americano;
      case 2:
        return CoffeeType.cappuccino;
      case 3:
        return CoffeeType.latte;
      default:
        return CoffeeType.espresso;
    }
  }

  String _getCoffeeName(int index) {
    switch (index) {
      case 0:
        return 'Эспрессо';
      case 1:
        return 'Американо';
      case 2:
        return 'Капучино';
      case 3:
        return 'Латте';
      default:
        return 'Кофе';
    }
  }

  int _getCoffeePrice(int index) {
    ICoffee? coffee = _appState.controller.createCoffee(
      _getCoffeeTypeFromIndex(index),
    );
    return coffee?.cash() ?? 0;
  }

  Future<void> _makeCoffee() async {
    if (isMakingCoffee) return;

    setState(() {
      isMakingCoffee = true;
    });

    CoffeeType type = _getCoffeeTypeFromIndex(selectedCoffee);

    bool success = await _appState.controller.makeCoffee(type);

    setState(() {
      isMakingCoffee = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _notifications.setContext(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResourceDisplay(
                  coffeeBeans: _appState.resources.coffeeBeans,
                  milk: _appState.resources.milk,
                  water: _appState.resources.water,
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'COFFEE MAKER',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[200],
                  child: Center(
                    child: Text('Ваши деньги: ${_appState.resources.cash} руб'),
                  ),
                ),

                const SizedBox(height: 20),

                const Text('Выберите кофе:'),

                _buildCoffeeOption(0, 'Эспрессо - ${_getCoffeePrice(0)} руб'),
                _buildCoffeeOption(1, 'Американо - ${_getCoffeePrice(1)} руб'),
                _buildCoffeeOption(2, 'Капучино - ${_getCoffeePrice(2)} руб'),
                _buildCoffeeOption(3, 'Латте - ${_getCoffeePrice(3)} руб'),

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: isMakingCoffee ? null : _makeCoffee,
                    child: isMakingCoffee
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('ПУСК'),
                  ),
                ),

                const SizedBox(height: 30),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _moneyController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Сумма',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (_moneyController.text.isNotEmpty) {
                              int amount =
                                  int.tryParse(_moneyController.text) ?? 0;
                              if (amount > 0) {
                                setState(() {
                                  _appState.resources.cash += amount;
                                });
                                _notifications.showSuccess(
                                  '$amount руб добавлено',
                                );
                                _moneyController.clear();
                              } else {
                                _notifications.showError(
                                  'Введите корректную сумму',
                                );
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('+'),
                        ),
                        const SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: () {
                            if (_appState.resources.cash > 0) {
                              setState(() {
                                _appState.resources.cash = 0;
                              });
                              _notifications.showInfo('Деньги возвращены');
                            }
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('-'),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoffeeOption(int index, String title) {
    return Row(
      children: [
        Radio<int>(
          value: index,
          groupValue: selectedCoffee,
          onChanged: isMakingCoffee
              ? null
              : (value) {
                  setState(() {
                    selectedCoffee = value!;
                  });
                },
        ),
        Text(title),
      ],
    );
  }

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }
}
