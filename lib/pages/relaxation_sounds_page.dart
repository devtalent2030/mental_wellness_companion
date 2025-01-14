// relaxation_sounds_page.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mental_wellness_companion/pages/custom_bottom_navigation_bar.dart';

class RelaxationSoundsPage extends StatefulWidget {
  const RelaxationSoundsPage({Key? key}) : super(key: key);

  @override
  _RelaxationSoundsPageState createState() => _RelaxationSoundsPageState();
}

class _RelaxationSoundsPageState extends State<RelaxationSoundsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // To keep track of the currently playing audio
  String? _currentlyPlaying;

  final List<Map<String, dynamic>> sounds = [
    {
      'title': 'Rainfall',
      'duration': '3 mins',
      'audio': 'rain_fall.mp3',
      'image': 'rain_fall.jpg',
    },
    {
      'title': 'Ocean Waves',
      'duration': '3 mins',
      'audio': 'ocean_waves.mp3',
      'image': 'ocean_waves.jpg',
    },
    {
      'title': 'Forest Ambience',
      'duration': '3 mins',
      'audio': 'forest_ambience.mp3',
      'image': 'forest_ambience.jpg',
    },
    {
      'title': 'Wind Chimes',
      'duration': '3 mins',
      'audio': 'wind_chimes.mp3',
      'image': 'wind_chimes.jpg',
    },
    {
      'title': 'Mountain',
      'duration': '3 mins',
      'audio': 'mountain.mp3',
      'image': 'mountain.jpg',
    },
    {
      'title': 'Night Crickets',
      'duration': '3 mins',
      'audio': 'night_crickets.mp3',
      'image': 'night_crickets.jpg',
    },
    {
      'title': 'Bird Nature',
      'duration': '3 mins',
      'audio': 'bird_nature.mp3',
      'image': 'bird_nature.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Optional: Listen to audio player state changes
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _currentlyPlaying = null;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound(String fileName) async {
    try {
      // If another sound is playing, stop it
      if (_currentlyPlaying != null) {
        await _audioPlayer.stop();
      }

      // Play the selected sound from assets
      await _audioPlayer.play(AssetSource('audio/$fileName'));
      setState(() {
        _currentlyPlaying = fileName;
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

  void _pauseSound() async {
    await _audioPlayer.pause();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Audio paused')),
    );
  }

  void _stopSound() async {
    await _audioPlayer.stop();
    setState(() {
      _currentlyPlaying = null;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Audio stopped')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relaxation Sounds'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sounds.length,
        itemBuilder: (context, index) {
          final sound = sounds[index];
          final isPlaying = _currentlyPlaying == sound['audio'];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              leading: Image.asset(
                'assets/image/${sound['image']}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(sound['title']),
              subtitle: Text('Duration: ${sound['duration']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        _pauseSound();
                      } else {
                        _playSound(sound['audio']);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.stop,
                      color: Colors.redAccent,
                    ),
                    onPressed: isPlaying ? _stopSound : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 3),
    );
  }
}
