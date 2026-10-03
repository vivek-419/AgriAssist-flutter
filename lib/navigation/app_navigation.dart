import 'package:flutter/material.dart';
import '../screens/disease/disease_check_screen.dart';
import '../screens/expert/expert_chat_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/market/market_screen.dart';
import '../theme/app_theme.dart';

/// Root navigation shell containing the bottom navigation bar and IndexedStack.
///
/// Features:
/// - Material 3 NavigationBar matching Figma styling
/// - Preserves screen states via IndexedStack
/// - Initial destination: Home (index 0)
/// - Tab switching callback accessible to child screens
class AppNavigation extends StatefulWidget {
  final int initialIndex;

  const AppNavigation({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of top-level tab screens
    final List<Widget> screens = [
      HomeScreen(onNavigateToTab: _onTabSelected),
      const DiseaseCheckScreen(),
      const MarketScreen(),
      const ExpertChatScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          border: Border(
            top: BorderSide(
              color: AppTheme.borderLight,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabSelected,
          elevation: 0,
          backgroundColor: AppTheme.surfaceWhite,
          indicatorColor: AppTheme.mintContainer,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.eco_outlined),
              selectedIcon: Icon(Icons.eco, color: AppTheme.primaryGreen),
              label: 'Home',
              tooltip: 'Home Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.document_scanner_outlined),
              selectedIcon: Icon(Icons.document_scanner, color: AppTheme.primaryGreen),
              label: 'Disease Check',
              tooltip: 'Check Crop Health',
            ),
            NavigationDestination(
              icon: Icon(Icons.trending_up),
              selectedIcon: Icon(Icons.trending_up, color: AppTheme.primaryGreen),
              label: 'Market',
              tooltip: 'APMC Market Rates',
            ),
            NavigationDestination(
              icon: Icon(Icons.support_agent_outlined),
              selectedIcon: Icon(Icons.support_agent, color: AppTheme.primaryGreen),
              label: 'Expert',
              tooltip: 'Agronomist Consultation',
            ),
          ],
        ),
      ),
    );
  }
}
