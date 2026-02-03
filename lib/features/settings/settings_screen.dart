import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../widgets/glass_card.dart';
import '../../providers/providers.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          // AI Configuration
          _buildSection(
            title: 'AI Configuration',
            children: [
               _SettingTile(
                icon: Icons.auto_awesome,
                title: 'AI Provider',
                subtitle: 'Google Gemini (Flash 1.5)',
                onTap: () {},
              ),
              _SecureInputSettingTile(
                icon: Icons.key_outlined,
                title: 'Gemini API Key',
                hintText: 'Enter your API Key',
                prefKey: 'gemini_api_key',
              ),
              _ModelSettingTile(
                icon: Icons.psychology,
                title: 'AI Model',
                prefKey: 'gemini_model',
              ),
              _SettingTile(
                icon: Icons.help_outline,
                title: 'Get API Key',
                subtitle: 'aistudio.google.com',
                onTap: () {}, // Could launch URL
              ),
            ],
          ),
          const SizedBox(height: 24),

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
                title: 'Export Backup',
                subtitle: 'JSON format (Full backup)',
                onTap: () async {
                  try {
                    final path = await ref.read(dataExportServiceProvider).exportToJson();
                    if (path != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exported to $path')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
              ),
              _SettingTile(
                icon: Icons.table_chart_outlined,
                title: 'Export History',
                subtitle: 'CSV format (Spreadsheet friendly)',
                onTap: () async {
                   try {
                    final path = await ref.read(dataExportServiceProvider).exportToCsv();
                    if (path != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exported to $path')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
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

class _InputSettingTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String defaultValue;
  final String prefKey;

  const _InputSettingTile({
    required this.icon,
    required this.title,
    required this.defaultValue,
    required this.prefKey,
  });

  @override
  State<_InputSettingTile> createState() => _InputSettingTileState();
}

class _InputSettingTileState extends State<_InputSettingTile> {
  late TextEditingController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultValue);
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _controller.text = prefs.getString(widget.prefKey) ?? widget.defaultValue;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveValue(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.prefKey, value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    return _SettingTile(
      icon: widget.icon,
      title: widget.title,
      subtitle: '', 
      trailing: SizedBox(
        width: 200,
        child: TextField(
          controller: _controller,
          onChanged: _saveValue,
          style: ArvionTypography.bodyMedium.copyWith(
            color: ArvionColors.textPrimary,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.defaultValue,
            hintStyle: ArvionTypography.bodyMedium.copyWith(
              color: ArvionColors.textMuted,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _ToggleSettingTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String prefKey;

  const _ToggleSettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.prefKey,
  });

  @override
  State<_ToggleSettingTile> createState() => _ToggleSettingTileState();
}

class _ToggleSettingTileState extends State<_ToggleSettingTile> {
  bool _value = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _value = prefs.getBool(widget.prefKey) ?? true;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.prefKey, value);
    setState(() => _value = value);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    return _SettingTile(
      icon: widget.icon,
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: Switch(
        value: _value,
        onChanged: _saveValue,
        activeColor: ArvionColors.primary,
      ),
      onTap: () => _saveValue(!_value),
    );
  }
}

class _SecureInputSettingTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String hintText;
  final String prefKey;

  const _SecureInputSettingTile({
    required this.icon,
    required this.title,
    required this.hintText,
    required this.prefKey,
  });

  @override
  State<_SecureInputSettingTile> createState() => _SecureInputSettingTileState();
}

class _SecureInputSettingTileState extends State<_SecureInputSettingTile> {
  late TextEditingController _controller;
  bool _isLoading = true;
  final _storage = const FlutterSecureStorage();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final value = await _storage.read(key: widget.prefKey);
    if (mounted) {
      setState(() {
        _controller.text = value ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveValue(String value) async {
    await _storage.write(key: widget.prefKey, value: value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    return _SettingTile(
      icon: widget.icon,
      title: widget.title,
      subtitle: '',
      trailing: SizedBox(
        width: 220,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: _saveValue,
                obscureText: !_isVisible,
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: ArvionTypography.bodyMedium.copyWith(
                    color: ArvionColors.textMuted,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _isVisible ? Icons.visibility_off : Icons.visibility,
                size: 18,
                color: ArvionColors.textMuted,
              ),
              onPressed: () => setState(() => _isVisible = !_isVisible),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModelSettingTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String prefKey;

  const _ModelSettingTile({
    required this.icon,
    required this.title,
    required this.prefKey,
  });

  @override
  State<_ModelSettingTile> createState() => _ModelSettingTileState();
}

class _ModelSettingTileState extends State<_ModelSettingTile> {
  String _selectedModel = 'gemini-1.5-flash';
  final TextEditingController _customController = TextEditingController();
  bool _isLoading = true;
  bool _isCustom = false;

  final Map<String, String> _models = {
    'gemini-1.5-flash': 'Gemini 1.5 Flash (Fast)',
    'gemini-1.5-pro': 'Gemini 1.5 Pro (Reasoning)',
    'gemini-2.0-flash-exp': 'Gemini 2.0 Flash (Exp)',
    'custom': 'Custom Model...',
  };

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      final saved = prefs.getString(widget.prefKey) ?? 'gemini-1.5-flash';
      setState(() {
        if (_models.containsKey(saved) && saved != 'custom') {
          _selectedModel = saved;
          _isCustom = false;
        } else {
          _selectedModel = 'custom';
          _isCustom = true;
          _customController.text = saved;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveValue(String? value) async {
    if (value == null) return;
    final prefs = await SharedPreferences.getInstance();

    if (value == 'custom') {
      setState(() {
        _selectedModel = 'custom';
        _isCustom = true;
      });
      // Don't save 'custom' yet, wait for text input
    } else {
       await prefs.setString(widget.prefKey, value);
       setState(() {
         _selectedModel = value;
         _isCustom = false;
       });
    }
  }
  
  Future<void> _saveCustomValue(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.prefKey, value);
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    return Column(
      children: [
        _SettingTile(
          icon: widget.icon,
          title: widget.title,
          subtitle: _isCustom ? 'Manual Entry' : '',
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedModel,
              icon: const Icon(Icons.arrow_drop_down, color: ArvionColors.textMuted),
              dropdownColor: ArvionColors.surface,
              style: ArvionTypography.bodyMedium.copyWith(color: ArvionColors.textPrimary),
              onChanged: _saveValue,
              items: _models.entries.map((e) {
                return DropdownMenuItem(
                  value: e.key,
                  child: Text(e.value),
                );
              }).toList(),
            ),
          ),
        ),
        if (_isCustom)
           Padding(
             padding: const EdgeInsets.only(left: 52, right: 16, bottom: 16),
             child: TextField(
                controller: _customController,
                onChanged: _saveCustomValue,
                style: ArvionTypography.bodyMedium.copyWith(color: ArvionColors.textPrimary),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'e.g. gemini-1.5-pro-latest',
                  hintStyle: ArvionTypography.bodyMedium.copyWith(color: ArvionColors.textMuted),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: ArvionColors.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
             ),
           ),
      ],
    );
  }
}
