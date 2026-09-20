import 'package:flutter_test/flutter_test.dart';

import 'package:wordup/main.dart';

void main() {
  testWidgets('Home navega a Actividades', (WidgetTester tester) async {
    await tester.pumpWidget(const WordupApp());

    expect(find.text('Iniciar Actividad'), findsOneWidget);
    await tester.tap(find.text('Iniciar Actividad'));
    await tester.pumpAndSettle();

    expect(find.text('Flashcard'), findsOneWidget);
  });
}
