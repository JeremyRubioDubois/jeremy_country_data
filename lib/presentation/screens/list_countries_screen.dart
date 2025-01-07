import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_state.dart';
import 'package:jeremy_country_data/presentation/widgets/country_list_tile.dart';
import 'package:jeremy_country_data/presentation/widgets/country_search_bar.dart';

class ListCountriesScreen extends StatefulWidget {
  const ListCountriesScreen({super.key});

  @override
  _ListCountriesScreenState createState() => _ListCountriesScreenState();
}

class _ListCountriesScreenState extends State<ListCountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jeremy Country Data')),
      body: Column(
        children: [
          const CountrySearchBar(),
          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              builder: (context, state) {
                if (state is CountriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CountriesError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is CountriesLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: state.filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = state.filteredCountries[index];
                      return CountryListTile(country: country);
                    },
                  );
                } else {
                  return const Center(child: Text('No countries found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
