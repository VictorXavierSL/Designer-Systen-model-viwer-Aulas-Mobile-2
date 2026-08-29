import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/app_typography.dart';
import '../components/action_button/action_button_component.dart';
import '../components/action_button/action_button_factory.dart';
import '../components/list_items/list_item_component.dart';
import '../components/list_items/list_item_factory.dart';
import '../components/tab_bar/tab_bar_component.dart';
import '../components/tab_bar/tab_bar_factory.dart';

/// Tela principal montada.
///
/// Esta é a "tela de verdade" — o espelho funcional da tela Home em alta
/// fidelidade do Figma, montada 100% a partir dos componentes
/// reutilizáveis (`ActionButtonComponent`, `TabBarComponent`,
/// `ListItemComponent`). Nenhum estilo é definido aqui: tudo vem de
/// `AppColors` / `AppTypography` e das factories dos componentes.
///
/// Ela existe para provar que o sistema de design é usável em um
/// contexto real, não só isolado nas telas de showcase.
class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  int _activeCategory = 0;
  int _activeNavItem = 0;

  @override
  Widget build(BuildContext context) {
    final menu = ListItemFactory.demoMenu();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _HeroHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TabBarComponent(
                      viewModel: TabBarFactory.categoryTabs(
                        activeIndex: _activeCategory,
                        onItemSelected: (index) => setState(() => _activeCategory = index),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [for (final item in menu) ListItemComponent(viewModel: item)],
                    ),
                  ),
                ],
              ),
            ),
            TabBarComponent(
              viewModel: TabBarFactory.bottomNav(
                activeIndex: _activeNavItem,
                onItemSelected: (index) => setState(() => _activeNavItem = index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location', style: AppTypography.bodySmall.copyWith(color: AppColors.grey)),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Bilzen, Tanjungbalai',
                style: AppTypography.titleSmall.copyWith(color: AppColors.white),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.white, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: AppColors.grey),
                      const SizedBox(width: 8),
                      Text('Search coffee',
                          style: AppTypography.bodyMedium.copyWith(color: AppColors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 52,
                height: 52,
                child: ActionButtonComponent(
                  viewModel: ActionButtonFactory.icon(
                    icon: Icons.tune_rounded,
                    isSelected: true,
                    size: ActionButtonSize.large,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Promo',
                      style: AppTypography.caption.copyWith(color: AppColors.white)),
                ),
                const Spacer(),
                Text(
                  'Buy one get one FREE',
                  style: AppTypography.headingMedium.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
