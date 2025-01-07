import 'package:flutter/material.dart';
import 'package:jeremy_country_data/model/country_model.dart';

class CountryListTile extends StatelessWidget {
  final Country country;
  const CountryListTile({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border(top: BorderSide(color: Colors.indigo[50]!)),
      minTileHeight: 1,
      title: Text(
        '${country.emoji} ${country.name}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/country',
          arguments: {
            'name': country.name,
            'capital': country.capital,
            'iso2': country.iso2
          },
        );
      },
    );
  }
}
