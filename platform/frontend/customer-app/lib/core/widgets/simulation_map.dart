import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SimulationMap extends StatelessWidget {
  final double merchantLat;
  final double merchantLng;
  final double customerLat;
  final double customerLng;
  final double driverLat;
  final double driverLng;

  const SimulationMap({
    super.key,
    required this.merchantLat,
    required this.merchantLng,
    required this.customerLat,
    required this.customerLng,
    required this.driverLat,
    required this.driverLng,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final lats = [merchantLat, customerLat, driverLat];
        final lngs = [merchantLng, customerLng, driverLng];
        final minLat = lats.reduce(min) - 0.002;
        final maxLat = lats.reduce(max) + 0.002;
        final minLng = lngs.reduce(min) - 0.002;
        final maxLng = lngs.reduce(max) + 0.002;

        final latRange = maxLat - minLat;
        final lngRange = maxLng - minLng;

        Offset project(double lat, double lng) {
          final x = ((lng - minLng) / lngRange) * (width - 40) + 20;
          final y = ((maxLat - lat) / latRange) * (height - 40) + 20;
          return Offset(x, y);
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CustomPaint(
            painter: _MapPainter(
              merchantPos: project(merchantLat, merchantLng),
              customerPos: project(customerLat, customerLng),
              driverPos: project(driverLat, driverLng),
            ),
            size: Size(width, height),
          ),
        );
      },
    );
  }
}

class _MapPainter extends CustomPainter {
  final Offset merchantPos;
  final Offset customerPos;
  final Offset driverPos;

  _MapPainter({
    required this.merchantPos,
    required this.customerPos,
    required this.driverPos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final gridPaint = Paint()
      ..color = Colors.white.withAlpha(80)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final routePaint = Paint()
      ..color = AppColors.primary.withAlpha(60)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawLine(merchantPos, customerPos, routePaint);

    final dashPaint = Paint()
      ..color = AppColors.primary.withAlpha(150)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path()..moveTo(driverPos.dx, driverPos.dy);
    path.lineTo(customerPos.dx, customerPos.dy);
    canvas.drawPath(path, dashPaint);

    _drawMarker(canvas, merchantPos, AppColors.warning, '🏪', 'Merchant');
    _drawMarker(canvas, customerPos, AppColors.success, '📍', 'You');

    _drawMarker(canvas, driverPos, AppColors.primary, '🚚', 'Driver', isPulse: true);
  }

  void _drawMarker(Canvas canvas, Offset pos, Color color, String emoji, String label, {bool isPulse = false}) {
    canvas.drawCircle(pos, 16, Paint()..color = color.withAlpha(40));
    canvas.drawCircle(pos, 10, Paint()..color = color);

    final textPainter = TextPainter(
      text: TextSpan(text: label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 10, fontWeight: FontWeight.w500)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(pos.dx - textPainter.width / 2, pos.dy + 18));
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) {
    return oldDelegate.driverPos != driverPos;
  }
}
