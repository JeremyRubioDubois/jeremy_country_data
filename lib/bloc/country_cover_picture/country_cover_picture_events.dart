abstract class CountryCoverPictureEvent {}

class FetchCountryCoverPictureEvent extends CountryCoverPictureEvent {
  final String countryName;

  FetchCountryCoverPictureEvent(this.countryName);
}
