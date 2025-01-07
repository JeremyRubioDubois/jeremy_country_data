import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jeremy_country_data/bloc/country_cover_picture/country_cover_picture_events.dart';
import 'package:jeremy_country_data/bloc/country_cover_picture/country_cover_picture_state.dart';

class CountryCoverPictureBloc
    extends Bloc<CountryCoverPictureEvent, CountryCoverPictureState> {
  CountryCoverPictureBloc() : super(CountryCoverPictureLoading()) {
    on<FetchCountryCoverPictureEvent>((event, emit) async {
      try {
        emit(CountryCoverPictureLoading());
        String countryCoverPictureUrl = '';

        final response = await http.get(
          Uri.parse(
            'https://api.pexels.com/v1/search?query=${event.countryName}&per_page=1',
          ),
          headers: {'Authorization': dotenv.env['PEXELS_KEY'] ?? ''},
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['photos'].isNotEmpty) {
            countryCoverPictureUrl = data['photos'][0]['src']['large'];
          } else {
            throw Exception('No images found for ${event.countryName}');
          }
        } else {
          throw Exception('Failed to load image from Pexels API');
        }

        emit(CountryCoverPictureLoaded(countryCoverPictureUrl));
      } catch (e) {
        emit(CountryCoverPictureError(e.toString()));
      }
    });
  }
}
