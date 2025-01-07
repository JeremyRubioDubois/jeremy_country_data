abstract class OpenAiEvent {}

class FetchOpenAiEvent extends OpenAiEvent {
  final String countryName;

  FetchOpenAiEvent(this.countryName);
}
