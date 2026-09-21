import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/alarm_card_dialog.dart';
import '../widgets/common.dart';
import 'create_alarm_screen.dart';

class _Alarm {
  _Alarm(this.day, this.start, this.end);

  int day;
  TimeOfDay start;
  TimeOfDay end;
  bool enabled = true;
}

class AlarmsScreen extends StatefulWidget {
  const AlarmsScreen({super.key});

  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  final _alarms = [
    _Alarm(
      0,
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 11, minute: 35),
    ),
    _Alarm(
      3,
      const TimeOfDay(hour: 10, minute: 45),
      const TimeOfDay(hour: 18, minute: 0),
    ),
    _Alarm(
      4,
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 20, minute: 0),
    ),
  ];

  Future<void> _edit(_Alarm a) async {
    final r = await showAlarmCardDialog(
      context,
      initialDays: {a.day},
      start: a.start,
      end: a.end,
      confirmLabel: 'Guardar',
      confirmIcon: Icons.check,
      singleDay: true,
    );
    if (r == null) return;
    setState(() {
      if (r.days.isNotEmpty) a.day = r.days.first;
      a.start = r.start;
      a.end = r.end;
    });
  }

  Future<void> _delete(_Alarm a) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Desea eliminar esta alarma?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(false),
                    icon: const Icon(Icons.close, size: 20),
                    label: Text('Cancelar', style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(true),
                    icon: const Icon(Icons.delete_outline, size: 20),
                    label: Text('Eliminar', style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.white,
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (ok == true) setState(() => _alarms.remove(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wordupAppBar(context, 'Alarmas'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
            child: FilledButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateAlarmScreen()),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                minimumSize: const Size(312, 99),
              ),
              child: Text(
                'Crear Alarmas',
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
              itemCount: _alarms.length,
              separatorBuilder: (_, _) => const SizedBox(height: 20),
              itemBuilder: (_, i) => _alarmTile(_alarms[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alarmTile(_Alarm a) {
    const white = TextStyle(color: AppColors.white);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 157,
        maxWidth: 380,
      ),
      child: Card(
        color: a.enabled
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.6),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    dayNames[a.day],
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
                  ),
                  const Spacer(),
                  Switch(
                    value: a.enabled,
                    onChanged: (v) => setState(() => a.enabled = v),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                    onPressed: () => _edit(a),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                    onPressed: () => _delete(a),
                  ),
                ],
              ),
              Text(
                'Rango de horas:',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                '${a.start.format(context)} - ${a.end.format(context)}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
