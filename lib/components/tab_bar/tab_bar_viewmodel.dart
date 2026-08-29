import 'package:flutter/material.dart';

/// Duas variantes de navegação existem no Figma:
///
/// - [categoryChips]  → abas horizontais de categoria no topo da Home
///                      ("All Coffee", "Machiato", "Latte", "Americano").
/// - [bottomNavigation] → barra inferior fixa (Home / Favorite / Cart /
///                      Notification) com indicador de item ativo.
enum TabBarVariant { categoryChips, bottomNavigation }

@immutable
class TabBarItemViewModel {
  final String label;
  final IconData? icon;

  const TabBarItemViewModel({required this.label, this.icon});
}

@immutable
class TabBarViewModel {
  final TabBarVariant variant;
  final List<TabBarItemViewModel> items;
  final int activeIndex;
  final ValueChanged<int>? onItemSelected;

  const TabBarViewModel({
    required this.variant,
    required this.items,
    this.activeIndex = 0,
    this.onItemSelected,
  });

  TabBarViewModel copyWith({
    TabBarVariant? variant,
    List<TabBarItemViewModel>? items,
    int? activeIndex,
    ValueChanged<int>? onItemSelected,
  }) {
    return TabBarViewModel(
      variant: variant ?? this.variant,
      items: items ?? this.items,
      activeIndex: activeIndex ?? this.activeIndex,
      onItemSelected: onItemSelected ?? this.onItemSelected,
    );
  }
}
