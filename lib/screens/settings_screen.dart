import 'package:flutter/material.dart';

import '../widgets/common.dart';

/// Pestaña Ajustes: sin contenido por ahora.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: wordupAppBar('Ajustes'));
  }
}
