import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presentation/ui/pages/locations_page.dart';
import 'package:weather_app/presentation/ui/pages/main_page.dart';

import 'data/repository/locations_repository.dart';
import 'domain/bloc/search/locations_bloc.dart';
import 'domain/bloc/search_query/search_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final LocationsRepository locationsRepository = LocationsRepository(
      dio: dio,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => SearchBloc(locationsRepository: locationsRepository),
        ),
        BlocProvider(create: (context) => LocationsBloc()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
        home: const LocationsPage(),
        //const MainPage(),
      ),
    );
  }
}
