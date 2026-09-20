import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class PronunciationScreen extends StatefulWidget {
  const PronunciationScreen({super.key});

  @override
  State<PronunciationScreen> createState() => _PronunciationScreenState();
}

class _PronunciationScreenState extends State<PronunciationScreen> {
  bool _recording = false;

  void _toggleMic() {
    setState(() => _recording = !_recording);
    if (!_recording) {
      showFeedbackDialog(
        context,
        message: '¡Buen trabajo!',
        buttonLabel: 'Continuar',
        color: AppColors.primary,
        buttonColor: AppColors.secondary,
        onPressed: () => Navigator.of(context).pop(true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wordupAppBar('Pronunciación', back: true),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Defenestration',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "/diː.fen.ɪˈstreɪ.ʃən/",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 24),
              IconButton(
                iconSize: 64,
                color: AppColors.secondary,
                icon: const Icon(Icons.volume_up),
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              const Text(
                'Significado/meaning:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                'Acto de arrojar a una persona o cosa por la ventana',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11),
              ),
              const SizedBox(height: 12),
              const Text(
                'The act of throwing someone or something out of a window',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11),
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: _toggleMic,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: _recording
                      ? AppColors.error
                      : AppColors.secondary,
                  child: Icon(
                    _recording ? Icons.stop : Icons.mic,
                    color: AppColors.white,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
