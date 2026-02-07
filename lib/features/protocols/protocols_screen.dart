import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../providers/providers.dart';
import 'widgets/add_protocol_dialog.dart';
import 'widgets/protocol_card.dart';

class ProtocolsScreen extends ConsumerWidget {
  const ProtocolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final protocolsAsync = ref.watch(activeProtocolsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Protocols',
                      style: ArvionTypography.headlineMedium.copyWith(
                        color: ArvionColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Daily routines and habits',
                      style: ArvionTypography.bodyMedium.copyWith(
                        color: ArvionColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddProtocolDialog(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('New Protocol'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ArvionColors.primary,
                    foregroundColor: ArvionColors.background,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: protocolsAsync.when(
                data: (protocols) {
                  if (protocols.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            size: 64,
                            color: ArvionColors.textMuted.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No protocols yet',
                            style: ArvionTypography.titleMedium.copyWith(
                              color: ArvionColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create a daily or weekly routine to get started',
                            style: ArvionTypography.bodySmall.copyWith(
                              color: ArvionColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: protocols.length,
                    itemBuilder: (context, index) {
                      final protocol = protocols[index];
                      return ProtocolCard(
                        protocol: protocol,
                        onComplete: () {
                          ref
                              .read(protocolRepositoryProvider)
                              .complete(protocol.id);
                        },
                        onDelete: () {
                          ref
                              .read(protocolRepositoryProvider)
                              .delete(protocol.id);
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: ArvionColors.primary),
                ),
                error: (e, stack) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: ArvionColors.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
