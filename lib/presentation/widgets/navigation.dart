import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_events.dart';
import 'package:jeremy_country_data/presentation/screens/dashboard_screen.dart';
import 'package:jeremy_country_data/presentation/screens/list_countries_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int activeTab;

  @override
  void initState() {
    super.initState();
    activeTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (activeTab == 1) {
            context.read<CountriesBloc>().add(FilterCountriesEvent(''));
          }
          setState(() => activeTab = value);
        },
        currentIndex: activeTab,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List of countries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
      body: activeTab == 0
          ? const ListCountriesScreen()
          : const DashboardScreen(),
    );
  }
}
