import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  const SimpleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Простой список',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Элемент 1', style: TextStyle(color: Colors.black)),
          ),
          Divider(),
          ListTile(
            title: Text('Элемент 2', style: TextStyle(color: Colors.black)),
          ),
          Divider(),
          ListTile(
            title: Text('Элемент 3', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
