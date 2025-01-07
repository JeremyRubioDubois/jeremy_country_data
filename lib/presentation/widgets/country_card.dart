import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final String title;
  final int count;
  const CountryCard({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.indigo[50],
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.indigo,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.indigo,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
