import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../data/models/protocol.dart';
import '../../../providers/providers.dart';

class AddProtocolDialog extends ConsumerStatefulWidget {
  const AddProtocolDialog({super.key});

  @override
  ConsumerState<AddProtocolDialog> createState() => _AddProtocolDialogState();
}

class _AddProtocolDialogState extends ConsumerState<AddProtocolDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedColor = '#10B981'; // Primary Green
  ProtocolFrequency _frequency = ProtocolFrequency.daily;
  final List<int> _selectedDays = [0, 1, 2, 3, 4]; // Mon-Fri default
  
  final List<String> _colors = [
    '#10B981', // Green (Primary)
    '#3B82F6', // Blue
    '#F59E0B', // Amber
    '#EF4444', // Red
    '#8B5CF6', // Purple
    '#EC4899', // Pink
    '#06B6D4', // Cyan
    '#6366F1', // Indigo
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final protocol = Protocol(
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        colorHex: _selectedColor,
        frequency: _frequency,
        daysOfWeek: _frequency == ProtocolFrequency.daily 
            ? [0, 1, 2, 3, 4, 5, 6] 
            : _selectedDays,
      );

      final repo = ref.read(protocolRepositoryProvider);
      repo.save(protocol);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ArvionColors.cardBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Protocol',
                style: ArvionTypography.headlineMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              
              // Title
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: ArvionColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'e.g. Morning Meditation',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: ArvionColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Brief description of routine',
                ),
              ),
              const SizedBox(height: 16),
              
              // Frequency
              DropdownButtonFormField<ProtocolFrequency>(
                value: _frequency,
                dropdownColor: ArvionColors.cardBg,
                style: const TextStyle(color: ArvionColors.textPrimary),
                decoration: const InputDecoration(labelText: 'Frequency'),
                items: ProtocolFrequency.values.map((f) {
                  return DropdownMenuItem(
                    value: f,
                    child: Text(f.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _frequency = value);
                },
              ),
              
              if (_frequency == ProtocolFrequency.custom || _frequency == ProtocolFrequency.weekly) ...[
                const SizedBox(height: 16),
                const Text(
                  'Days of Week',
                  style: TextStyle(color: ArvionColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: List.generate(7, (index) {
                    final day = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index];
                    final isSelected = _selectedDays.contains(index);
                    return FilterChip(
                      label: Text(day),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDays.add(index);
                          } else {
                            _selectedDays.remove(index);
                          }
                        });
                      },
                      checkmarkColor: ArvionColors.background,
                      selectedColor: Color(int.parse(_selectedColor.replaceFirst('#', '0xFF'))),
                      backgroundColor: ArvionColors.surface,
                      labelStyle: TextStyle(
                        color: isSelected ? ArvionColors.background : ArvionColors.textPrimary,
                      ),
                    );
                  }),
                ),
              ],
              
              const SizedBox(height: 24),
              const Text(
                'Color',
                style: TextStyle(color: ArvionColors.textSecondary),
              ),
              const SizedBox(height: 12),
              
              // Color Picker
              Wrap(
                spacing: 12,
                children: _colors.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(int.parse(color.replaceFirst('#', '0xFF'))),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Create Protocol'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
