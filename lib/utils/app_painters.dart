import 'package:flutter/material.dart';

// Custom painter for Google logo
class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Google logo colors
    final blue = const Color(0xFF4285F4);
    final red = const Color(0xFFEA4335);
    final yellow = const Color(0xFFFBBC05);
    final green = const Color(0xFF34A853);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the colorful Google "G"
    // Blue arc (top-right)
    paint.color = blue;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57, // -90 degrees
      1.57, // 90 degrees
      false,
      paint
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke,
    );

    // Red arc (top-left)
    paint.color = red;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14, // 180 degrees
      1.57, // 90 degrees
      false,
      paint
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke,
    );

    // Yellow arc (bottom-left)
    paint.color = yellow;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.57, // 90 degrees
      1.57, // 90 degrees
      false,
      paint
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke,
    );

    // Green arc (bottom-right)
    paint.color = green;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0, // 0 degrees
      1.57, // 90 degrees
      false,
      paint
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke,
    );

    // Blue horizontal line (middle)
    paint.color = blue;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(center.dx - radius * 0.3, center.dy - 1, radius * 0.6, 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for grid pattern background
class GridPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  GridPatternPainter({
    this.color = const Color(0x1AFFFFFF),
    this.spacing = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
