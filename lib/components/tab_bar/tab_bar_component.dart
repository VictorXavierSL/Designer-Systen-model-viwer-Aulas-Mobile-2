import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_typography.dart';
import '../action_button/action_button_component.dart';
import '../action_button/action_button_factory.dart';
import 'tab_bar_viewmodel.dart';

export 'tab_bar_viewmodel.dart';

/// A UI Visual da barra de navegação/categorias.
///
/// Assim como o [ActionButtonComponent], este widget só sabe desenhar o
/// que o [TabBarViewModel] descreve. Para a variante [TabBarVariant.categoryChips]
/// ele reaproveita o próprio `ActionButtonComponent` (chip = botão ghost),
/// evitando duplicar estilo de "pill" em dois lugares.
class TabBarComponent extends StatelessWidget {
  final TabBarViewModel viewModel;

  const TabBarComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    switch (viewModel.variant) {
      case TabBarVariant.categoryChips:
        return _buildCategoryChips();
      case TabBarVariant.bottomNavigation:
        return _buildBottomNavigation();
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
          return ActionButtonComponent(
            viewModel: ActionButtonFactory.categoryChip(
              label: item.label,
              isSelected: isActive,
              onPressed: () => viewModel.onItemSelected?.call(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -4)),
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
    final color = isActive ? AppColors.primary : AppColors.grey;
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
              Container(width: 10, height: 5, decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ))
            else
              Text(item.label, style: AppTypography.navLabel),
          ],
        ),
      ),
    );
  }
}
