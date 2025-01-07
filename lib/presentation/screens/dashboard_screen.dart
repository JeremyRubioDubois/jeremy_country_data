import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_state.dart';
import 'package:jeremy_country_data/presentation/widgets/country_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country Dashboard')),
      body: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is CountriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CountriesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is CountriesLoaded) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Countries",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                CountryCard(
                  title: "Total",
                  count: state.countries.length,
                ),
                CountryCard(
                  title: "containing the letter [e]",
                  count: state.countWithE,
                ),
                CountryCard(
                  title: "containing the letter [a]",
                  count: state.countWithA,
                ),
                CountryCard(
                  title: "containing the letter [y]",
                  count: state.countWithY,
                ),
              ],
            );
          } else {
            return const Center(child: Text('No countries found'));
          }
        },
      ),
    );
  }
}
