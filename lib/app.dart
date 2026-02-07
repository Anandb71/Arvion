import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/arvion_theme.dart';
import 'core/theme/colors.dart';
import 'providers/providers.dart';
import 'widgets/nav_rail.dart';
import 'widgets/command_palette.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/tasks/tasks_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/insights/insights_screen.dart';
import 'features/protocols/protocols_screen.dart';
import 'features/ai/ai_panel.dart';
import 'data/database/isar_database.dart';

/// Main Arvion application
class ArvionApp extends StatelessWidget {
  const ArvionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arvion',
      debugShowCheckedModeBanner: false,
      theme: ArvionTheme.darkTheme,
      home: const AppShell(),
    );
  }
}

/// Main application shell with navigation
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _showCommandPalette = false;

  final _navItems = const [
    NavItem(
      label: 'Dashboard',
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view,
    ),
    NavItem(
      label: 'Tasks',
      icon: Icons.task_alt_outlined,
      selectedIcon: Icons.task_alt,
    ),
    NavItem(
      label: 'Protocols',
      icon: Icons.flag_outlined,
      selectedIcon: Icons.flag,
    ),
    NavItem(
      label: 'Insights',
      icon: Icons.insights_outlined,
      selectedIcon: Icons.insights,
    ),
    NavItem(
      label: 'Assistant',
      icon: Icons.auto_awesome_outlined,
      selectedIcon: Icons.auto_awesome,
    ),
    NavItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  List<CommandItem> get _commands => [
    CommandItem(
      id: 'new_task',
      title: 'New Task',
      subtitle: 'Create a new task to track',
      icon: Icons.add_task,
      shortcut: 'Ctrl+N',
      onSelect: () => ref.read(navigationIndexProvider.notifier).state = 1,
    ),
    CommandItem(
      id: 'quick_commit',
      title: 'Quick Commit',
      subtitle: 'Log a quick commit',
      icon: Icons.commit,
      shortcut: 'Ctrl+Enter',
      onSelect: () {},
    ),
    CommandItem(
      id: 'ask_ai',
      title: 'Ask Assistant',
      subtitle: 'Get help or plan tasks',
      icon: Icons.auto_awesome,
      onSelect: () => ref.read(navigationIndexProvider.notifier).state = 4,
    ),
    CommandItem(
      id: 'goto_dashboard',
      title: 'Go to Dashboard',
      icon: Icons.grid_view,
      onSelect: () => ref.read(navigationIndexProvider.notifier).state = 0,
    ),
    CommandItem(
      id: 'goto_tasks',
      icon: Icons.task_alt,
      title: 'Go to Tasks',
      onSelect: () => ref.read(navigationIndexProvider.notifier).state = 1,
    ),
    CommandItem(
      id: 'goto_settings',
      title: 'Go to Settings',
      icon: Icons.settings,
      onSelect: () => ref.read(navigationIndexProvider.notifier).state = 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final dbInitialized = ref.watch(databaseInitializedProvider);
    // Ensure verification service is running
    ref.watch(verificationServiceProvider);
    // Ensure screen time tracking is running
    ref.watch(screenTimeServiceProvider);

    return dbInitialized.when(
      data: (_) => KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Scaffold(
          backgroundColor: ArvionColors.background,
          body: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 600, minHeight: 400),
            child: Stack(
              children: [
                Row(
                  children: [
                    // Navigation rail
                    NavRail(
                      selectedIndex: ref.watch(navigationIndexProvider),
                      onDestinationSelected: (index) {
                        ref.read(navigationIndexProvider.notifier).state =
                            index;
                      },
                      items: _navItems,
                    ),
                    // Main content
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _buildScreen(ref.watch(navigationIndexProvider)),
                      ),
                    ),
                  ],
                ),
                // Command palette overlay
                if (_showCommandPalette)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => setState(() => _showCommandPalette = false),
                      child: Container(
                        color: Colors.black54,
                        child: CommandPalette(
                          commands: _commands,
                          onClose: () =>
                              setState(() => _showCommandPalette = false),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      loading: () => _buildLoading(),
      error: (e, _) => Scaffold(
        backgroundColor: ArvionColors.background,
        body: Center(
          child: Text(
            'Error initializing: $e',
            style: const TextStyle(color: ArvionColors.error),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(
      backgroundColor: ArvionColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: ArvionColors.primary),
            SizedBox(height: 16),
            Text(
              'Loading Arvion...',
              style: TextStyle(color: ArvionColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const TasksScreen();
      case 2:
        return const ProtocolsScreen();
      case 3:
        return const InsightsScreen();
      case 4:
        return const AIPanel();
      case 5:
        return const SettingsScreen();
      default:
        return const DashboardScreen();
    }
  }

  Widget _buildPlaceholder(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: ArvionColors.textMuted),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: ArvionColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming soon',
            style: TextStyle(color: ArvionColors.textMuted),
          ),
        ],
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      // Ctrl+K for command palette
      if (event.logicalKey == LogicalKeyboardKey.keyK &&
          HardwareKeyboard.instance.isControlPressed) {
        setState(() => _showCommandPalette = !_showCommandPalette);
      }
      // Escape to close command palette
      if (event.logicalKey == LogicalKeyboardKey.escape &&
          _showCommandPalette) {
        setState(() => _showCommandPalette = false);
      }
    }
  }
}
