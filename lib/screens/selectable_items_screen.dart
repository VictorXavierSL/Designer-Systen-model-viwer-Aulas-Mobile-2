import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/selectable_chip/selectable_chip_component.dart';
import '../components/selectable_chip/selectable_chip_factory.dart';

/// Catálogo do componente **Selectable Item**.
///
/// Itens que representam um estado de SELEÇÃO (pertencem a um grupo:
/// seletor de tamanho, abas de categoria) — semanticamente distintos de
/// um botão de ação, por isso vivem em seu próprio componente e catálogo.
class SelectableItemsScreen extends StatelessWidget {
  const SelectableItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCatalogScaffold(
      title: 'Selectable Item',
      description:
          'Itens de seleção (não disparam ação — representam um estado escolhido dentro de um grupo).',
      sections: SelectableChipFactory.showcaseCatalog(),
      itemBuilder: (context, viewModel) => SelectableChipComponent(viewModel: viewModel),
    );
  }
}
