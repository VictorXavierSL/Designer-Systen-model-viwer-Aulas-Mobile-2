import 'package:flutter/material.dart';

import '../../common/showcase_models.dart';
import 'tab_bar_viewmodel.dart';

/// O Criador de Variantes da barra de navegação.
class TabBarFactory {
  const TabBarFactory._();

  /// Abas de categoria da Home ("All Coffee", "Machiato", "Latte",
  /// "Americano" — nomes reais extraídos do Figma).
  static TabBarViewModel categoryTabs({
    List<String> labels = const ['All Coffee', 'Machiato', 'Latte', 'Americano'],
    int activeIndex = 0,
    ValueChanged<int>? onItemSelected,
  }) {
    return TabBarViewModel(
      variant: TabBarVariant.categoryChips,
      items: [for (final label in labels) TabBarItemViewModel(label: label)],
      activeIndex: activeIndex,
      onItemSelected: onItemSelected,
    );
  }

  /// Navegação inferior fixa (Home / Favorite / Bag / Notification).
  static TabBarViewModel bottomNav({
    int activeIndex = 0,
    ValueChanged<int>? onItemSelected,
  }) {
    return TabBarViewModel(
      variant: TabBarVariant.bottomNavigation,
      items: const [
        TabBarItemViewModel(label: 'Home', icon: Icons.home_rounded),
        TabBarItemViewModel(label: 'Favorite', icon: Icons.favorite_border_rounded),
        TabBarItemViewModel(label: 'Bag', icon: Icons.shopping_bag_outlined),
        TabBarItemViewModel(label: 'Notification', icon: Icons.notifications_none_rounded),
      ],
      activeIndex: activeIndex,
      onItemSelected: onItemSelected,
    );
  }

  /// Catálogo completo usado por `sample_tab_bar_screen`.
  static List<ShowcaseSection<TabBarViewModel>> showcaseCatalog() {
    return [
      ShowcaseSection(
        title: 'Category Chips',
        description: 'Abas de categoria no topo da Home, com item ativo variando.',
        items: [
          ShowcaseItem(caption: 'Ativo: All Coffee', viewModel: categoryTabs(activeIndex: 0)),
          ShowcaseItem(caption: 'Ativo: Latte', viewModel: categoryTabs(activeIndex: 2)),
        ],
      ),
      ShowcaseSection(
        title: 'Bottom Navigation',
        description: 'Barra fixa inferior com indicador do item ativo.',
        items: [
          ShowcaseItem(caption: 'Home ativo', viewModel: bottomNav(activeIndex: 0)),
          ShowcaseItem(caption: 'Favorite ativo', viewModel: bottomNav(activeIndex: 1)),
          ShowcaseItem(caption: 'Bag ativo', viewModel: bottomNav(activeIndex: 2)),
        ],
      ),
    ];
  }
}
