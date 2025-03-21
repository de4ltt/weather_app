import 'package:flutter/material.dart';

class WeatherLoadingIndicator extends StatelessWidget {
  const WeatherLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 3,
    );
  }
}
