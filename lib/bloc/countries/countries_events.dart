abstract class CountriesEvent {}

class FetchCountriesEvent extends CountriesEvent {}

class FilterCountriesEvent extends CountriesEvent {
  final String query;

  FilterCountriesEvent(this.query);
}
