import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jeremy_country_data/bloc/openai/openai_events.dart';
import 'package:jeremy_country_data/bloc/openai/openai_state.dart';

class OpenAiBloc extends Bloc<OpenAiEvent, OpenAiState> {
  OpenAiBloc() : super(OpenAiLoading()) {
    on<FetchOpenAiEvent>((event, emit) async {
      try {
        emit(OpenAiLoading());
        String text = '';

        final response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${dotenv.env['OPENAI_KEY'] ?? ''}',
          },
          body: json.encode({
            'model': 'gpt-3.5-turbo',
            'messages': [
              {'role': 'system', 'content': 'You are a helpful assistant.'},
              {
                'role': 'user',
                'content':
                    'Give a detailed description of the country ${event.countryName}.'
              },
            ],
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          text = data['choices'][0]['message']['content'].trim();
        } else {
          throw Exception('Failed to get text from OpenAi API');
        }

        emit(OpenAiLoaded(text));
      } catch (e) {
        emit(OpenAiError(e.toString()));
      }
    });
  }
}
