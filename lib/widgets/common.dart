import 'package:flutter/material.dart';

import '../theme.dart';

/// Barra superior morada usada en todas las pantallas.
AppBar wordupAppBar(BuildContext context, String title, {bool back = false}) {
  return AppBar(
    title: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppColors.white,
    ),),
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
    this.width = double.infinity,
    this.textStyle,
  });

  final String label;
  final VoidCallback onTap;
  final double height;
  final double width;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textStyle ?? Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.white,
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
              ),
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
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: buttonTextColor,
                ),
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
