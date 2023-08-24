import 'package:flutter/material.dart';

class SunnyAnimation extends StatelessWidget {
  const SunnyAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 112, 234, 255),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.yellow, // Border color
          width: 2.0, // Border width
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wb_sunny,
            color: Colors.yellow,
            size: 40,
          ),
          const SizedBox(height: 5),
          Text(
            "Cerah",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
