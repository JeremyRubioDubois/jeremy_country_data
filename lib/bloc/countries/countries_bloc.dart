import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jeremy_country_data/bloc/countries/countries_events.dart';
import 'package:jeremy_country_data/bloc/countries/countries_state.dart';
import 'package:jeremy_country_data/model/country_model.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc() : super(CountriesLoading()) {
    countCountries(List<Country> countries, String letter) {
      final countryNames = countries
          .map((country) => country.name.toString().toLowerCase())
          .toList();
      return countryNames.where((name) => name.contains(letter)).length;
    }

    on<FetchCountriesEvent>((event, emit) async {
      emit(CountriesLoading());
      try {
        final headers = {
          'X-CSCAPI-KEY': dotenv.env['COUNTRYSTATECITY_KEY'] ?? ''
        };
        final response = await http.get(
          Uri.parse('https://api.countrystatecity.in/v1/countries'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final List<dynamic> countryJson = json.decode(response.body);
          final List<Country> countries =
              countryJson.map((json) => Country.fromJson(json)).toList();

          emit(
            CountriesLoaded(
              countries,
              countries,
              countCountries(countries, 'e'),
              countCountries(countries, 'a'),
              countCountries(countries, 'y'),
            ),
          );
        } else {
          emit(CountriesError('Failed to load countries'));
        }
      } catch (e) {
        emit(CountriesError('An error occurred: $e'));
      }
    });

    on<FilterCountriesEvent>((event, emit) {
      if (state is CountriesLoaded) {
        final current = state as CountriesLoaded;
        final List<Country> filteredCountries =
            current.countries.where((country) {
          final countryName = country.name.toLowerCase();
          return countryName.contains(event.query.toLowerCase());
        }).toList();
        emit(
          CountriesLoaded(
            current.countries,
            filteredCountries,
            countCountries(filteredCountries, 'e'),
            countCountries(filteredCountries, 'a'),
            countCountries(filteredCountries, 'y'),
          ),
        );
      }
    });
  }
}
