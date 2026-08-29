import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/list_items/list_item_component.dart';
import '../components/list_items/list_item_factory.dart';

/// Tela-espelho de `ListItemComponent`: cards de produto (grid da Home)
/// e linhas de carrinho (Order/Checkout) em diferentes estados.
class SampleListItemsScreen extends StatelessWidget {
  const SampleListItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      title: 'List Items',
      subtitle:
          'Cards de produto e linhas de carrinho, gerados por ListItemFactory.showcaseCatalog().',
      sections: ListItemFactory.showcaseCatalog(),
      itemBuilder: (context, viewModel) => ListItemComponent(viewModel: viewModel),
    );
  }
}
