import 'package:flutter/material.dart';

import '../common/app_theme.dart';
import '../common/app_typography.dart';
import '../common/theme_toggle_button.dart';
import '../components/action_button/action_button_component.dart';
import '../components/action_button/action_button_factory.dart';
import '../components/list_items/list_item_component.dart';
import '../components/list_items/list_item_factory.dart';
import '../components/tab_bar/tab_bar_component.dart';
import '../components/tab_bar/tab_bar_factory.dart';

/// Composição de uso real — a Home montada inteiramente a partir dos
/// componentes catalogados (Button, Navigation, Card & List Item).
/// Nenhum estilo é definido aqui: tudo vem de `context.colors` e das
/// factories dos componentes. Existe para provar que o sistema de
/// design é usável em contexto real, além do catálogo isolado.
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
    final tokens = context.colors;
    final menu = ListItemFactory.demoMenu();

    return Scaffold(
      appBar: AppBar(
        title: Text('Composição de Uso', style: AppTypography.headingMedium.copyWith(color: tokens.onSurface)),
        actions: const [ThemeToggleButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const _HeroHeader(),
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
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: tokens.heroBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location', style: AppTypography.bodySmall.copyWith(color: tokens.onHero.withOpacity(0.7))),
          const SizedBox(height: 2),
          Row(
            children: [
              Text('Bilzen, Tanjungbalai', style: AppTypography.titleSmall.copyWith(color: tokens.onHero)),
              Icon(Icons.keyboard_arrow_down_rounded, color: tokens.onHero, size: 20),
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
                    color: tokens.onHero.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, color: tokens.onHero.withOpacity(0.6)),
                      const SizedBox(width: 8),
                      Text('Search coffee',
                          style: AppTypography.bodyMedium.copyWith(color: tokens.onHero.withOpacity(0.6))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ActionButtonComponent(
                viewModel: ActionButtonFactory.icon(
                  icon: Icons.tune_rounded,
                  emphasis: ActionButtonEmphasis.filled,
                  size: ActionButtonSize.large,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: tokens.primary, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: tokens.danger, borderRadius: BorderRadius.circular(6)),
                  child: Text('Promo', style: AppTypography.caption.copyWith(color: tokens.onPrimary)),
                ),
                const Spacer(),
                Text('Buy one get one FREE',
                    style: AppTypography.headingMedium.copyWith(color: tokens.onPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
