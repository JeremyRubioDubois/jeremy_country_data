abstract class CountryCoverPictureState {}

class CountryCoverPictureLoading extends CountryCoverPictureState {}

class CountryCoverPictureLoaded extends CountryCoverPictureState {
  final String countryCoverPictureUrl;

  CountryCoverPictureLoaded(this.countryCoverPictureUrl);
}

class CountryCoverPictureError extends CountryCoverPictureState {
  final String message;

  CountryCoverPictureError(this.message);
}
