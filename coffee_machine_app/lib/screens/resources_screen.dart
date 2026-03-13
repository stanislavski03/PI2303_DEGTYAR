import 'package:flutter/material.dart';
import '../app_state.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  late AppState _appState;

  final TextEditingController _coffeeController = TextEditingController();
  final TextEditingController _milkController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  void _addResources() {
    setState(() {
      _appState.resources.coffeeBeans +=
          int.tryParse(_coffeeController.text) ?? 0;
      _appState.resources.milk += int.tryParse(_milkController.text) ?? 0;
      _appState.resources.water += int.tryParse(_waterController.text) ?? 0;
      _appState.resources.cash += int.tryParse(_cashController.text) ?? 0;
    });

    _coffeeController.clear();
    _milkController.clear();
    _waterController.clear();
    _cashController.clear();

    FocusManager.instance.primaryFocus?.unfocus();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Ресурсы добавлены')));
  }

  void _clearInputs() {
    _coffeeController.clear();
    _milkController.clear();
    _waterController.clear();
    _cashController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

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
                const Center(
                  child: Text(
                    'РЕСУРСЫ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                _buildResourceLine(
                  'Кофе:',
                  '${_appState.resources.coffeeBeans} г',
                ),
                _buildResourceLine('Молоко:', '${_appState.resources.milk} мл'),
                _buildResourceLine('Вода:', '${_appState.resources.water} мл'),
                _buildResourceLine(
                  'Деньги:',
                  '${_appState.resources.cash} руб',
                ),

                const SizedBox(height: 30),

                const Text('Добавить ресурсы:'),
                const SizedBox(height: 10),

                _buildResourceInput('Кофе (г)', _coffeeController),
                const SizedBox(height: 8),
                _buildResourceInput('Молоко (мл)', _milkController),
                const SizedBox(height: 8),
                _buildResourceInput('Вода (мл)', _waterController),
                const SizedBox(height: 8),
                _buildResourceInput('Деньги (руб)', _cashController),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _addResources,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Добавить'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearInputs,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Очистить'),
                      ),
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

  Widget _buildResourceLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }

  Widget _buildResourceInput(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _coffeeController.dispose();
    _milkController.dispose();
    _waterController.dispose();
    _cashController.dispose();
    super.dispose();
  }
}
