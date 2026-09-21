import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class MeaningScreen extends StatelessWidget {
  const MeaningScreen({super.key});

  static const _options = [
    'The act of throwing someone or something out of a window.',
    'Send an object through the air by moving your hand and arm quickly.',
    'To drop down from a higher place to a lower one.',
    "To slide, lose one's balance or move smoothly and quietly.",
  ];
  static const _correct = 0;

  void _select(BuildContext context, int i) {
    if (i == _correct) {
      showFeedbackDialog(
        context,
        message: '¡Buen trabajo!',
        buttonLabel: 'Continuar',
        color: AppColors.secondary,
        buttonColor: AppColors.white,
        buttonTextColor: AppColors.primary,
        onPressed: () => Navigator.of(context).pop(true),
      );
    } else {
      showFeedbackDialog(
        context,
        message: 'Esta no es la respuesta correcta ¿quieres intentar otra vez?',
        buttonLabel: 'Intentar otra vez',
        color: AppColors.error,
        buttonColor: AppColors.white,
        buttonTextColor: AppColors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wordupAppBar('Significado', back: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Defenestration',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Choose the right meaning',
              style: TextStyle(fontSize: 12),
            ),
            const Spacer(),
            for (var i = 0; i < _options.length; i++) ...[
              InkWell(
                onTap: () => _select(context, i),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.highlight,
                      child: Text(
                        String.fromCharCode(65 + i),
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _options[i],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
