// main.dart
import 'package:flutter/material.dart';
import 'package:mental_wellness_companion/pages/home_page.dart';
import 'package:mental_wellness_companion/pages/mood_tracker_page.dart';
import 'package:mental_wellness_companion/pages/mindfulness_exercises_page.dart';
import 'package:mental_wellness_companion/pages/relaxation_sounds_page.dart';
import 'package:mental_wellness_companion/pages/settings_page.dart';

// color shades for custom MaterialColor
const Map<int, Color> colorCodes = {
  50: Color.fromRGBO(6, 155, 19, .1),
  100: Color.fromRGBO(6, 155, 19, .2),
  200: Color.fromRGBO(6, 155, 19, .3),
  300: Color.fromRGBO(6, 155, 19, .4),
  400: Color.fromRGBO(6, 155, 19, .5),
  500: Color.fromRGBO(6, 155, 19, .6),
  600: Color.fromRGBO(6, 155, 19, .7),
  700: Color.fromRGBO(6, 155, 19, .8),
  800: Color.fromRGBO(6, 155, 19, .9),
  900: Color.fromRGBO(6, 155, 19, 1),
};

// customColor using colorCodes
const MaterialColor customColor = MaterialColor(0xFF069B13, colorCodes);

void main() {
  runApp(const MentalWellnessCompanionApp());
}

class MentalWellnessCompanionApp extends StatelessWidget {
  const MentalWellnessCompanionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Wellness Companion',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/moodTracker': (context) => const MoodTrackerPage(),
        '/exercises': (context) => const MindfulnessExercisesPage(),
        '/sounds': (context) => const RelaxationSoundsPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
