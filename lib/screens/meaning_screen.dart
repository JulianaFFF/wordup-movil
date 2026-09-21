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
      appBar: wordupAppBar(context, 'Significado'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Defenestration',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the right meaning',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 65),
            for (var i = 0; i < _options.length; i++) ...[
              InkWell(
                onTap: () => _select(context, i),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.highlight,
                      child: Text(
                        String.fromCharCode(65 + i),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        _options[i],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ],
        ),
      ),
    );
  }
}
