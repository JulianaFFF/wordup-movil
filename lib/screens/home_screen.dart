import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onStartActivity});

  final VoidCallback onStartActivity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        centerTitle: false,
        title: const Text('Inglés'),
        actions: const [
          Icon(Icons.local_fire_department_outlined, size: 18),
          SizedBox(width: 4),
          Text('12', style: TextStyle(color: AppColors.white, fontSize: 12)),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BigButton(label: 'Palabras\nRecomendadas', onTap: () {}),
            BigButton(label: 'Iniciar Actividad', onTap: onStartActivity),
          ],
        ),
      ),
    );
  }
}
