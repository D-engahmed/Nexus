import 'package:flutter/foundation.dart';
import '../../../core/services/mock_data.dart';

/// CUS-013 Address Management
class Address {
  final String id;
  final String label;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final double latitude;
  final double longitude;
  final bool isDefault;
  final String instructions;

  Address({
    required this.id,
    required this.label,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.city,
    this.state = '',
    this.postalCode = '',
    this.country = 'EG',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.isDefault = false,
    this.instructions = '',
  });

  Address copyWith({
    String? label,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isDefault,
    String? instructions,
  }) {
    return Address(
      id: id,
      label: label ?? this.label,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault ?? this.isDefault,
      instructions: instructions ?? this.instructions,
    );
  }
}

/// Mock-only representation of a saved payment method.
/// IMPORTANT: this never holds a real PAN. Real card capture requires a
/// PCI-DSS-scoped tokenization flow via a payment gateway (Part 07A),
/// which does not exist yet. `last4` here is illustrative mock data only.
class PaymentMethod {
  final String id;
  final String type; // 'card' | 'wallet' | 'cod'
  final String brand; // 'Visa', 'Mastercard', 'Platform Wallet', 'Cash'
  final String last4;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.brand,
    this.last4 = '',
    this.expiryMonth = 0,
    this.expiryYear = 0,
    this.isDefault = false,
  });

  String get displayLabel {
    if (type == 'card') return '$brand •••• $last4';
    if (type == 'wallet') return brand;
    return 'Cash on Delivery';
  }
}

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic> _profile = {};
  final List<Address> _addresses = [];
  final List<PaymentMethod> _paymentMethods = [];

  bool _isLoading = false;
  String? _error;

  // Simulated OTP state (stub only — no real SMS/email dispatch).
  String? _pendingEmail;
  String? _pendingPhone;
  String? _lastOtpSent;

  Map<String, dynamic> get profile => _profile;
  List<Address> get addresses => List.unmodifiable(_addresses);
  List<PaymentMethod> get paymentMethods => List.unmodifiable(_paymentMethods);
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get pendingEmail => _pendingEmail;
  String? get pendingPhone => _pendingPhone;

  bool get hasLoadedProfile => _profile.isNotEmpty;

  /// Loads mock profile data contract-aligned to CUS-011/012/013.
  /// Swapping to a live backend later should only require replacing
  /// this method's body with a real `GET /customers/me` call.
  void load(String userId) {
    if (_profile['customerId'] == userId) return; // already loaded
    _isLoading = true;
    notifyListeners();

    final user = MockData.users.cast<Map<String, dynamic>>().firstWhere(
      (u) => u['id'] == userId,
      orElse: () => <String, dynamic>{},
    );

    _profile = {
      'customerId': userId,
      'firstName':
          user['firstName'] ??
          (user['name'] as String?)?.split(' ').first ??
          '',
      'lastName':
          user['lastName'] ??
          (user['name'] as String?)?.split(' ').skip(1).join(' ') ??
          '',
      'displayName': user['displayName'] ?? user['name'] ?? '',
      'email': user['email'] ?? '',
      'phone': user['phone'] ?? '',
      'avatarUrl': user['photo'] ?? '',
      'dateOfBirth': user['dateOfBirth'],
      'languagePreference': user['languagePreference'] ?? 'en',
      'currencyPreference': user['currencyPreference'] ?? 'EGP',
      'themePreference': user['themePreference'] ?? 'system',
      'marketingConsent': user['marketingConsent'] ?? false,
      'pushNotificationEnabled': user['pushNotificationEnabled'] ?? true,
      'emailNotificationEnabled': user['emailNotificationEnabled'] ?? true,
      'smsNotificationEnabled': user['smsNotificationEnabled'] ?? false,
      'status': user['status'] ?? 'ACTIVE',
      'createdAt': user['createdAt'] ?? '2026-01-01T00:00:00Z',
    };

    _addresses
      ..clear()
      ..addAll(
        (MockData.addresses[userId] ?? []).map(
          (a) => Address(
            id: a['id'] as String,
            label: a['label'] as String,
            addressLine1: a['addressLine1'] as String,
            addressLine2: a['addressLine2'] as String? ?? '',
            city: a['city'] as String,
            state: a['state'] as String? ?? '',
            postalCode: a['postalCode'] as String? ?? '',
            country: a['country'] as String? ?? 'EG',
            latitude: (a['latitude'] as num?)?.toDouble() ?? 0.0,
            longitude: (a['longitude'] as num?)?.toDouble() ?? 0.0,
            isDefault: a['isDefault'] as bool? ?? false,
            instructions: a['instructions'] as String? ?? '',
          ),
        ),
      );

    _paymentMethods
      ..clear()
      ..addAll(
        (MockData.paymentMethods[userId] ?? []).map(
          (p) => PaymentMethod(
            id: p['id'] as String,
            type: p['type'] as String,
            brand: p['brand'] as String,
            last4: p['last4'] as String? ?? '',
            expiryMonth: p['expiryMonth'] as int? ?? 0,
            expiryYear: p['expiryYear'] as int? ?? 0,
            isDefault: p['isDefault'] as bool? ?? false,
          ),
        ),
      );

    _isLoading = false;
    notifyListeners();
  }

  // ---- Basic info / preferences (PUT /customers/me) ----

  void updateBasicInfo({
    String? firstName,
    String? lastName,
    String? displayName,
    String? dateOfBirth,
  }) {
    if (firstName != null) _profile['firstName'] = firstName;
    if (lastName != null) _profile['lastName'] = lastName;
    if (displayName != null) _profile['displayName'] = displayName;
    if (dateOfBirth != null) _profile['dateOfBirth'] = dateOfBirth;
    _profile['updatedAt'] = DateTime.now().toIso8601String();
    notifyListeners();
  }

  void updatePreferences({String? language, String? currency, String? theme}) {
    if (language != null) _profile['languagePreference'] = language;
    if (currency != null) _profile['currencyPreference'] = currency;
    if (theme != null) _profile['themePreference'] = theme;
    notifyListeners();
  }

  void toggleConsent(String key, bool value) {
    // key: marketingConsent | pushNotificationEnabled | emailNotificationEnabled | smsNotificationEnabled
    _profile[key] = value;
    notifyListeners();
  }

  /// Simulated avatar change (no real image upload / CDN pipeline yet).
  void simulateAvatarChange() {
    final seed = DateTime.now().millisecondsSinceEpoch;
    _profile['avatarUrl'] = 'https://i.pravatar.cc/150?u=$seed';
    notifyListeners();
  }

  // ---- Email / phone change with simulated OTP ----
  // STUB: no real SMS/email is sent. The "code" is fixed and shown to the
  // user directly so the flow can be exercised end-to-end pre-backend.

  String requestEmailChange(String newEmail) {
    _pendingEmail = newEmail;
    _lastOtpSent = '123456';
    notifyListeners();
    return _lastOtpSent!;
  }

  bool confirmEmailChange(String code) {
    if (_pendingEmail == null || code != _lastOtpSent) return false;
    _profile['email'] = _pendingEmail;
    _pendingEmail = null;
    _lastOtpSent = null;
    notifyListeners();
    return true;
  }

  String requestPhoneChange(String newPhone) {
    _pendingPhone = newPhone;
    _lastOtpSent = '123456';
    notifyListeners();
    return _lastOtpSent!;
  }

  bool confirmPhoneChange(String code) {
    if (_pendingPhone == null || code != _lastOtpSent) return false;
    _profile['phone'] = _pendingPhone;
    _pendingPhone = null;
    _lastOtpSent = null;
    notifyListeners();
    return true;
  }

  void cancelPendingChange() {
    _pendingEmail = null;
    _pendingPhone = null;
    _lastOtpSent = null;
    notifyListeners();
  }

  // ---- Addresses (CUS-013) ----

  void addAddress(Address address) {
    if (address.isDefault || _addresses.isEmpty) {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }
    _addresses.add(address);
    notifyListeners();
  }

  void updateAddress(Address updated) {
    final idx = _addresses.indexWhere((a) => a.id == updated.id);
    if (idx < 0) return;
    if (updated.isDefault) {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }
    _addresses[idx] = updated;
    notifyListeners();
  }

  void deleteAddress(String id) {
    _addresses.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void setDefaultAddress(String id) {
    for (var i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i].copyWith(isDefault: _addresses[i].id == id);
    }
    notifyListeners();
  }

  // ---- Payment methods (mock only — see PaymentMethod doc comment) ----

  void addPaymentMethod(PaymentMethod method) {
    if (method.isDefault || _paymentMethods.isEmpty) {
      for (var i = 0; i < _paymentMethods.length; i++) {
        final m = _paymentMethods[i];
        _paymentMethods[i] = PaymentMethod(
          id: m.id,
          type: m.type,
          brand: m.brand,
          last4: m.last4,
          expiryMonth: m.expiryMonth,
          expiryYear: m.expiryYear,
          isDefault: false,
        );
      }
    }
    _paymentMethods.add(method);
    notifyListeners();
  }

  void deletePaymentMethod(String id) {
    _paymentMethods.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void setDefaultPaymentMethod(String id) {
    for (var i = 0; i < _paymentMethods.length; i++) {
      final m = _paymentMethods[i];
      _paymentMethods[i] = PaymentMethod(
        id: m.id,
        type: m.type,
        brand: m.brand,
        last4: m.last4,
        expiryMonth: m.expiryMonth,
        expiryYear: m.expiryYear,
        isDefault: m.id == id,
      );
    }
    notifyListeners();
  }

  // ---- Account-level actions (stubs pending real backend) ----

  Future<bool> requestDataExport() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true; // simulated success, matches checkout's mock-confirmation pattern
  }

  Future<bool> requestAccountDeletion() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true; // simulated success — no real deletion pipeline yet
  }

  void reset() {
    _profile = {};
    _addresses.clear();
    _paymentMethods.clear();
    _pendingEmail = null;
    _pendingPhone = null;
    _lastOtpSent = null;
    notifyListeners();
  }
}
