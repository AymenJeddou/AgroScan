import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/scan.dart';
import '../../domain/repositories/scan_repository.dart';
import '../../../../core/providers.dart';

// Stream provider to watch database scans live
final scanHistoryProvider = StreamProvider<List<Scan>>((ref) {
  final repository = ref.watch(scanRepositoryProvider);
  return repository.watchScans();
});

// Notifier to handle background sync actions loading states
class HistoryActionsNotifier extends StateNotifier<bool> {
  final ScanRepository _scanRepository;

  HistoryActionsNotifier(this._scanRepository) : super(false);

  Future<void> syncWithCloud() async {
    if (state) return;
    try {
      state = true;
      await _scanRepository.syncWithRemote();
    } catch (_) {
      // Keep going, errors are logged in repository
    } finally {
      state = false;
    }
  }

  Future<void> removeScan(String id) async {
    try {
      await _scanRepository.deleteScan(id);
    } catch (_) {
      // Log/handle delete error
    }
  }
}

// Provider for action triggers
final historyActionsProvider =
    StateNotifierProvider<HistoryActionsNotifier, bool>((ref) {
  final repo = ref.watch(scanRepositoryProvider);
  return HistoryActionsNotifier(repo);
});
