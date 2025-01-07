abstract class OpenAiState {}

class OpenAiLoading extends OpenAiState {}

class OpenAiLoaded extends OpenAiState {
  final String text;

  OpenAiLoaded(this.text);
}

class OpenAiError extends OpenAiState {
  final String message;

  OpenAiError(this.message);
}
