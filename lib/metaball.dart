import 'package:flutter/material.dart';

class MetaBall {
  Offset position;
  Offset velocity;
  double size;

  MetaBall({
    required this.position,
    required this.velocity,
    required this.size,
  });
}

MetaBall move(MetaBall qBall, Size screenSize) {
  Offset newVel = Offset(qBall.velocity.dx, qBall.velocity.dy);

  if (qBall.position.dx <= 0 || qBall.position.dx >= screenSize.width) {
    newVel = Offset(-qBall.velocity.dx, qBall.velocity.dy);
  }
  if (qBall.position.dy <= 0 || qBall.position.dy >= screenSize.height) {
    newVel = Offset(qBall.velocity.dx, -qBall.velocity.dy);
  }

  Offset newPos = Offset(
    qBall.position.dx + newVel.dx,
    qBall.position.dy + newVel.dy,
  );

  return MetaBall(
    position: newPos,
    velocity: newVel,
    size: qBall.size,
  );
}
