import 'package:flutter/foundation.dart';
import '../../../core/services/mock_data.dart';

class MerchantProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _merchants = [];
  final Map<String, List<Map<String, dynamic>>> _menus = {};

  List<Map<String, dynamic>> get merchants => _merchants;
  bool get isLoading => _merchants.isEmpty;

  MerchantProvider() {
    _merchants = List.from(MockData.merchants);
    MockData.menus.forEach((key, value) {
      _menus[key] = List.from(value);
    });
  }

  List<Map<String, dynamic>> getMenu(String merchantId) {
    return _menus[merchantId] ?? [];
  }
}
