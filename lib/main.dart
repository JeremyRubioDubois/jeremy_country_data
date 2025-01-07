import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jeremy_country_data/bloc/countries/countries_bloc.dart';
import 'package:jeremy_country_data/bloc/countries/countries_events.dart';
import 'package:jeremy_country_data/bloc/country_cover_picture/country_cover_picture_bloc.dart';
import 'package:jeremy_country_data/bloc/country_cover_picture/country_cover_picture_events.dart';
import 'package:jeremy_country_data/bloc/openai/openai_bloc.dart';
import 'package:jeremy_country_data/bloc/openai/openai_events.dart';
import 'package:jeremy_country_data/bloc/single_country/single_country_bloc.dart';
import 'package:jeremy_country_data/bloc/single_country/single_country_events.dart';
import 'package:jeremy_country_data/presentation/screens/single_country_screen.dart';
import 'package:jeremy_country_data/presentation/widgets/navigation.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future main() async {
  String initialRoute = '/home';
  await dotenv.load(fileName: ".env");
  runApp(JeremyCountryDataApp(initialRoute: initialRoute));
}

class JeremyCountryDataApp extends StatelessWidget {
  final String initialRoute;

  const JeremyCountryDataApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountriesBloc()..add(FetchCountriesEvent()),
        ),
        BlocProvider(
          create: (context) => SingleCountryBloc(),
        ),
        BlocProvider(
          create: (context) => CountryCoverPictureBloc(),
        ),
        BlocProvider(
          create: (context) => OpenAiBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.indigo,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.indigoAccent,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.indigo[400],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            hintStyle: TextStyle(
              color: Colors.indigo[100],
              fontSize: 16,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, strokeAlign: 1),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey,
          ),
          scaffoldBackgroundColor: Colors.white,
          splashColor: Colors.indigo[50],
          highlightColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        title: 'Jeremy Country Data',
        initialRoute: initialRoute,
        routes: {
          '/home': (context) => const Navigation(),
          '/country': (context) {
            final arg = ModalRoute.of(context)!.settings.arguments as Map;
            context.read<SingleCountryBloc>().add(
                  FetchSingleCountryEvent(arg['iso2']),
                );
            context.read<CountryCoverPictureBloc>().add(
                  FetchCountryCoverPictureEvent(arg['name']),
                );
            context.read<OpenAiBloc>().add(
                  FetchOpenAiEvent(arg['name']),
                );
            return SingleCountryScreen(name: arg['name']);
          }
        },
      ),
    );
  }
}
