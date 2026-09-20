import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';
import 'flashcard_screen.dart';
import 'meaning_screen.dart';
import 'pronunciation_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final _done = <String>{};

  Future<void> _open(String name, Widget screen) async {
    final completed = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => screen));
    if (completed == true) setState(() => _done.add(name));
  }

  Widget _activity(String name, Widget screen) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BigButton(
          label: name,
          height: 100,
          fontSize: 18,
          onTap: () => _open(name, screen),
        ),
        if (_done.contains(name))
          Positioned(
            top: -8,
            right: -8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.highlight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.check, color: AppColors.white, size: 24),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wordupAppBar('Actividades', back: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _activity('Flashcard', const FlashcardScreen()),
            _activity('Significado', const MeaningScreen()),
            _activity('Pronunciación', const PronunciationScreen()),
          ],
        ),
      ),
    );
  }
}
