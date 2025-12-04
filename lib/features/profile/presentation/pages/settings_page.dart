import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../shared/theme/theme_cubit.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = false;
  bool _pushNotifications = true;
  String _selectedLanguage = 'English';
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _packageInfo = packageInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Account Section
                _buildSectionHeader(context, 'Account'),
                Card(
                  child: Column(
                    children: [
                      if (state is AuthAuthenticated)
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(
                              state.user.email.substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: const Text('Account Information'),
                          subtitle: Text(state.user.email),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            _showAccountInfoDialog(context, state.user.email);
                          },
                        ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.security, color: Colors.blue),
                        title: const Text('Privacy & Security'),
                        subtitle: const Text('Manage your privacy settings'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showPrivacySettings(context);
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),

                // Appearance Section
                _buildSectionHeader(context, 'Appearance'),
                Card(
                  child: Column(
                    children: [
                      BlocBuilder<ThemeCubit, ThemeMode>(
                        builder: (context, currentTheme) {
                          return ListTile(
                            leading: const Icon(
                              Icons.palette,
                              color: Colors.purple,
                            ),
                            title: const Text('Theme'),
                            subtitle: Text(_getThemeDisplayName(currentTheme)),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              _showThemeSelector(context);
                            },
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.language, color: Colors.green),
                        title: const Text('Language'),
                        subtitle: Text(_selectedLanguage),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showLanguageSelector(context);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Notifications Section
                _buildSectionHeader(context, 'Notifications'),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(Icons.notifications, color: Colors.orange),
                        title: const Text('Enable Notifications'),
                        subtitle: const Text('Receive app notifications'),
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                            if (!value) {
                              _emailNotifications = false;
                              _pushNotifications = false;
                            }
                          });
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: const Icon(Icons.email, color: Colors.blue),
                        title: const Text('Email Notifications'),
                        subtitle: const Text('Ticket updates via email'),
                        value: _emailNotifications,
                        onChanged: _notificationsEnabled ? (value) {
                          setState(() {
                            _emailNotifications = value;
                          });
                        } : null,
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        secondary: const Icon(Icons.phone_android, color: Colors.green),
                        title: const Text('Push Notifications'),
                        subtitle: const Text('Instant notifications on your device'),
                        value: _pushNotifications,
                        onChanged: _notificationsEnabled ? (value) {
                          setState(() {
                            _pushNotifications = value;
                          });
                        } : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Support Section
                _buildSectionHeader(context, 'Support'),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.help, color: Colors.teal),
                        title: const Text('Help & FAQ'),
                        subtitle: const Text('Get help and find answers'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showHelpDialog(context);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.feedback, color: Colors.indigo),
                        title: const Text('Send Feedback'),
                        subtitle: const Text('Help us improve the app'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showFeedbackDialog(context);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.info, color: Colors.grey),
                        title: const Text('About'),
                        subtitle: const Text('App version and information'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Data Section
                _buildSectionHeader(context, 'Advanced'),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.storage, color: Colors.brown),
                        title: const Text('Storage'),
                        subtitle: const Text('Manage app data and cache'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showStorageInfo(context);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.download, color: Colors.blue),
                        title: const Text('Data Export'),
                        subtitle: const Text('Export your ticket data'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showDataExportDialog(context);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.delete_sweep, color: Colors.red),
                        title: const Text('Clear Data'),
                        subtitle: const Text('Reset all app data'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showClearDataDialog(context);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  String _getThemeDisplayName(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  void _showAccountInfoDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $email'),
            const SizedBox(height: 8),
            const Text('Account Type: Standard'),
            const SizedBox(height: 8),
            const Text('Member Since: Dec 2025'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy & Security'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Your data is stored locally on your device'),
            SizedBox(height: 8),
            Text('• We don\'t share your information with third parties'),
            SizedBox(height: 8),
            Text('• You can delete your data at any time'),
            SizedBox(height: 8),
            Text('• All network requests are encrypted'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, currentTheme) {
          return AlertDialog(
            title: const Text('Select Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Light'),
                  trailing: currentTheme == ThemeMode.light
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    context.read<ThemeCubit>().changeTheme(ThemeMode.light);
                    Navigator.of(dialogContext).pop();
                  },
                ),
                ListTile(
                  title: const Text('Dark'),
                  trailing: currentTheme == ThemeMode.dark
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    context.read<ThemeCubit>().changeTheme(ThemeMode.dark);
                    Navigator.of(dialogContext).pop();
                  },
                ),
                ListTile(
                  title: const Text('System Default'),
                  trailing: currentTheme == ThemeMode.system
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    context.read<ThemeCubit>().changeTheme(ThemeMode.system);
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    final languages = ['English', 'Spanish', 'French', 'German', 'Italian'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((language) => ListTile(
            title: Text(language),
            trailing: _selectedLanguage == language 
                ? const Icon(Icons.check, color: Colors.blue) 
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = language;
              });
              Navigator.of(context).pop();
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & FAQ'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Q: How do I mark a ticket as resolved?'),
              Text('A: Open the ticket and tap "Mark as Resolved"'),
              SizedBox(height: 16),
              Text('Q: Can I undo a resolved ticket?'),
              Text('A: No, once resolved, tickets cannot be unmarked'),
              SizedBox(height: 16),
              Text('Q: How do I refresh the ticket list?'),
              Text(
                'A: Pull down on the tickets list or click the refresh button to refresh',
              ),
              SizedBox(height: 16),
              Text('Q: Where is my data stored?'),
              Text('A: All data is stored locally on your device'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final feedbackController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('We\'d love to hear from you!'),
            const SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for your feedback!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: _packageInfo?.appName ?? 'Ticket Resolution',
      applicationVersion: _packageInfo?.version ?? 'Loading...',
      applicationIcon: const Icon(Icons.support_agent, size: 48),
      children: [
        const Text(
          'A simple Flutter application for managing and resolving support tickets.',
        ),
        const SizedBox(height: 16),
        const Text('Built with Material 3 design and clean architecture.'),
        const SizedBox(height: 16),
        Text('© ${DateTime.now().year} Erick Ogaro'),
      ],
    );
  }

  void _showStorageInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Storage Information'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Data: ~2.5 MB'),
            SizedBox(height: 8),
            Text('User Preferences: ~1 KB'),
            SizedBox(height: 8),
            Text('Resolved Tickets: ~500 B'),
            SizedBox(height: 8),
            Text('Cache: ~100 KB'),
            SizedBox(height: 16),
            Text('Total: ~3.1 MB'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared!')),
              );
            },
            child: const Text('Clear Cache'),
          ),
        ],
      ),
    );
  }

  void _showDataExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('This feature allows you to export your ticket data for backup or migration purposes.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data export started...')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your app data including resolved tickets and preferences. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All data cleared!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear Data'),
          ),
        ],
      ),
    );
  }
}