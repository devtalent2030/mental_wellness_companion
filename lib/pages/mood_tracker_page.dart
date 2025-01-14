import 'package:flutter/material.dart';
import 'package:mental_wellness_companion/pages/custom_bottom_navigation_bar.dart';

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({Key? key}) : super(key: key);

  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  String selectedMood = '';
  final TextEditingController _notesController = TextEditingController();
  List<Map<String, String>> moodHistory = [];

  void _saveMood() {
    if (selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood')),
      );
      return;
    }

    setState(() {
      moodHistory.add({
        'mood': selectedMood,
        'notes': _notesController.text,
        'date': DateTime.now().toString().substring(0, 16),
      });
      selectedMood = '';
      _notesController.clear();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How are you feeling today?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List<Widget>.generate(
                6,
                (index) => _moodButton(
                    [
                      'Happy',
                      'Sad',
                      'Anxious',
                      'Calm',
                      'Angry',
                      'Stressed'
                    ][index],
                    ['😊', '😢', '😰', '😌', '😠', '😩'][index]),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: _saveMood,
              child: const Text('Save'),
            ),
            const SizedBox(height: 30),
            const Text('Mood History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            if (moodHistory.isEmpty)
              const Text('No mood entries yet.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: moodHistory.length,
                itemBuilder: (context, index) {
                  final entry = moodHistory[index];
                  return ListTile(
                    leading: Text(_getMoodEmoji(entry['mood']!),
                        style: const TextStyle(fontSize: 30)),
                    title: Text(entry['mood']!),
                    subtitle: Text('${entry['date']}\n${entry['notes']}'),
                    isThreeLine: true,
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
    );
  }

  Widget _moodButton(String mood, String emoji) {
    return ChoiceChip(
      label: Text(emoji),
      selected: selectedMood == mood,
      onSelected: (bool selected) {
        setState(() {
          selectedMood = selected ? mood : '';
        });
      },
      selectedColor: Colors.blue.shade100,
    );
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'Happy':
        return '😊';
      case 'Sad':
        return '😢';
      case 'Anxious':
        return '😰';
      case 'Calm':
        return '😌';
      case 'Angry':
        return '😠';
      case 'Stressed':
        return '😩';
      default:
        return '😐';
    }
  }
}
