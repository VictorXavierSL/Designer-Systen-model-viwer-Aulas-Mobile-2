import 'package:flutter/material.dart';

import '../../common/showcase_models.dart';
import 'selectable_chip_viewmodel.dart';

export 'selectable_chip_viewmodel.dart';

/// O Criador de Variantes do item selecionável.
class SelectableChipFactory {
  const SelectableChipFactory._();

  /// Chip usado no seletor de tamanho "S / M / L" (tela Detail).
  static SelectableChipViewModel sizeOption({
    required String label,
    required bool isSelected,
    bool isEnabled = true,
    VoidCallback? onSelected,
  }) {
    return SelectableChipViewModel(
      label: label,
      isSelected: isSelected,
      isEnabled: isEnabled,
      shape: SelectableChipShape.pillOutline,
      size: SelectableChipSize.medium,
      onSelected: onSelected,
    );
  }

  /// Chip usado nas abas de categoria da Home.
  static SelectableChipViewModel categoryTab({
    required String label,
    required bool isSelected,
    bool isEnabled = true,
    VoidCallback? onSelected,
  }) {
    return SelectableChipViewModel(
      label: label,
      isSelected: isSelected,
      isEnabled: isEnabled,
      shape: SelectableChipShape.text,
      size: SelectableChipSize.small,
      onSelected: onSelected,
    );
  }

  /// Catálogo completo usado pela tela de catálogo de itens selecionáveis.
  static List<ShowcaseSection<SelectableChipViewModel>> showcaseCatalog() {
    return [
      ShowcaseSection(
        title: 'Pill Outline — Seletor (ex.: tamanho)',
        description: 'Contorno que preenche quando selecionado. Usado no seletor "S / M / L".',
        items: [
          ShowcaseItem(caption: 'Selecionado', viewModel: sizeOption(label: 'M', isSelected: true)),
          ShowcaseItem(caption: 'Não selecionado', viewModel: sizeOption(label: 'L', isSelected: false)),
          ShowcaseItem(caption: 'Desabilitado', viewModel: sizeOption(label: 'S', isSelected: false, isEnabled: false)),
        ],
      ),
      ShowcaseSection(
        title: 'Text — Aba de categoria',
        description: 'Só texto, vira pill de cor de marca quando ativo. Usado nas categorias da Home.',
        items: [
          ShowcaseItem(caption: 'Ativo', viewModel: categoryTab(label: 'All Coffee', isSelected: true)),
          ShowcaseItem(caption: 'Inativo', viewModel: categoryTab(label: 'Machiato', isSelected: false)),
          ShowcaseItem(caption: 'Desabilitado', viewModel: categoryTab(label: 'Americano', isSelected: false, isEnabled: false)),
        ],
      ),
    ];
  }
}
