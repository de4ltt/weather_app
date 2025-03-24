import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ColoredBox(
        color: Colors.black12,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.list, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
