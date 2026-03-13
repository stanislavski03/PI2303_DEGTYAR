import 'package:flutter/material.dart';

class CoffeeMachineScreen extends StatefulWidget {
  const CoffeeMachineScreen({super.key});

  @override
  State<CoffeeMachineScreen> createState() => _CoffeeMachineScreenState();
}

class _CoffeeMachineScreenState extends State<CoffeeMachineScreen> {
  int coffeeBeans = 100;
  int milk = 200;
  int water = 300;
  int cash = 500;

  int selectedCoffee = 0;

  final TextEditingController _moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Кофе: $coffeeBeans г'),
                      Text('Молоко: $milk мл'),
                      Text('Вода: $water мл'),
                    ],
                  ),
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
                  child: Center(child: Text('Ваши деньги: $cash руб')),
                ),

                const SizedBox(height: 20),

                const Text('Выберите кофе:'),

                _buildCoffeeOption(0, 'Эспрессо - 150 руб'),
                _buildCoffeeOption(1, 'Американо - 180 руб'),
                _buildCoffeeOption(2, 'Капучино - 200 руб'),
                _buildCoffeeOption(3, 'Латте - 250 руб'),

                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Готовим ${_getCoffeeName(selectedCoffee)}...',
                          ),
                        ),
                      );
                    },
                    child: const Text('ПУСК'),
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
                              setState(() {
                                cash +=
                                    int.tryParse(_moneyController.text) ?? 0;
                              });
                              _moneyController.clear();
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
                            setState(() {
                              cash = 0;
                            });
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
          onChanged: (value) {
            setState(() {
              selectedCoffee = value!;
            });
          },
        ),
        Text(title),
      ],
    );
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
}
