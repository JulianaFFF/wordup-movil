import 'package:flutter/material.dart';

import '../theme.dart';

/// Barra superior morada usada en todas las pantallas.
AppBar wordupAppBar(String title, {bool back = false}) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: back,
    toolbarHeight: 64,
  );
}

/// Botón grande verde (Home, Actividades, Crear Alarmas).
class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 125,
    this.fontSize = 22,
  });

  final String label;
  final VoidCallback onTap;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondary,
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Diálogo de retroalimentación (¡Buen trabajo!, error, etc.).
Future<void> showFeedbackDialog(
  BuildContext context, {
  required String message,
  required String buttonLabel,
  required Color color,
  Color buttonColor = AppColors.primary,
  Color buttonTextColor = AppColors.white,
  VoidCallback? onPressed,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => Dialog(
      backgroundColor: color,
      insetPadding: const EdgeInsets.symmetric(horizontal: 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.white, fontSize: 18),
            ),
            const SizedBox(height: 14),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                Navigator.of(ctx).pop();
                onPressed?.call();
              },
              child: Text(
                buttonLabel,
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Botón con ícono usado en los diálogos (Cancelar / Guardar / Crear...).
class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
