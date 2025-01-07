import 'package:jeremy_country_data/model/country_model.dart';

abstract class SingleCountryState {}

class SingleCountryLoading extends SingleCountryState {}

class SingleCountryLoaded extends SingleCountryState {
  final Country country;

  SingleCountryLoaded(this.country);
}

class SingleCountryError extends SingleCountryState {
  final String message;

  SingleCountryError(this.message);
}
