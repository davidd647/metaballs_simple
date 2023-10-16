import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class OpacityFilter extends StatefulWidget {
  const OpacityFilter({
    super.key,
    required this.opacityFilterValue,
    required this.child,
  });

  final double opacityFilterValue;
  final Widget child;

  @override
  State<OpacityFilter> createState() => _OpacityFilterState();
}

class _OpacityFilterState extends State<OpacityFilter> {
  final testDouble = 100.0;

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder((context, shader, child) {
      return AnimatedSampler(
        (image, size, canvas) {
          shader.setFloatUniforms((uniforms) {
            uniforms
              ..setFloat(widget.opacityFilterValue) // This is the alpha threshold. Adjust as needed.
              ..setSize(size);
          });

          shader.setImageSampler(0, image);

          canvas.drawRect(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Paint()..shader = shader,
          );
        },
        child: widget.child,
      );
    }, assetKey: 'shaders/opacity_filter.frag');
    // });
  }
}
