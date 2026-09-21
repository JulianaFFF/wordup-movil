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
      appBar: wordupAppBar(context, 'Pronunciación'),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Text(
                'Defenestration',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                "/diː.fen.ɪˈstreɪ.ʃən/",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              IconButton(
                iconSize: 130,
                color: AppColors.secondary,
                icon: const Icon(Icons.volume_up_outlined),
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              Text(
                'Significado/meaning:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 325,
                child: Text(
                  'Acto de arrojar a una persona o cosa por la ventana',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 325,
                child: Text(
                  'The act of throwing someone or something out of a window',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: _toggleMic,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: _recording
                      ? AppColors.primary
                      : AppColors.secondary,
                  child: Icon(
                    _recording ? Icons.mic : Icons.mic,
                    color: AppColors.white,
                    size: 100,
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
