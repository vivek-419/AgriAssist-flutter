import 'package:flutter/material.dart';
import 'navigation/app_navigation.dart';
import 'screens/auth/login_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AgriAssistApp());
}

/// Root Application Widget with authentication gate.
class AgriAssistApp extends StatelessWidget {
  final bool? isTestingAuthenticated;

  const AgriAssistApp({
    super.key,
    this.isTestingAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated =
        isTestingAuthenticated ?? AuthService.instance.isAuthenticated;

    return MaterialApp(
      title: 'AgriAssist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isAuthenticated ? const AppNavigation() : const LoginScreen(),
    );
  }
}

