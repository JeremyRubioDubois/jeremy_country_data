abstract class SingleCountryEvent {}

class FetchSingleCountryEvent extends SingleCountryEvent {
  final String iso2;

  FetchSingleCountryEvent(this.iso2);
}
