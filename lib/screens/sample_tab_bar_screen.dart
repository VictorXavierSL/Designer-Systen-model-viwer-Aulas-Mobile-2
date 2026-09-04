import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/tab_bar/tab_bar_component.dart';
import '../components/tab_bar/tab_bar_factory.dart';

/// Catálogo do componente **Navigation** (abas de categoria compostas
/// com Selectable Item, e navegação inferior).
class SampleTabBarScreen extends StatelessWidget {
  const SampleTabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCatalogScaffold(
      title: 'Navigation',
      description:
          'Abas de categoria (compostas a partir do Selectable Item) e navegação inferior, com item ativo variando.',
      sections: TabBarFactory.showcaseCatalog(),
      itemBuilder: (context, viewModel) => SizedBox(
        width: viewModel.variant.name == 'bottomNavigation' ? 320 : 260,
        child: TabBarComponent(viewModel: viewModel),
      ),
    );
  }
}
