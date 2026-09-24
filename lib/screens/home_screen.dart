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
        title: Text('Inglés', style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.white,
        )),
        actions: [
          const Icon(Icons.local_fire_department_outlined, size: 30),
          const SizedBox(width: 4),
          Text('12', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.white,
          )),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BigButton(label: 'Palabras\nRecomendadas', onTap: () {}, height: 250),
            BigButton(label: 'Iniciar Actividad', onTap: onStartActivity, height: 250),
          ],
        ),
      ),
    );
  }
}
