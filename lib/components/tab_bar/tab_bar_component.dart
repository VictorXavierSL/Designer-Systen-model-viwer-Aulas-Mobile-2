import 'package:flutter/material.dart';

import '../../common/app_theme.dart';
import '../../common/app_typography.dart';
import '../selectable_chip/selectable_chip_component.dart';
import '../selectable_chip/selectable_chip_factory.dart';
import 'tab_bar_viewmodel.dart';

export 'tab_bar_viewmodel.dart';

/// A UI Visual da navegação (abas de categoria / navegação inferior).
///
/// Para [TabBarVariant.categoryChips], compõe o `SelectableChipComponent`
/// (o item ali é uma SELEÇÃO, não uma ação) — evitando duplicar estilo
/// de chip em dois componentes diferentes.
class TabBarComponent extends StatelessWidget {
  final TabBarViewModel viewModel;

  const TabBarComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    switch (viewModel.variant) {
      case TabBarVariant.categoryChips:
        return _buildCategoryChips();
      case TabBarVariant.bottomNavigation:
        return _buildBottomNavigation(context);
    }
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = viewModel.items[index];
          final bool isActive = index == viewModel.activeIndex;
          return SelectableChipComponent(
            viewModel: SelectableChipFactory.categoryTab(
              label: item.label,
              isSelected: isActive,
              onSelected: () => viewModel.onItemSelected?.call(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final tokens = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.surface,
        boxShadow: [
          BoxShadow(color: tokens.onSurface.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < viewModel.items.length; i++)
                _NavItem(
                  item: viewModel.items[i],
                  isActive: i == viewModel.activeIndex,
                  onTap: () => viewModel.onItemSelected?.call(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final TabBarItemViewModel item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({required this.item, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    final color = isActive ? tokens.primary : tokens.border;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: color, size: 24),
            const SizedBox(height: 4),
            if (isActive)
              Container(
                width: 10,
                height: 5,
                decoration: BoxDecoration(color: tokens.primary, borderRadius: BorderRadius.circular(4)),
              )
            else
              Text(item.label, style: AppTypography.navLabel.copyWith(color: tokens.textSecondary)),
          ],
        ),
      ),
    );
  }
}
