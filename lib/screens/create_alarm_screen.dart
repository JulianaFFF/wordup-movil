import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/alarm_card_dialog.dart';
import '../widgets/common.dart';

class _Block {
  _Block(this.day, this.startHour, this.endHour);

  final int day;
  final double startHour;
  final double endHour;
}

/// Calendario semanal (01:00 - 16:00) donde se ven los bloques de alarmas.
class CreateAlarmScreen extends StatefulWidget {
  const CreateAlarmScreen({super.key});

  @override
  State<CreateAlarmScreen> createState() => _CreateAlarmScreenState();
}

class _CreateAlarmScreenState extends State<CreateAlarmScreen> {
  static const _firstHour = 1;
  static const _lastHour = 16;
  static const _rowHeight = 36.0;
  static const _timeColWidth = 48.0;
  static const _headerHeight = 32.0;
  static const _days = ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'];

  final _blocks = [_Block(0, 9, 11), _Block(3, 10.5, 15), _Block(4, 15, 16)];

  Future<void> _addBlock() async {
    final r = await showAlarmCardDialog(
      context,
      confirmLabel: 'Crear',
      confirmIcon: Icons.check,
    );
    if (r == null) return;
    final s = r.start.hour + r.start.minute / 60;
    final e = r.end.hour + r.end.minute / 60;
    if (e <= s) return;
    setState(() {
      for (final d in r.days) {
        _blocks.add(_Block(d, s, e));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rows = _lastHour - _firstHour + 1;
    return Scaffold(
      appBar: wordupAppBar('Crear alarmas', back: true),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final colW = (c.maxWidth - _timeColWidth) / 7;
                      return SizedBox(
                        height: _headerHeight + rows * _rowHeight,
                        child: Stack(
                          children: [
                            _grid(colW, rows),
                            for (final b in _blocks) _blockWidget(b, colW),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 4, 60, 16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.highlight,
                  foregroundColor: AppColors.black,
                ),
                onPressed: _addBlock,
                child: const Text('Agregar Bloque'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _grid(double colW, int rows) {
    return Column(
      children: [
        Container(
          height: _headerHeight,
          color: AppColors.primary,
          child: Row(
            children: [
              const SizedBox(width: _timeColWidth),
              for (final d in _days)
                SizedBox(
                  width: colW,
                  child: Center(
                    child: Text(
                      d,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (var h = _firstHour; h <= _lastHour; h++)
          SizedBox(
            height: _rowHeight,
            child: Row(
              children: [
                Container(
                  width: _timeColWidth,
                  alignment: Alignment.center,
                  color: AppColors.primary,
                  child: Text(
                    '${h.toString().padLeft(2, '0')}:00',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                for (var d = 0; d < 7; d++)
                  Container(
                    width: colW,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Color(0x556366B3)),
                        bottom: BorderSide(color: Color(0x226366B3)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _blockWidget(_Block b, double colW) {
    final top = _headerHeight + (b.startHour - _firstHour) * _rowHeight;
    final height = ((b.endHour - b.startHour) * _rowHeight).clamp(20.0, 1000.0);
    return Positioned(
      left: _timeColWidth + b.day * colW + 2,
      width: colW - 4,
      top: top,
      height: height,
      child: GestureDetector(
        onTap: () => setState(() => _blocks.remove(b)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: const CircleAvatar(
            radius: 9,
            backgroundColor: AppColors.white,
            child: Icon(Icons.edit, size: 11, color: AppColors.highlight),
          ),
        ),
      ),
    );
  }
}
