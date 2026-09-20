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
              const Text(
                '¿Desea eliminar esta alarma?',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(false),
                    icon: const Icon(Icons.close, size: 16),
                    label: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 12),
                  DialogButton(
                    label: 'Eliminar',
                    icon: Icons.delete_outline,
                    color: AppColors.error,
                    onTap: () => Navigator.of(ctx).pop(true),
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
      appBar: wordupAppBar('Alarmas'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
            child: BigButton(
              label: 'Crear Alarmas',
              height: 80,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateAlarmScreen()),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _alarms.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _alarmTile(_alarms[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alarmTile(_Alarm a) {
    const white = TextStyle(color: AppColors.white);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                dayNames[a.day],
                style: white.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Switch(
                value: a.enabled,
                onChanged: (v) => setState(() => a.enabled = v),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.secondary,
                  size: 20,
                ),
                onPressed: () => _edit(a),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white54, size: 20),
                onPressed: () => _delete(a),
              ),
            ],
          ),
          Text('Rango de horas:', style: white.copyWith(fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            '${a.start.format(context)} - ${a.end.format(context)}',
            style: white.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
