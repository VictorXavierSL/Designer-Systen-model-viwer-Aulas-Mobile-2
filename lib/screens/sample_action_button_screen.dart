import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/action_button/action_button_component.dart';
import '../components/action_button/action_button_factory.dart';

/// Tela só para testar o botão.
///
/// Tela-espelho de `ActionButtonComponent`: renderiza TODAS as variantes
/// declaradas em [ActionButtonFactory.showcaseCatalog], organizadas por
/// seção (Primary, Secondary, Outline Chip, Category Chip, Icon Button).
/// Use esta tela para validar visualmente qualquer alteração de token
/// (cor, tipografia) ou de nova variante adicionada na factory.
class SampleActionButtonScreen extends StatelessWidget {
  const SampleActionButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      title: 'Action Button',
      subtitle:
          'Todas as variantes/estados do componente Action Button, geradas por ActionButtonFactory.showcaseCatalog().',
      sections: ActionButtonFactory.showcaseCatalog(),
      itemBuilder: (context, viewModel) => ActionButtonComponent(viewModel: viewModel),
    );
  }
}
