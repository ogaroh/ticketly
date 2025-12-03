import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Getting Started Section
            _buildSectionHeader(context, 'Getting Started'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFaqItem(
                      context,
                      'How do I log in?',
                      'Enter any valid email address and password. The app uses mock authentication, so any credentials will work.',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'How do I view tickets?',
                      'After logging in, you\'ll see the tickets list. Tap on any ticket to view its details.',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            // Managing Tickets Section
            _buildSectionHeader(context, 'Managing Tickets'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFaqItem(
                      context,
                      'How do I mark a ticket as resolved?',
                      '1. Tap on a ticket to open its details\n2. Scroll down and tap "Mark as Resolved"\n3. Confirm your action in the dialog',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'Can I undo a resolved ticket?',
                      'No, once a ticket is marked as resolved, it cannot be unmarked. The resolution is permanent.',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'How do I refresh the ticket list?',
                      'Pull down on the tickets list to refresh and get the latest data from the server.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // App Features Section
            _buildSectionHeader(context, 'App Features'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFaqItem(
                      context,
                      'Does the app work offline?',
                      'The app requires an internet connection to fetch tickets. However, resolved ticket status is saved locally.',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'Where is my data stored?',
                      'Your login status and resolved tickets are stored locally on your device using secure storage.',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'How do I switch between light and dark mode?',
                      'Go to Profile > Settings > Theme and select your preferred theme option.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Troubleshooting Section
            _buildSectionHeader(context, 'Troubleshooting'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFaqItem(
                      context,
                      'Tickets not loading?',
                      '1. Check your internet connection\n2. Pull to refresh the tickets list\n3. Restart the app if the problem persists',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'App running slowly?',
                      'Try clearing the app cache from Settings > Storage > Clear Cache.',
                    ),
                    const Divider(),
                    _buildFaqItem(
                      context,
                      'Lost your resolved tickets?',
                      'Resolved ticket status is saved locally. If you cleared app data or reinstalled, this information will be lost.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Contact Support
            _buildSectionHeader(context, 'Contact Support'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: const Text('Email Support'),
                      subtitle: const Text('support@ticketapp.com'),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email support feature coming soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.chat, color: Colors.green),
                      title: const Text('Live Chat'),
                      subtitle: const Text('Available 9 AM - 5 PM EST'),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Live chat feature coming soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.feedback, color: Colors.orange),
                      title: const Text('Send Feedback'),
                      subtitle: const Text('Help us improve the app'),
                      onTap: () {
                        _showFeedbackDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // App Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Version: 1.0.0'),
                    const SizedBox(height: 4),
                    const Text('Build: 100'),
                    const SizedBox(height: 4),
                    const Text('Built with Flutter & Material 3'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _showPrivacyPolicy(context);
                          },
                          child: const Text('Privacy Policy'),
                        ),
                        const Text(' • '),
                        TextButton(
                          onPressed: () {
                            _showTermsOfService(context);
                          },
                          child: const Text('Terms of Service'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
        ),
      ],
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
            const Text('We\'d love to hear your thoughts!'),
            const SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              decoration: const InputDecoration(
                hintText: 'Tell us what you think...',
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

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'This app is designed to demonstrate Flutter development skills. '
            'No personal data is collected or transmitted to external servers. '
            'All user preferences and ticket resolution status are stored locally on your device. '
            'The app fetches sample ticket data from a public API for demonstration purposes only.',
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

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Text(
            'This is a demonstration app built for educational purposes. '
            'Use of this app is entirely at your own risk. '
            'This app is provided "as is" without any warranties. '
            'The app uses mock authentication and sample data for demonstration purposes only.',
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
}