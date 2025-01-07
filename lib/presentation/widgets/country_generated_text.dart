import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/openai/openai_bloc.dart';
import 'package:jeremy_country_data/bloc/openai/openai_state.dart';

class CountryGeneratedText extends StatelessWidget {
  const CountryGeneratedText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenAiBloc, OpenAiState>(
      builder: (context, state) {
        if (state is OpenAiLoading) {
          return const Center(
            child: SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.indigo),
              ),
            ),
          );
        } else if (state is OpenAiError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is OpenAiLoaded) {
          return RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              children: [
                const TextSpan(
                  text: "OpenAI GPT-3.5 :\n\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: state.text),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
