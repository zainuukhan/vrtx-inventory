import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'navigation/bottom_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VRTX Inventory',
        theme: AppTheme.lightTheme,
        home: const BottomNavigation(),
      ),
    );
  }
}
