// custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_companion/pages/home_page.dart';
import 'package:mental_wellness_companion/pages/mood_tracker_page.dart';
import 'package:mental_wellness_companion/pages/mindfulness_exercises_page.dart';
import 'package:mental_wellness_companion/pages/relaxation_sounds_page.dart';
import 'package:mental_wellness_companion/pages/settings_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MoodTrackerPage()),
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MindfulnessExercisesPage()),
          (route) => false,
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RelaxationSoundsPage()),
          (route) => false,
        );
        break;
      case 4:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mood),
          label: 'Mood',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement),
          label: 'Exercises',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Sounds',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
