import 'package:flutter/material.dart';

class ResourceDisplay extends StatelessWidget {
  final int coffeeBeans;
  final int milk;
  final int water;

  const ResourceDisplay({
    super.key,
    required this.coffeeBeans,
    required this.milk,
    required this.water,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Кофе: $coffeeBeans г'),
          Text('Молоко: $milk мл'),
          Text('Вода: $water мл'),
        ],
      ),
    );
  }
}
