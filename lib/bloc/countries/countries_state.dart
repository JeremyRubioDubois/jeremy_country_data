import 'package:jeremy_country_data/model/country_model.dart';

abstract class CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<Country> countries;
  final List<Country> filteredCountries;
  final int countWithE;
  final int countWithA;
  final int countWithY;

  CountriesLoaded(
    this.countries,
    this.filteredCountries,
    this.countWithE,
    this.countWithA,
    this.countWithY,
  );
}

class CountriesError extends CountriesState {
  final String message;

  CountriesError(this.message);
}
