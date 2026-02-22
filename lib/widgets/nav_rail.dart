import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../core/theme/typography.dart';

/// Navigation item for the rail
class NavItem {
  final String label;
  final IconData icon;
  final IconData? selectedIcon;

  const NavItem({required this.label, required this.icon, this.selectedIcon});
}

/// Desktop navigation rail
class NavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavItem> items;
  final Widget? header;
  final Widget? footer;

  const NavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.items,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: const BoxDecoration(
        color: ArvionColors.surface,
        border: Border(right: BorderSide(color: ArvionColors.border, width: 1)),
      ),
      child: Column(
        children: [
          // Header / Logo
          if (header != null) header!,
          if (header == null)
            Container(
              height: 64,
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: ArvionColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: ArvionColors.background,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 8),
          // Nav items
          Expanded(
            child: Column(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = index == selectedIndex;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: _NavRailItem(
                    item: item,
                    isSelected: isSelected,
                    onTap: () => onDestinationSelected(index),
                  ),
                );
              }),
            ),
          ),
          // Footer
          if (footer != null)
            Padding(padding: const EdgeInsets.all(12), child: footer),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _NavRailItem extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavRailItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavRailItem> createState() => _NavRailItemState();
}

class _NavRailItemState extends State<_NavRailItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.item.label,
        preferBelow: false,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? ArvionColors.primary.withOpacity(0.15)
                  : _isHovered
                  ? ArvionColors.surfaceLight
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: widget.isSelected
                  ? Border.all(
                      color: ArvionColors.primary.withOpacity(0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Center(
              child: Icon(
                widget.isSelected
                    ? (widget.item.selectedIcon ?? widget.item.icon)
                    : widget.item.icon,
                size: 22,
                color: widget.isSelected
                    ? ArvionColors.primary
                    : _isHovered
                    ? ArvionColors.textPrimary
                    : ArvionColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Extended navigation rail with labels (for wider screens)
class ExtendedNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavItem> items;
  final Widget? header;
  final Widget? footer;

  const ExtendedNavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.items,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: ArvionColors.surface,
        border: Border(right: BorderSide(color: ArvionColors.border, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          if (header != null) header!,
          if (header == null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: ArvionColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: ArvionColors.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Arvion',
                    style: ArvionTypography.titleMedium.copyWith(
                      color: ArvionColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          // Nav items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = index == selectedIndex;

                return _ExtendedNavItem(
                  item: item,
                  isSelected: isSelected,
                  onTap: () => onDestinationSelected(index),
                );
              },
            ),
          ),
          // Footer
          if (footer != null)
            Padding(padding: const EdgeInsets.all(12), child: footer),
        ],
      ),
    );
  }
}

class _ExtendedNavItem extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _ExtendedNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ExtendedNavItem> createState() => _ExtendedNavItemState();
}

class _ExtendedNavItemState extends State<_ExtendedNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? ArvionColors.primary.withOpacity(0.15)
                : _isHovered
                ? ArvionColors.surfaceLight
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.isSelected
                    ? (widget.item.selectedIcon ?? widget.item.icon)
                    : widget.item.icon,
                size: 20,
                color: widget.isSelected
                    ? ArvionColors.primary
                    : ArvionColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.item.label,
                  style: ArvionTypography.bodyMedium.copyWith(
                    color: widget.isSelected
                        ? ArvionColors.textPrimary
                        : ArvionColors.textSecondary,
                    fontWeight: widget.isSelected
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
