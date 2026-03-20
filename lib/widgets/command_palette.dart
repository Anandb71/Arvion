import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/colors.dart';
import '../core/theme/typography.dart';

/// Command palette item
class CommandItem {
  final String id;
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onSelect;
  final String? shortcut;

  const CommandItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onSelect,
    this.shortcut,
  });
}

/// Command palette (⌘K / Ctrl+K) for quick actions
class CommandPalette extends StatefulWidget {
  final List<CommandItem> commands;
  final VoidCallback onClose;

  const CommandPalette({
    super.key,
    required this.commands,
    required this.onClose,
  });

  @override
  State<CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<CommandPalette> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  int _selectedIndex = 0;
  List<CommandItem> _filteredCommands = [];

  @override
  void initState() {
    super.initState();
    _filteredCommands = widget.commands;
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCommands = widget.commands;
      } else {
        _filteredCommands = widget.commands
            .where(
              (c) =>
                  c.title.toLowerCase().contains(query.toLowerCase()) ||
                  (c.subtitle?.toLowerCase().contains(query.toLowerCase()) ??
                      false),
            )
            .toList();
      }
      _selectedIndex = 0;
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
          _filteredCommands.isNotEmpty) {
        setState(() {
          _selectedIndex = (_selectedIndex + 1) % _filteredCommands.length;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
          _filteredCommands.isNotEmpty) {
        setState(() {
          _selectedIndex =
              (_selectedIndex - 1 + _filteredCommands.length) %
              _filteredCommands.length;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_filteredCommands.isNotEmpty) {
          _filteredCommands[_selectedIndex].onSelect();
          widget.onClose();
        }
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        widget.onClose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 500,
            constraints: const BoxConstraints(maxHeight: 400),
            decoration: BoxDecoration(
              color: ArvionColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ArvionColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search input
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ArvionColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: ArvionColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          style: ArvionTypography.bodyMedium.copyWith(
                            color: ArvionColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search commands...',
                            hintStyle: ArvionTypography.bodyMedium.copyWith(
                              color: ArvionColors.textMuted,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                          tooltip: 'Clear search',
                          icon: const Icon(
                            Icons.close,
                            size: 16,
                            color: ArvionColors.textMuted,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ArvionColors.surfaceLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ESC',
                          style: ArvionTypography.monoXSmall.copyWith(
                            color: ArvionColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Command list
                if (_filteredCommands.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No commands found',
                      style: ArvionTypography.bodyMedium.copyWith(
                        color: ArvionColors.textMuted,
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _filteredCommands.length,
                      itemBuilder: (context, index) {
                        final command = _filteredCommands[index];
                        final isSelected = index == _selectedIndex;

                        return InkWell(
                          onTap: () {
                            command.onSelect();
                            widget.onClose();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            color: isSelected
                                ? ArvionColors.surfaceLight
                                : Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: ArvionColors.surfaceLighter,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    command.icon,
                                    size: 16,
                                    color: isSelected
                                        ? ArvionColors.primary
                                        : ArvionColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        command.title,
                                        style: ArvionTypography.bodyMedium
                                            .copyWith(
                                              color: ArvionColors.textPrimary,
                                            ),
                                      ),
                                      if (command.subtitle != null)
                                        Text(
                                          command.subtitle!,
                                          style: ArvionTypography.bodySmall
                                              .copyWith(
                                                color: ArvionColors.textMuted,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                                if (command.shortcut != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ArvionColors.surfaceLighter,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      command.shortcut!,
                                      style: ArvionTypography.monoXSmall
                                          .copyWith(
                                            color: ArvionColors.textMuted,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: ArvionColors.border)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${_filteredCommands.length} command${_filteredCommands.length == 1 ? '' : 's'}',
                        style: ArvionTypography.monoXSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '↑↓ navigate • Enter run',
                        style: ArvionTypography.monoXSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
