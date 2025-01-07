import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/country_cover_picture/country_cover_picture_bloc.dart';
import 'package:jeremy_country_data/bloc/country_cover_picture/country_cover_picture_state.dart';

class CountryCoverPicture extends StatelessWidget {
  const CountryCoverPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: BlocBuilder<CountryCoverPictureBloc, CountryCoverPictureState>(
          builder: (context, state) {
        if (state is CountryCoverPictureLoading) {
          return Container(color: Colors.grey[50]);
        } else if (state is CountryCoverPictureError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is CountryCoverPictureLoaded) {
          return Image.network(
            state.countryCoverPictureUrl,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
