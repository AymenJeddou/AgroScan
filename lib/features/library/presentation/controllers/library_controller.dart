import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/pest.dart';
import '../../domain/repositories/library_repository.dart';
import '../../../../core/providers.dart';

class LibraryState {
  final String searchQuery;
  final String ordreFilter;    // '' = tous, or Latin order: 'Lepidoptera', 'Hemiptera', etc.
  final String cultureFilter;  // '' = tous, or culture key: 'olivier', 'tomate', etc.
  final String milieuFilter;   // '' = tous, 'plein_champ', 'sous_serre'
  final String statutFilter;   // '' = tous, 'favorites', 'quarantaine', 'polyphage'
  final AsyncValue<List<Pest>> pests;

  const LibraryState({
    required this.searchQuery,
    required this.ordreFilter,
    required this.cultureFilter,
    required this.milieuFilter,
    required this.statutFilter,
    required this.pests,
  });

  LibraryState copyWith({
    String? searchQuery,
    String? ordreFilter,
    String? cultureFilter,
    String? milieuFilter,
    String? statutFilter,
    AsyncValue<List<Pest>>? pests,
  }) {
    return LibraryState(
      searchQuery: searchQuery ?? this.searchQuery,
      ordreFilter: ordreFilter ?? this.ordreFilter,
      cultureFilter: cultureFilter ?? this.cultureFilter,
      milieuFilter: milieuFilter ?? this.milieuFilter,
      statutFilter: statutFilter ?? this.statutFilter,
      pests: pests ?? this.pests,
    );
  }
}

class LibraryController extends StateNotifier<LibraryState> {
  final LibraryRepository _libraryRepository;

  LibraryController(this._libraryRepository)
      : super(const LibraryState(
          searchQuery: '',
          ordreFilter: '',
          cultureFilter: '',
          milieuFilter: '',
          statutFilter: '',
          pests: AsyncValue.loading(),
        )) {
    loadPests();
  }

  Future<void> loadPests() async {
    try {
      state = state.copyWith(pests: const AsyncValue.loading());
      final list = await _libraryRepository.getPests();
      state = state.copyWith(pests: AsyncValue.data(list));
    } catch (e, stack) {
      state = state.copyWith(pests: AsyncValue.error(e, stack));
    }
  }

  void setSearchQuery(String query) => state = state.copyWith(searchQuery: query);
  void setOrdreFilter(String v) => state = state.copyWith(ordreFilter: v);
  void setCultureFilter(String v) => state = state.copyWith(cultureFilter: v);
  void setMilieuFilter(String v) => state = state.copyWith(milieuFilter: v);
  void setStatutFilter(String v) => state = state.copyWith(statutFilter: v);

  List<Pest> getFilteredPests({Set<String> favoriteIds = const {}}) {
    return state.pests.maybeWhen(
      data: (list) {
        return list.where((pest) {
          // ── Search ──────────────────────────────────────────────────────
          final q = state.searchQuery.toLowerCase().trim();
          if (q.isNotEmpty) {
            final matches = pest.nameFr.toLowerCase().contains(q) ||
                pest.nameEn.toLowerCase().contains(q) ||
                pest.nameAr.toLowerCase().contains(q) ||
                pest.scientificName.toLowerCase().contains(q);
            if (!matches) return false;
          }

          // ── Ordre ────────────────────────────────────────────────────────
          if (state.ordreFilter.isNotEmpty) {
            if (pest.order != state.ordreFilter) return false;
          }

          // ── Culture ──────────────────────────────────────────────────────
          if (state.cultureFilter.isNotEmpty) {
            if (state.cultureFilter == 'polyphage') {
              if (!pest.isPolyphage) return false;
            } else {
              if (!pest.cultures.contains(state.cultureFilter)) return false;
            }
          }

          // ── Milieu ───────────────────────────────────────────────────────
          if (state.milieuFilter.isNotEmpty) {
            if (pest.milieu != state.milieuFilter) return false;
          }

          // ── Statut ───────────────────────────────────────────────────────
          if (state.statutFilter.isNotEmpty) {
            switch (state.statutFilter) {
              case 'favorites':
                if (!favoriteIds.contains(pest.id)) return false;
              case 'quarantaine':
                if (!pest.isQuarantaine) return false;
              case 'polyphage':
                if (!pest.isPolyphage) return false;
            }
          }

          return true;
        }).toList();
      },
      orElse: () => [],
    );
  }
}

final libraryControllerProvider =
    StateNotifierProvider<LibraryController, LibraryState>((ref) {
  final repo = ref.watch(libraryRepositoryProvider);
  return LibraryController(repo);
});
