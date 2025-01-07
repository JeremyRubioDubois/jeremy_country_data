import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_events.dart';

class CountrySearchBar extends StatefulWidget {
  const CountrySearchBar({super.key});

  @override
  State<CountrySearchBar> createState() => _CountrySearchBarState();
}

class _CountrySearchBarState extends State<CountrySearchBar> {
  late TextEditingController searchController;
  late bool searchIsEmpty;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchIsEmpty = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.indigo[100],
        cursorHeight: 18,
        onChanged: (value) {
          String query = value.toLowerCase();
          context.read<CountriesBloc>().add(FilterCountriesEvent(query));
          setState(() => searchIsEmpty = value.isEmpty);
        },
        decoration: InputDecoration(
          suffixIcon: searchIsEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  color: Colors.white,
                  onPressed: () {
                    searchIsEmpty = true;
                    searchController.clear();
                    context.read<CountriesBloc>().add(FilterCountriesEvent(''));
                    FocusScope.of(context).unfocus();
                  },
                ),
          hintText: 'Search for a country',
          prefixIcon: const Icon(Icons.search),
          prefixIconColor:
              searchController.text.isEmpty ? Colors.indigo[100] : Colors.white,
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
