import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RouteMap extends StatelessWidget {
  final double merchantLat;
  final double merchantLng;
  final double customerLat;
  final double customerLng;
  final String phase;

  const RouteMap({
    super.key,
    required this.merchantLat,
    required this.merchantLng,
    required this.customerLat,
    required this.customerLng,
    required this.phase,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final lats = [merchantLat, customerLat];
        final lngs = [merchantLng, customerLng];
        final minLat = lats.reduce(min) - 0.002;
        final maxLat = lats.reduce(max) + 0.002;
        final minLng = lngs.reduce(min) - 0.002;
        final maxLng = lngs.reduce(max) + 0.002;
        final latRange = maxLat - minLat;
        final lngRange = maxLng - minLng;

        Offset project(double lat, double lng) {
          return Offset(
            ((lng - minLng) / lngRange) * (width - 40) + 20,
            ((maxLat - lat) / latRange) * (height - 40) + 20,
          );
        }

        final merchantPos = project(merchantLat, merchantLng);
        final customerPos = project(customerLat, customerLng);

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CustomPaint(
            painter: _RoutePainter(
              merchantPos: merchantPos,
              customerPos: customerPos,
              phase: phase,
            ),
            size: Size(width, height),
          ),
        );
      },
    );
  }
}

class _RoutePainter extends CustomPainter {
  final Offset merchantPos;
  final Offset customerPos;
  final String phase;

  _RoutePainter({required this.merchantPos, required this.customerPos, required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFE8F5E9));

    final gridPaint = Paint()..color = Colors.white.withAlpha(80)..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) { canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint); }
    for (double y = 0; y < size.height; y += 40) { canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint); }

    final routePaint = Paint()..color = AppColors.primary.withAlpha(100)..strokeWidth = 4..style = PaintingStyle.stroke;
    canvas.drawLine(merchantPos, customerPos, routePaint);

    _drawMarker(canvas, merchantPos, AppColors.warning, '🏪', 'Pickup');
    _drawMarker(canvas, customerPos, AppColors.success, '📍', 'Dropoff');
  }

  void _drawMarker(Canvas canvas, Offset pos, Color color, String emoji, String label) {
    canvas.drawCircle(pos, 16, Paint()..color = color.withAlpha(40));
    canvas.drawCircle(pos, 10, Paint()..color = color);

    final tp = TextPainter(
      text: TextSpan(text: label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 10, fontWeight: FontWeight.w500)),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy + 18));
  }

  @override
  bool shouldRepaint(covariant _RoutePainter old) => old.phase != phase;
}
