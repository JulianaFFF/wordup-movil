import 'package:flutter/material.dart';

import '../theme.dart';
import 'common.dart';

const dayLetters = ['L', 'M', 'Mi', 'J', 'V', 'S', 'D'];
const dayNames = [
  'Lunes',
  'Martes',
  'Miércoles',
  'Jueves',
  'Viernes',
  'Sábado',
  'Domingo',
];

class AlarmDraft {
  AlarmDraft(this.days, this.start, this.end, this.count);

  final Set<int> days;
  final TimeOfDay start;
  final TimeOfDay end;
  final int count;
}

/// "Card Date and hour": días, rango de horas y cantidad de alarmas.
/// Devuelve null si se cancela.
Future<AlarmDraft?> showAlarmCardDialog(
  BuildContext context, {
  Set<int> initialDays = const {},
  TimeOfDay start = const TimeOfDay(hour: 8, minute: 0),
  TimeOfDay end = const TimeOfDay(hour: 9, minute: 0),
  int count = 1,
  required String confirmLabel,
  required IconData confirmIcon,
  bool singleDay = false,
}) {
  return showDialog<AlarmDraft>(
    context: context,
    builder: (_) => _AlarmCard(
      days: {...initialDays},
      start: start,
      end: end,
      count: count,
      confirmLabel: confirmLabel,
      confirmIcon: confirmIcon,
      singleDay: singleDay,
    ),
  );
}

class _AlarmCard extends StatefulWidget {
  const _AlarmCard({
    required this.days,
    required this.start,
    required this.end,
    required this.count,
    required this.confirmLabel,
    required this.confirmIcon,
    required this.singleDay,
  });

  final Set<int> days;
  final TimeOfDay start;
  final TimeOfDay end;
  final int count;
  final String confirmLabel;
  final IconData confirmIcon;
  final bool singleDay;

  @override
  State<_AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<_AlarmCard> {
  late Set<int> _days = widget.days;
  late TimeOfDay _start = widget.start;
  late TimeOfDay _end = widget.end;
  late int _count = widget.count;

  Future<void> _pick(bool isStart) async {
    final t = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.white,
            onPrimary: AppColors.secondary,
            surface: AppColors.secondary,
            onSurface: AppColors.white,
            surfaceContainerHigh: AppColors.secondary,
            secondaryContainer: AppColors.white,
            onSecondaryContainer: AppColors.black,
            onSurfaceVariant: AppColors.black,
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      ),
    );
    if (t == null) return;
    setState(() => isStart ? _start = t : _end = t);
  }

  @override
  Widget build(BuildContext context) {
    final label = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppColors.primary,
    );
    return Dialog(
      backgroundColor: AppColors.soft,
      elevation: 12,
      shadowColor: Colors.black,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Días:', style: label),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < 7; i++)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() {
                      if (widget.singleDay) {
                        _days = {i};
                      } else {
                        _days.contains(i) ? _days.remove(i) : _days.add(i);
                      }
                    }),
                    child: Column(
                      children: [
                        Text(
                          dayLetters[i],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _radio(_days.contains(i)),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Rango de Horas:', style: label),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _timeField('Inicio', _start, () => _pick(true)),
                ),
                const SizedBox(width: 12),
                Expanded(child: _timeField('Fin', _end, () => _pick(false))),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text('Cantidad alarmas:', style: label),
                  ),
                ),
                _counterButton(Icons.add, () => setState(() => _count++)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('$_count', style: Theme.of(context).textTheme.titleLarge),
                ),
                _counterButton(Icons.remove, () {
                  if (_count > 1) setState(() => _count--);
                }),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DialogButton(
                  label: 'Cancelar',
                  icon: Icons.close,
                  color: AppColors.error,
                  onTap: () => Navigator.of(context).pop(),
                ),
                DialogButton(
                  label: widget.confirmLabel,
                  icon: widget.confirmIcon,
                  color: AppColors.secondary,
                  onTap: () => Navigator.of(
                    context,
                  ).pop(AlarmDraft(_days, _start, _end, _count)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _radio(bool selected) => Container(
    width: 22,
    height: 22,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.secondary, width: 2),
    ),
    child: selected
        ? Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary,
            ),
          )
        : null,
  );

  Widget _counterButton(IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(icon, size: 26),
    ),
  );

  Widget _timeField(String title, TimeOfDay t, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.star, size: 20, color: AppColors.white),
            ),
          ),
        ),
        child: Text(_fmt(t), style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }

  String _fmt(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
