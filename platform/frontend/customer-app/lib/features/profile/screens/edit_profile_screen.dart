import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _displayNameCtrl;
  String _language = 'en';
  String _currency = 'EGP';
  String _theme = 'system';

  @override
  void initState() {
    super.initState();
    final p = context.read<ProfileProvider>().profile;
    _firstNameCtrl = TextEditingController(
      text: p['firstName'] as String? ?? '',
    );
    _lastNameCtrl = TextEditingController(text: p['lastName'] as String? ?? '');
    _displayNameCtrl = TextEditingController(
      text: p['displayName'] as String? ?? '',
    );
    _language = p['languagePreference'] as String? ?? 'en';
    _currency = p['currencyPreference'] as String? ?? 'EGP';
    _theme = p['themePreference'] as String? ?? 'system';
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _displayNameCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final provider = context.read<ProfileProvider>();
    provider.updateBasicInfo(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      displayName: _displayNameCtrl.text.trim(),
    );
    provider.updatePreferences(
      language: _language,
      currency: _currency,
      theme: _theme,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile updated')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final p = profile.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _firstNameCtrl,
            decoration: const InputDecoration(labelText: 'First name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lastNameCtrl,
            decoration: const InputDecoration(labelText: 'Last name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _displayNameCtrl,
            decoration: const InputDecoration(
              labelText: 'Display name (optional)',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Preferences',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _language,
            decoration: const InputDecoration(labelText: 'Language'),
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'ar', child: Text('العربية')),
            ],
            onChanged: (v) => setState(() => _language = v ?? _language),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _currency,
            decoration: const InputDecoration(labelText: 'Currency'),
            items: const [
              DropdownMenuItem(
                value: 'EGP',
                child: Text('EGP — Egyptian Pound'),
              ),
              DropdownMenuItem(value: 'USD', child: Text('USD — US Dollar')),
            ],
            onChanged: (v) => setState(() => _currency = v ?? _currency),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _theme,
            decoration: const InputDecoration(labelText: 'Theme'),
            items: const [
              DropdownMenuItem(value: 'system', child: Text('System')),
              DropdownMenuItem(value: 'light', child: Text('Light')),
              DropdownMenuItem(value: 'dark', child: Text('Dark')),
            ],
            onChanged: (v) => setState(() => _theme = v ?? _theme),
          ),
          const SizedBox(height: 24),
          const Text(
            'Contact details',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 4),
          const Text(
            'Changing email or phone requires code verification (simulated — no real SMS/email is sent yet).',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          _ContactRow(
            label: 'Email',
            value: p['email'] as String,
            onChange: () => _showChangeDialog(context, isEmail: true),
          ),
          const SizedBox(height: 8),
          _ContactRow(
            label: 'Phone',
            value: p['phone'] as String,
            onChange: () => _showChangeDialog(context, isEmail: false),
          ),
          const SizedBox(height: 28),
          ElevatedButton(onPressed: _save, child: const Text('Save Changes')),
        ],
      ),
    );
  }

  void _showChangeDialog(BuildContext context, {required bool isEmail}) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEmail ? 'Change email' : 'Change phone'),
        content: TextField(
          controller: controller,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : TextInputType.phone,
          decoration: InputDecoration(
            labelText: isEmail ? 'New email' : 'New phone',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isEmpty) return;
              final provider = context.read<ProfileProvider>();
              final code = isEmail
                  ? provider.requestEmailChange(value)
                  : provider.requestPhoneChange(value);
              Navigator.pop(dialogContext);
              _showOtpDialog(context, isEmail: isEmail, sentCode: code);
            },
            child: const Text('Send Code'),
          ),
        ],
      ),
    );
  }

  void _showOtpDialog(
    BuildContext context, {
    required bool isEmail,
    required String sentCode,
  }) {
    final otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Enter verification code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simulated code (no real message sent): $sentCode',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '6-digit code'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProfileProvider>().cancelPendingChange();
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final provider = context.read<ProfileProvider>();
              final ok = isEmail
                  ? provider.confirmEmailChange(otpController.text.trim())
                  : provider.confirmPhoneChange(otpController.text.trim());
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ok
                        ? (isEmail ? 'Email updated' : 'Phone updated')
                        : 'Invalid code',
                  ),
                ),
              );
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onChange;

  const _ContactRow({
    required this.label,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        TextButton(onPressed: onChange, child: const Text('Change')),
      ],
    );
  }
}
