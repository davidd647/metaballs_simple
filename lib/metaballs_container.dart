import 'package:flutter/material.dart';

import './helpers/random.dart';

import './gradient_circle.dart';
import './opacity_filter.dart';
import './metaball.dart';

const pi = 3.14159;

class MetaballsContainer extends StatefulWidget {
  const MetaballsContainer({
    super.key,
    required this.maxHeight,
    required this.maxWidth,
  });

  final double maxHeight;
  final double maxWidth;

  @override
  State<MetaballsContainer> createState() => MetaballsContainerState();
}

class MetaballsContainerState extends State<MetaballsContainer> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  final double _ballSize = 150.0;
  final double qBallSpeed = 0.10;
  final double qBallSpeedVariance = 0.1;
  int numOfBalls = 10;

  late List<MetaBall> metaBalls = [];

  void initMetaBalls(_) {
    for (var x = 0; x < numOfBalls; x++) {
      metaBalls.add(MetaBall(
        size: _ballSize,
        position: Offset(random(widget.maxWidth), random(widget.maxHeight)),
        velocity: Offset.fromDirection(
          random(2 * pi),
          qBallSpeed + random(qBallSpeedVariance) - qBallSpeedVariance / 2,
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initMetaBalls(context));
  }

  @override
  Widget build(BuildContext context) {
    const ballColor = Colors.white;

    return SizedBox(
      width: widget.maxWidth,
      height: widget.maxHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          // move the metaBalls (happens each frame)...
          for (var x = 0; x < metaBalls.length; x++) {
            metaBalls[x] = move(metaBalls[x], Size(widget.maxWidth, widget.maxHeight));
          }

          // put a stack here to show shaded content as well as non-shaded content
          return Stack(
            children: [
              // opacityFilter creates the metaball effect by deleting all color values with opacity < 0.5
              // (this is where the weird/complicated/interesting/cool stuff happens)
              OpacityFilter(
                opacityFilterValue: 0.5,
                // put a stack here to put a bunch of circles on it with radial gradients
                // (solid colour in center, transparent on the outside)
                child: Stack(
                  children: [
                    // metaballs hold data about position, size, and have a ".move" method for animation
                    ...metaBalls.map((metaBall) {
                      return Positioned(
                        left: metaBall.position.dx - _ballSize / 2,
                        top: metaBall.position.dy - _ballSize / 2,
                        // gradient circle is the circles
                        child: GradientCircle(ballSize: _ballSize, color: ballColor),
                      );
                    }),
                  ],
                ),
              ),
              // just a widget that's outside of the shader's influence:
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Hello!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
