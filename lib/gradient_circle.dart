import 'package:flutter/material.dart';

const metaBallsBreakPoint1 = 0.50;
const metaBallsBreakPoint2 = 0.75;
const metaBallsBreakPoint3 = 1.00;

const metaBallsOpacity1 = 0.8; // this is how opaque we want the center of the circle to be
const metaBallsOpacity2 = 0.42; // opacity of mid-point of circle
const metaBallsOpacity3 = 0.0; // opacity of outer side of circle

class GradientCircle extends StatelessWidget {
  const GradientCircle({
    super.key,
    required this.ballSize,
    required this.color,
  });

  final double ballSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ballSize,
      width: ballSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(metaBallsOpacity1),
            color.withOpacity(metaBallsOpacity2),
            color.withOpacity(metaBallsOpacity3),
          ],
          stops: const [
            metaBallsBreakPoint1,
            metaBallsBreakPoint2,
            metaBallsBreakPoint3,
          ],
        ),
      ),
    );
  }
}
