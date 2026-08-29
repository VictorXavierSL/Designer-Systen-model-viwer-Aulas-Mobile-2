import 'package:flutter/material.dart';

import '../common/showcase_scaffold.dart';
import '../components/tab_bar/tab_bar_component.dart';
import '../components/tab_bar/tab_bar_factory.dart';

/// Tela-espelho de `TabBarComponent`: mostra as abas de categoria e a
/// navegação inferior em diferentes estados de item ativo.
class SampleTabBarScreen extends StatefulWidget {
  const SampleTabBarScreen({super.key});

  @override
  State<SampleTabBarScreen> createState() => _SampleTabBarScreenState();
}

class _SampleTabBarScreenState extends State<SampleTabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      title: 'Tab Bar',
      subtitle:
          'Abas de categoria e navegação inferior, geradas por TabBarFactory.showcaseCatalog().',
      sections: TabBarFactory.showcaseCatalog(),
      itemsAlignment: WrapAlignment.start,
      itemBuilder: (context, viewModel) => SizedBox(
        width: viewModel.variant.name == 'bottomNavigation' ? 320 : 260,
        child: TabBarComponent(viewModel: viewModel),
      ),
    );
  }
}
