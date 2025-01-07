import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jeremy_country_data/bloc/single_country/single_country_events.dart';
import 'package:jeremy_country_data/bloc/single_country/single_country_state.dart';
import 'package:jeremy_country_data/model/country_model.dart';

class SingleCountryBloc extends Bloc<SingleCountryEvent, SingleCountryState> {
  SingleCountryBloc() : super(SingleCountryLoading()) {
    on<FetchSingleCountryEvent>((event, emit) async {
      emit(SingleCountryLoading());
      try {
        final headers = {
          'X-CSCAPI-KEY': dotenv.env['COUNTRYSTATECITY_KEY'] ?? ''
        };
        final response = await http.get(
          Uri.parse(
            'https://api.countrystatecity.in/v1/countries/${event.iso2}',
          ),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> countryJson = json.decode(response.body);
          final Country country = Country.fromJson(countryJson);
          emit(SingleCountryLoaded(country));
        } else {
          emit(SingleCountryError('Failed to load single country'));
        }
      } catch (e) {
        emit(SingleCountryError('An error occurred: $e'));
      }
    });
  }
}
