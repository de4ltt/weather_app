import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presentation/ui/pages/locations_page.dart';
import 'package:weather_app/presentation/ui/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: const LocationsPage()
      //const MainPage(),
    );
  }
}
