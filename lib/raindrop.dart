import 'package:flutter/material.dart';

class RaindropAnimation extends StatefulWidget {
  const RaindropAnimation({Key? key}) : super(key: key);

  @override
  _RaindropAnimationState createState() => _RaindropAnimationState();
}

class _RaindropAnimationState extends State<RaindropAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 192, 192, 192),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Transform.translate(
                    offset: Offset(50, 50 * _controller.value),
                    child: Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 189, 227, 253),
                      size: 20,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(30, 50 * (_controller.value - 0.5)),
                    child: Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 189, 227, 253),
                      size: 20,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 50 * (_controller.value - 0.5)),
                    child: Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 189, 227, 253),
                      size: 20,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(20, 50 * (_controller.value - 0.5)),
                    child: Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 189, 227, 253),
                      size: 20,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Hujan",
                  style: TextStyle(
                    color: Color.fromARGB(255, 147, 212, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
