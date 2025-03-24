import 'package:flutter/material.dart';

class LinearLoadingIndicator extends StatelessWidget {
  const LinearLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: LinearProgressIndicator(color: Colors.lightBlueAccent),
    );
  }
}
