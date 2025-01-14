// mindfulness_exercises_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mental_wellness_companion/pages/custom_bottom_navigation_bar.dart';

class MindfulnessExercisesPage extends StatefulWidget {
  const MindfulnessExercisesPage({Key? key}) : super(key: key);

  @override
  _MindfulnessExercisesPageState createState() =>
      _MindfulnessExercisesPageState();
}

class _MindfulnessExercisesPageState extends State<MindfulnessExercisesPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // To keep track of the currently playing exercise
  String? _currentlyPlayingExercise;

  final List<Map<String, String>> exercises = [
    {
      'title': 'Deep Breathing',
      'duration': '5 mins',
      'description': 'A simple breathing exercise to calm your mind.',
      'audio': 'deep_breathing.mp3',
      'image': 'exercise1.png',
    },
    {
      'title': 'Body Scan Meditation',
      'duration': '10 mins',
      'description': 'Focus on different parts of your body.',
      'audio': 'body_scan_meditation.mp3',
      'image': 'exercise2.jpg',
    },
    {
      'title': 'Mindful Walking',
      'duration': '15 mins',
      'description': 'Be present while walking.',
      'audio': 'mindful_walking.mp3',
      'image': 'exercise3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Listen for when the audio completes
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _currentlyPlayingExercise = null;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playExercise(String fileName) async {
    try {
      // If another exercise is playing, stop it
      if (_currentlyPlayingExercise != null) {
        await _audioPlayer.stop();
      }

      // Play the selected exercise from assets
      await _audioPlayer.play(AssetSource('audio/$fileName'));
      setState(() {
        _currentlyPlayingExercise = fileName;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Playing $fileName')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to play audio: $e')),
      );
    }
  }

  void _pauseExercise() async {
    await _audioPlayer.pause();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exercise audio paused')),
    );
  }

  void _stopExercise() async {
    await _audioPlayer.stop();
    setState(() {
      _currentlyPlayingExercise = null;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exercise audio stopped')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindfulness Exercises'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          final isPlaying = _currentlyPlayingExercise == exercise['audio'];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              leading: Image.asset(
                'assets/image/${exercise['image']}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(exercise['title']!),
              subtitle:
                  Text('${exercise['duration']} - ${exercise['description']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        _pauseExercise();
                      } else {
                        _playExercise(exercise['audio']!);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.stop,
                      color: Colors.redAccent,
                    ),
                    onPressed: isPlaying ? _stopExercise : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
    );
  }
}
