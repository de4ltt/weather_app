import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/providers/bloc_providers.dart';
import 'package:weather_app/presentation/providers/providers.dart';
import 'package:weather_app/presentation/providers/repository_providers.dart';
import 'package:weather_app/presentation/ui/pages/locations_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  final sharedPreferences = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Providers(
      sharedPreferences: sharedPreferences,
      child: RepositoryProviders(child: BlocProviders(child: MyApp())),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: const LocationsPage(),
      //const MainPage(),
    );
  }
}
