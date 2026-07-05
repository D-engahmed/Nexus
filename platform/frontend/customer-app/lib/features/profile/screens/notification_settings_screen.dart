import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/profile_provider.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final p = provider.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Notifications & Privacy')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Notification channels',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Push notifications'),
                  subtitle: const Text(
                    'Order updates and offers on this device',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: p['pushNotificationEnabled'] as bool,
                  onChanged: (v) => context
                      .read<ProfileProvider>()
                      .toggleConsent('pushNotificationEnabled', v),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Email notifications'),
                  subtitle: const Text(
                    'Receipts and account updates',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: p['emailNotificationEnabled'] as bool,
                  onChanged: (v) => context
                      .read<ProfileProvider>()
                      .toggleConsent('emailNotificationEnabled', v),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('SMS notifications'),
                  subtitle: const Text(
                    'Order status via text message',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: p['smsNotificationEnabled'] as bool,
                  onChanged: (v) => context
                      .read<ProfileProvider>()
                      .toggleConsent('smsNotificationEnabled', v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Privacy',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Card(
            child: SwitchListTile(
              title: const Text('Marketing communications'),
              subtitle: const Text(
                'Promotions and product news',
                style: TextStyle(fontSize: 12),
              ),
              value: p['marketingConsent'] as bool,
              onChanged: (v) => context.read<ProfileProvider>().toggleConsent(
                'marketingConsent',
                v,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
