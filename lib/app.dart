import 'dart:math';

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
  final _random = Random();
  late String _focusCue;

  final List<String> _focusCues = const [
    'One tiny commit beats one giant someday.',
    'Momentum compounds. Log the next win.',
    'Progress over perfection, every single day.',
    'Small streaks become big stories.',
    'Future you says: thanks for shipping today.',
  ];

  @override
  void initState() {
    super.initState();
    _focusCue = _focusCues[_random.nextInt(_focusCues.length)];
  }

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
      onSelect: _triggerQuickCommit,
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
      id: 'goto_protocols',
      icon: Icons.flag,
      title: 'Go to Protocols',
      shortcut: 'Ctrl+3',
      onSelect: () => _navigateTo(2),
    ),
    CommandItem(
      id: 'goto_insights',
      icon: Icons.insights,
      title: 'Go to Insights',
      shortcut: 'Ctrl+4',
      onSelect: () => _navigateTo(3),
    ),
    CommandItem(
      id: 'goto_assistant',
      icon: Icons.auto_awesome,
      title: 'Go to Assistant',
      shortcut: 'Ctrl+5',
      onSelect: () => _navigateTo(4),
    ),
    CommandItem(
      id: 'goto_settings',
      title: 'Go to Settings',
      icon: Icons.settings,
      shortcut: 'Ctrl+6',
      onSelect: () => _navigateTo(5),
    ),
    CommandItem(
      id: 'refresh_focus_cue',
      title: 'Refresh Focus Cue',
      subtitle: 'Generate a new motivation line',
      icon: Icons.auto_fix_high,
      shortcut: 'Ctrl+Shift+K',
      onSelect: _refreshFocusCue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final dbInitialized = ref.watch(databaseInitializedProvider);
    final selectedIndex = ref.watch(navigationIndexProvider);
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
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (index) {
                        _navigateTo(index);
                      },
                      items: _navItems,
                    ),
                    // Main content
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _buildScreen(selectedIndex),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ArvionColors.surface.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ArvionColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.bolt,
                              size: 14,
                              color: ArvionColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _navItems[selectedIndex].label,
                              style: const TextStyle(
                                color: ArvionColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              '•',
                              style: TextStyle(color: ArvionColors.textMuted),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _focusCue,
                              style: const TextStyle(
                                color: ArvionColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      // Ctrl+K for command palette
      if (event.logicalKey == LogicalKeyboardKey.keyK &&
          HardwareKeyboard.instance.isControlPressed) {
        if (HardwareKeyboard.instance.isShiftPressed) {
          _refreshFocusCue();
        } else {
          setState(() => _showCommandPalette = !_showCommandPalette);
        }
      }

      // Ctrl + number to jump to section quickly
      if (HardwareKeyboard.instance.isControlPressed) {
        const keys = [
          LogicalKeyboardKey.digit1,
          LogicalKeyboardKey.digit2,
          LogicalKeyboardKey.digit3,
          LogicalKeyboardKey.digit4,
          LogicalKeyboardKey.digit5,
          LogicalKeyboardKey.digit6,
        ];
        final keyIndex = keys.indexOf(event.logicalKey);
        if (keyIndex >= 0 && keyIndex < _navItems.length) {
          _navigateTo(keyIndex);
        }
      }

      // Ctrl + Enter for quick commit flow
      if (event.logicalKey == LogicalKeyboardKey.enter &&
          HardwareKeyboard.instance.isControlPressed) {
        _triggerQuickCommit();
      }

      // Escape to close command palette
      if (event.logicalKey == LogicalKeyboardKey.escape &&
          _showCommandPalette) {
        setState(() => _showCommandPalette = false);
      }
    }
  }

  void _navigateTo(int index) {
    ref.read(navigationIndexProvider.notifier).state = index;
  }

  void _triggerQuickCommit() {
    _navigateTo(0);
    _showToast('Switched to Dashboard — use Daily Summary for Quick Commit.');
  }

  void _refreshFocusCue() {
    if (_focusCues.length < 2) return;
    setState(() {
      String next = _focusCue;
      while (next == _focusCue) {
        next = _focusCues[_random.nextInt(_focusCues.length)];
      }
      _focusCue = next;
    });
  }

  void _showToast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1800),
      ),
    );
  }
}
