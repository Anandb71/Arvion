import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../widgets/glass_card.dart';
import '../../providers/providers.dart';
import '../../services/startup_service.dart';
import '../../data/database/isar_database.dart';

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

          // System section
          _buildSection(
            title: 'System',
            children: [const _StartupToggleTile()],
          ),
          const SizedBox(height: 24),

          // AI Configuration
          _buildSection(
            title: 'AI Configuration',
            children: [
              _SettingTile(
                icon: Icons.auto_awesome,
                title: 'AI Provider',
                subtitle: 'Google Gemini',
                onTap: () => _showInfoSnackbar(
                  context,
                  'Currently only Google Gemini is supported',
                ),
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
                onTap: () => _launchUrl('https://aistudio.google.com/apikey'),
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
                    final path = await ref
                        .read(dataExportServiceProvider)
                        .exportToJson();
                    if (path != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exported to $path')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
                    final path = await ref
                        .read(dataExportServiceProvider)
                        .exportToCsv();
                    if (path != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exported to $path')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
              ),
              _SettingTile(
                icon: Icons.delete_outline,
                title: 'Clear All Data',
                subtitle: 'This cannot be undone',
                titleColor: ArvionColors.error,
                onTap: () => _showClearDataDialog(context, ref),
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
                onTap: () => _showInfoSnackbar(context, 'Arvion v1.0.0'),
              ),
              _SettingTile(
                icon: Icons.code,
                title: 'GitHub',
                subtitle: 'github.com/Anandb71/Arvion',
                onTap: () => _launchUrl('https://github.com/Anandb71/Arvion'),
              ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  static void _showInfoSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ArvionColors.surface,
        title: const Text(
          'Clear All Data?',
          style: TextStyle(color: ArvionColors.textPrimary),
        ),
        content: const Text(
          'This will delete ALL tasks, commits, protocols, and screen time data. This action cannot be undone!',
          style: TextStyle(color: ArvionColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await IsarDatabase.clearAll();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data cleared')),
                );
              }
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: ArvionColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              style: ArvionTypography.labelLarge.copyWith(
                color: ArvionColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle = '',
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: ArvionColors.textMuted),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: ArvionTypography.bodyMedium.copyWith(
                      color: titleColor ?? ArvionColors.textPrimary,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: ArvionTypography.bodySmall.copyWith(
                        color: ArvionColors.textMuted,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

/// Secure input tile for sensitive data like API keys
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
  State<_SecureInputSettingTile> createState() =>
      _SecureInputSettingTileState();
}

class _SecureInputSettingTileState extends State<_SecureInputSettingTile> {
  final _controller = TextEditingController();
  final _storage = const FlutterSecureStorage();
  bool _isSet = false;
  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final value = await _storage.read(key: widget.prefKey);
    if (mounted) {
      setState(() {
        _isSet = value != null && value.isNotEmpty;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveValue(String value) async {
    await _storage.write(key: widget.prefKey, value: value);
    setState(() {
      _isSet = value.isNotEmpty;
      _isEditing = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('API Key saved')));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink();

    if (_isEditing) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(widget.icon, size: 20, color: ArvionColors.textMuted),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _controller,
                obscureText: true,
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.check, color: ArvionColors.primary),
              onPressed: () => _saveValue(_controller.text),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: ArvionColors.textMuted),
              onPressed: () => setState(() => _isEditing = false),
            ),
          ],
        ),
      );
    }

    return _SettingTile(
      icon: widget.icon,
      title: widget.title,
      subtitle: _isSet ? '••••••••••••' : 'Not set',
      trailing: Icon(Icons.edit, size: 18, color: ArvionColors.textMuted),
      onTap: () => setState(() => _isEditing = true),
    );
  }
}

/// Model selection dropdown tile
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
  final _models = {
    'gemini-2.5-flash': 'Gemini 2.5 Flash (Fastest)',
    'gemini-2.0-flash': 'Gemini 2.0 Flash',
    'gemini-1.5-flash': 'Gemini 1.5 Flash',
    'gemini-1.5-pro': 'Gemini 1.5 Pro (Best)',
    '__custom__': 'Custom Model...',
  };

  String _selectedModel = 'gemini-2.5-flash';
  bool _isCustom = false;
  bool _isLoading = true;
  final _customController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(widget.prefKey);
    if (mounted) {
      setState(() {
        if (saved != null && _models.containsKey(saved)) {
          _selectedModel = saved;
          _isCustom = false;
        } else if (saved != null && saved.isNotEmpty) {
          _selectedModel = '__custom__';
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
    if (value == '__custom__') {
      setState(() {
        _selectedModel = value;
        _isCustom = true;
      });
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
          subtitle: _isCustom ? 'Custom' : '',
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedModel,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: ArvionColors.textMuted,
              ),
              dropdownColor: ArvionColors.surface,
              style: ArvionTypography.bodyMedium.copyWith(
                color: ArvionColors.textPrimary,
              ),
              onChanged: _saveValue,
              items: _models.entries.map((e) {
                return DropdownMenuItem(value: e.key, child: Text(e.value));
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
              style: ArvionTypography.bodyMedium.copyWith(
                color: ArvionColors.textPrimary,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'e.g. gemini-1.5-pro-latest',
                hintStyle: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textMuted,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: ArvionColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Startup toggle tile with async state management
class _StartupToggleTile extends StatefulWidget {
  const _StartupToggleTile();

  @override
  State<_StartupToggleTile> createState() => _StartupToggleTileState();
}

class _StartupToggleTileState extends State<_StartupToggleTile> {
  bool _isEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final enabled = await StartupService.isStartupEnabled();
    if (mounted)
      setState(() {
        _isEnabled = enabled;
        _isLoading = false;
      });
  }

  Future<void> _toggleStartup(bool value) async {
    setState(() => _isLoading = true);
    final success = await StartupService.setStartupEnabled(value);
    if (success && mounted) {
      setState(() {
        _isEnabled = value;
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update startup setting')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SettingTile(
      icon: Icons.power_settings_new,
      title: 'Start on Startup',
      subtitle: _isEnabled ? 'Enabled' : 'Disabled',
      trailing: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Switch(
              value: _isEnabled,
              onChanged: _toggleStartup,
              activeColor: ArvionColors.primary,
            ),
      onTap: () {},
    );
  }
}
