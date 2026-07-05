import 'package:flutter/foundation.dart';

class EarningsProvider extends ChangeNotifier {
  final double _todayEarnings = 125.0;
  final double _weekEarnings = 780.0;
  final double _monthEarnings = 3200.0;
  final int _todayDeliveries = 3;
  final int _weekDeliveries = 18;
  final int _monthDeliveries = 72;
  final double _rating = 4.8;
  final int _totalDeliveries = 342;

  double get todayEarnings => _todayEarnings;
  double get weekEarnings => _weekEarnings;
  double get monthEarnings => _monthEarnings;
  int get todayDeliveries => _todayDeliveries;
  int get weekDeliveries => _weekDeliveries;
  int get monthDeliveries => _monthDeliveries;
  double get rating => _rating;
  int get totalDeliveries => _totalDeliveries;
}
