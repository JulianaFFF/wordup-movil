import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  static const _words = [
    (
      'Defenestration',
      'Acto de arrojar a una persona o cosa por la ventana',
      'The act of throwing someone or something out of a window',
    ),
    (
      'Serendipity',
      'Hallazgo afortunado e inesperado',
      'The occurrence of fortunate events by chance',
    ),
  ];

  int _i = 0;
  bool _flipped = false;

  /// La segunda palabra solo aparece si el usuario ya conocía la primera.
  void _answer({required bool known}) {
    final extra = _i == 1;
    if (known && !extra) {
      setState(() {
        _i = 1;
        _flipped = false;
      });
      return;
    }
    showFeedbackDialog(
      context,
      message: extra
          ? '¡Eres genial!\nPróximamente desbloquearás más lecciones'
          : '¡Buen trabajo!',
      buttonLabel: 'Continuar',
      color: AppColors.secondary,
      onPressed: () => Navigator.of(context).pop(true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (word, es, en) = _words[_i];
    return Scaffold(
      appBar: wordupAppBar(context, 'Flashcard'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _flipped = !_flipped),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _flipped
                      ? _card(
                          key: const ValueKey('back'),
                          color: AppColors.soft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Significado/Meaning:',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Text(es, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge,),
                              const SizedBox(height: 16),
                              Text(en, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge,),
                            ],
                          ),
                        )
                      : _card(
                          key: const ValueKey('front'),
                          color: AppColors.primary,
                          child: Center(
                            child: Text(
                              word,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _answerButton(
                    'Ya conocía la palabra',
                    AppColors.highlight,
                    AppColors.black,
                    known: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _answerButton(
                    'Es una nueva palabra',
                    AppColors.secondary,
                    AppColors.white,
                    known: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({Key? key, required Color color, required Widget child}) {
    return Container(
      key: key,
      height: 392,
      width: 368,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: child,
    );
  }

  Widget _answerButton(
    String label,
    Color bg,
    Color fg, {
    required bool known,
  }) {
    return SizedBox(
      height: 60,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => _answer(known: known),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: fg,
          ),
        ),
      ),
    );
  }
}
