import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/list_items/list_item_component.dart';
import '../components/list_items/list_item_factory.dart';

/// Catálogo do componente **Card & List Item**: card de produto (grid da
/// Home) e linha de carrinho (Order/Checkout), em diferentes estados.
class SampleListItemsScreen extends StatelessWidget {
  const SampleListItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCatalogScaffold(
      title: 'Card & List Item',
      description: 'Card de produto e linha de carrinho, em diferentes estados.',
      sections: ListItemFactory.showcaseCatalog(),
      itemBuilder: (context, viewModel) => ListItemComponent(viewModel: viewModel),
    );
  }
}
