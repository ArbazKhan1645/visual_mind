import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visualmind/app_theme.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/entities/search_result_entity/search_result_entity.dart';
import 'package:visualmind/providers/memory_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _ctrl;
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);
    final mode = ref.watch(searchModeProvider);

    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/home'),
                    icon: const Icon(Icons.arrow_back_rounded),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      focusNode: _focus,
                      onChanged: (v) =>
                          ref.read(searchQueryProvider.notifier).state = v,
                      style: const TextStyle(fontSize: 15),
                      decoration: const InputDecoration(
                        hintText: 'Search your memories...',
                        prefixIcon: Icon(Icons.search_rounded, size: 20),
                        suffixIcon: _ClearBtn(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Mode selector
            _SearchModeSelector(selected: mode),

            // Suggestions (if empty)
            if (query.trim().length < 2)
              _SearchSuggestions(
                onTap: (s) {
                  _ctrl.text = s;
                  ref.read(searchQueryProvider.notifier).state = s;
                },
              ),

            // Results
            if (query.trim().length >= 2)
              Expanded(
                child: results.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentLight,
                    ),
                  ),
                  error: (e, _) => Center(
                    child: Text(
                      'Error: $e',
                      style: const TextStyle(color: AppColors.error),
                    ),
                  ),
                  data: (list) => _SearchResults(results: list, query: query),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── CLEAR BUTTON ────────────────────────────────────────────────────────────

class _ClearBtn extends ConsumerWidget {
  const _ClearBtn();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final q = ref.watch(searchQueryProvider);
    if (q.isEmpty) return const SizedBox.shrink();
    return IconButton(
      icon: const Icon(Icons.close_rounded, size: 18),
      onPressed: () {
        ref.read(searchQueryProvider.notifier).state = '';
      },
    );
  }
}

// ─── MODE SELECTOR ───────────────────────────────────────────────────────────

class _SearchModeSelector extends ConsumerWidget {
  final String selected;
  const _SearchModeSelector({required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const modes = [
      ('hybrid', 'Smart', Icons.auto_awesome_rounded),
      ('text', 'Text', Icons.text_fields_rounded),
      ('semantic', 'Semantic', Icons.psychology_rounded),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: modes.map((m) {
          final (id, label, icon) = m;
          final isActive = selected == id;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => ref.read(searchModeProvider.notifier).state = id,
              child: AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.accent : AppColors.bg2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive ? AppColors.accent : AppColors.border,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 14,
                      color: isActive ? Colors.white : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── SUGGESTIONS ─────────────────────────────────────────────────────────────

class _SearchSuggestions extends StatelessWidget {
  final void Function(String) onTap;
  const _SearchSuggestions({required this.onTap});

  static const _suggestions = [
    ('receipt from last week', Icons.receipt_rounded),
    ('whiteboard from meeting', Icons.dashboard_rounded),
    ('phone number', Icons.phone_rounded),
    ('email address', Icons.email_rounded),
    ('book or document', Icons.menu_book_rounded),
    ('business card', Icons.badge_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Try searching for',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _suggestions.map((s) {
                final (label, icon) = s;
                return GestureDetector(
                  onTap: () => onTap(label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bg2,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border, width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── RESULTS LIST ────────────────────────────────────────────────────────────

class _SearchResults extends StatelessWidget {
  final List<SearchResultEntity> results;
  final String query;
  const _SearchResults({required this.results, required this.query});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No memories found for "$query"',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try different keywords or capture more memories',
              style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            '${results.length} result${results.length == 1 ? '' : 's'}',
            style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: results.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) =>
                SearchResultTile(result: results[i], query: query)
                    .animate(delay: Duration(milliseconds: i * 50))
                    .fadeIn(duration: 200.ms)
                    .slideX(begin: 0.05, duration: 200.ms),
          ),
        ),
      ],
    );
  }
}

class SearchResultTile extends StatelessWidget {
  final SearchResultEntity result;
  final String query;

  const SearchResultTile({
    super.key,
    required this.result,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.go('/memory/${result.memory.id}', extra: result.memory),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bg2,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.memory.title ?? _typeLabel(result.memory.type),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              result.snippet ?? 'Matched on ${result.matchType}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Chip(
                  label: Text(
                    result.matchType,
                    style: const TextStyle(fontSize: 10),
                  ),
                  backgroundColor: AppColors.bg3,
                ),
                const Spacer(),
                Text(
                  result.relevanceScore.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(MemoryType type) =>
      type.name[0].toUpperCase() + type.name.substring(1).replaceAll('_', ' ');
}
