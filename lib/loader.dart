import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Loader extends StatefulWidget {
  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;

  final double initialRadius = 30;

  double radius = 0.0;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_radius_in.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * initialRadius;
        }
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100.0,
      height: 100.0,
      child: RotationTransition(
        turns: animation_rotation,
        child: Center(
            child: Stack(
          children: <Widget>[
            Dot(radius: 30.0, color: Color(0xFF0D47A1)),
            Transform.translate(
              offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
              child: Dot(
                radius: 5.0,
                color: Colors.blue,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
