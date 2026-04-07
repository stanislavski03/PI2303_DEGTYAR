import 'package:flutter/material.dart';

class InfinityList extends StatefulWidget {
  const InfinityList({super.key});

  @override
  State<InfinityList> createState() => _InfinityListState();
}

class _InfinityListState extends State<InfinityList> {
  List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Бесконечный список',
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
      body: ListView.builder(
        itemBuilder: (context, i) {
          print('num $i : нечетное = ${i.isOdd}');

          if (i.isOdd) {
            return const Divider();
          }

          final int index = i ~/ 2;
          print('index $index');
          print('length ${_items.length}');

          if (index >= _items.length) {
            _items.addAll([
              '${_items.length + 1}',
              '${_items.length + 2}',
              '${_items.length + 3}',
            ]);
          }

          return ListTile(
            title: Text(
              _items[index],
              style: const TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}
