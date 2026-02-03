import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../widgets/glass_card.dart';

/// Settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: ArvionTypography.headlineMedium.copyWith(
              color: ArvionColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize your Arvion experience',
            style: ArvionTypography.bodyMedium.copyWith(
              color: ArvionColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),

          // Appearance section
          _buildSection(
            title: 'Appearance',
            children: [
              _SettingTile(
                icon: Icons.palette_outlined,
                title: 'Theme',
                subtitle: 'Dark (OLED)',
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.color_lens_outlined,
                title: 'Accent Color',
                subtitle: 'Green',
                trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: ArvionColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.text_fields,
                title: 'Font Size',
                subtitle: 'Medium',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Heatmap section
          _buildSection(
            title: 'Heatmap',
            children: [
              _SettingTile(
                icon: Icons.grid_view,
                title: 'Weeks to Show',
                subtitle: '52 weeks',
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.animation,
                title: 'Compile Animation',
                subtitle: 'Enabled',
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: ArvionColors.primary,
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Goals section
          _buildSection(
            title: 'Daily Goals',
            children: [
              _SettingTile(
                icon: Icons.flag_outlined,
                title: 'Daily Commit Goal',
                subtitle: '5 commits',
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.notifications_outlined,
                title: 'Reminders',
                subtitle: 'Enabled',
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: ArvionColors.primary,
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Data section
          _buildSection(
            title: 'Data',
            children: [
              _SettingTile(
                icon: Icons.download_outlined,
                title: 'Export Data',
                subtitle: 'JSON format',
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.upload_outlined,
                title: 'Import Data',
                subtitle: 'From backup',
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.delete_outline,
                title: 'Clear All Data',
                subtitle: 'This cannot be undone',
                titleColor: ArvionColors.error,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // About section
          _buildSection(
            title: 'About',
            children: [
              _SettingTile(
                icon: Icons.info_outline,
                title: 'Version',
                subtitle: '1.0.0',
                onTap: () {},
              ),
              _SettingTile(
                icon: Icons.code,
                title: 'GitHub',
                subtitle: 'github.com/Anandb71/Arvion',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ArvionTypography.titleSmall.copyWith(
            color: ArvionColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  State<_SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<_SettingTile> {
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovered ? ArvionColors.surfaceLight : Colors.transparent,
            border: const Border(
              bottom: BorderSide(color: ArvionColors.border, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.titleColor ?? ArvionColors.textSecondary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: ArvionTypography.bodyMedium.copyWith(
                        color: widget.titleColor ?? ArvionColors.textPrimary,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: ArvionTypography.bodySmall.copyWith(
                        color: ArvionColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
