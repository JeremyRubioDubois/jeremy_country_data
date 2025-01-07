import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeremy_country_data/bloc/single_country/single_country_bloc.dart';
import 'package:jeremy_country_data/bloc/single_country/single_country_state.dart';
import 'package:jeremy_country_data/model/country_model.dart';
import 'package:jeremy_country_data/presentation/widgets/country_cover_picture.dart';
import 'package:jeremy_country_data/presentation/widgets/country_generated_text.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleCountryScreen extends StatefulWidget {
  final String name;
  const SingleCountryScreen({super.key, required this.name});

  @override
  SingleCountryScreenState createState() => SingleCountryScreenState();
}

class SingleCountryScreenState extends State<SingleCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: BlocBuilder<SingleCountryBloc, SingleCountryState>(
        builder: (context, state) {
          if (state is SingleCountryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SingleCountryError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is SingleCountryLoaded) {
            final Country country = state.country;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const CountryCoverPicture(),
                const SizedBox(height: 10),
                Text(
                  "${country.emoji != null ? "${country.emoji} " : ''}${country.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Capital: ${country.capital}"),
                const SizedBox(height: 8),
                Text("Region: ${country.region ?? ''}"),
                const SizedBox(height: 8),
                Text("Subregion: ${country.subregion ?? ''}"),
                const SizedBox(height: 8),
                Text("Top-Level Domain: ${country.tld ?? ''}"),
                const SizedBox(height: 8),
                Text("Alpha-2 Code: ${country.iso2}"),
                const SizedBox(height: 8),
                Text("Alpha-3 Code: ${country.iso3}"),
                const SizedBox(height: 8),
                Text(
                    "Calling Code: ${country.phonecode != null ? "+ ${country.phonecode}" : ''}"),
                const SizedBox(height: 8),
                Text("Currency: ${country.currency ?? ''}"),
                const SizedBox(height: 8),
                Text("Latitude: ${country.latitude ?? ''}"),
                const SizedBox(height: 8),
                Text("Longitude: ${country.longitude ?? ''}"),
                const SizedBox(height: 16),
                const CountryGeneratedText(),
                const SizedBox(height: 16),
                TextButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 18),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final Uri googleMapsUrl = Uri.parse(
                        'https://www.google.com/maps/place/${widget.name}');
                    if (await canLaunchUrl(googleMapsUrl)) {
                      await launchUrl(googleMapsUrl);
                    } else {
                      throw 'Could not launch $googleMapsUrl';
                    }
                  },
                  label: const Text('See on Google Maps'),
                ),
                const SizedBox(height: 16),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
