import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/action_button/action_button_component.dart';
import '../components/action_button/action_button_factory.dart';

/// Catálogo do componente **Button**.
///
/// Reúne todas as variações de cor/ênfase, tamanho e estado geradas por
/// [ActionButtonFactory.showcaseCatalog] — incluindo o Icon Button de
/// "adicionar item", que também é um botão e por isso está catalogado
/// junto dos demais.
class SampleActionButtonScreen extends StatelessWidget {
  const SampleActionButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCatalogScaffold(
      title: 'Button',
      description:
          'Variações de cor, tamanho e estado do componente de botão de ação.',
      sections: ActionButtonFactory.showcaseCatalog(),
      itemBuilder: (context, viewModel) => ActionButtonComponent(viewModel: viewModel),
    );
  }
}
