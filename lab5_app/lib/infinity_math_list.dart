import 'package:flutter/material.dart';
import 'dart:math';

class InfinityMathList extends StatefulWidget {
  const InfinityMathList({super.key});

  @override
  State<InfinityMathList> createState() => _InfinityMathListState();
}

class _InfinityMathListState extends State<InfinityMathList> {
  List<String> _items = [];

  String _calculatePower(int n) {
    int result = pow(2, n).toInt();
    return '2^$n = $result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Степени числа 2',
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
              _calculatePower(_items.length),
              _calculatePower(_items.length + 1),
              _calculatePower(_items.length + 2),
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
