import 'package:flutter/material.dart';

import '../theme.dart';
import 'activities_screen.dart';
import 'alarms_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _keys = List.generate(3, (_) => GlobalKey<NavigatorState>());

  Widget _tab(int i, Widget root) => Navigator(
    key: _keys[i],
    onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => root),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final nav = _keys[_index].currentState!;
        if (nav.canPop()) nav.pop();
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: [
            _tab(0, HomeScreen(onStartActivity: _openActivities)),
            _tab(1, const AlarmsScreen()),
            _tab(2, const SettingsScreen()),
          ],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: AppColors.primary,
            indicatorColor: AppColors.secondary,
            labelTextStyle: WidgetStateProperty.all(
              Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
              ),
            ),
            iconTheme: WidgetStateProperty.all(
              const IconThemeData(color: AppColors.white),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) {
              if (i == 2) return;
              if (i == _index) {
                _keys[i].currentState!.popUntil((r) => r.isFirst);
              }
              setState(() => _index = i);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(icon: Icon(Icons.alarm), label: 'Alarmas'),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                label: 'Ajustes',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openActivities() {
    _keys[0].currentState!.push(
      MaterialPageRoute(builder: (_) => const ActivitiesScreen()),
    );
  }
}
