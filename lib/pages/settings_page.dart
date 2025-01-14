// settings_page.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_companion/pages/custom_bottom_navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            onTap: () {
              // profile editing functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile tapped')),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: darkMode,
            onChanged: (bool value) {
              setState(() {
                darkMode = value;
                // theme switching functionality
              });
            },
            secondary: const Icon(Icons.brightness_6),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // about dialog
              showAboutDialog(
                context: context,
                applicationName: 'Mental Wellness Companion',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.local_florist),
                children: [
                  const Text(
                      'This app is designed to help you with your mental wellness journey.'),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout tapped')),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 4),
    );
  }
}
