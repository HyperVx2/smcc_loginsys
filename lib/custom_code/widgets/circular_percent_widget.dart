// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

class CircularPercentWidget extends StatefulWidget {
  const CircularPercentWidget({
    Key? key,
    this.width,
    this.height,
    required this.percent,
    required this.milliseconds,
    required this.sliderWidth,
    required this.activeColor,
    required this.inactiveColor,
    required this.fontSize,
    required this.fontColor,
  }) : super(key: key);

  /// Canvas width
  final double? width;

  /// Canvas height
  final double? height;

  /// Target percentage (0–100)
  final int percent;

  /// Animation duration in milliseconds
  final int milliseconds;

  /// Width of the circular track
  final double sliderWidth;

  /// Color of the active arc
  final Color activeColor;

  /// Color of the background arc
  final Color inactiveColor;

  /// Font size for center text
  final double fontSize;

  /// Color of center text
  final Color fontColor;

  @override
  _CircularPercentWidgetState createState() => _CircularPercentWidgetState();
}

class _CircularPercentWidgetState extends State<CircularPercentWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.milliseconds),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percent / 100.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut))
      ..addListener(() => setState(() {}));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.width ?? 100, widget.height ?? 100),
            painter: _CirclePainter(
              progress: _animation.value,
              sliderWidth: widget.sliderWidth,
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
            ),
          ),
          Text(
            '${(_animation.value * 100).round()}%',
            style: TextStyle(
              fontSize: widget.fontSize,
              color: widget.fontColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter({
    required this.progress,
    required this.sliderWidth,
    required this.activeColor,
    required this.inactiveColor,
  });

  final double progress;
  final double sliderWidth;
  final Color activeColor;
  final Color inactiveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (min(size.width, size.height) - sliderWidth) / 2;

    // background circle
    final bgPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = sliderWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // active arc
    final fgPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = sliderWidth
      ..strokeCap = StrokeCap.round;
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CirclePainter old) =>
      old.progress != progress ||
      old.sliderWidth != sliderWidth ||
      old.activeColor != activeColor ||
      old.inactiveColor != inactiveColor;
}
