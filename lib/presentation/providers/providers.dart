import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Providers extends StatelessWidget {
  const Providers({
    super.key,
    required this.child,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Dio()),
        Provider(
          create: (context) => sharedPreferences,
        ),
      ],
      child: child,
    );
  }
}
