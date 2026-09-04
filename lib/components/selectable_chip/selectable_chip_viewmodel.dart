import 'package:flutter/material.dart';

/// Formato visual do item selecionável:
///
/// - [pillOutline] → contorno que preenche quando selecionado (ex.:
///                    seletor de tamanho "S / M / L" na tela Detail).
/// - [text]         → só texto, sem contorno, muda de cor/peso quando
///                    selecionado (ex.: abas de categoria "All Coffee /
///                    Machiato / Latte" no topo da Home).
enum SelectableChipShape { pillOutline, text }

enum SelectableChipSize { small, medium }

/// Estado + dados de UM item selecionável.
///
/// Diferente do [ActionButtonViewModel] (que representa uma AÇÃO),
/// este ViewModel representa um item que pertence a um GRUPO de
/// seleção (única ou múltipla) — a semântica é "estou selecionado ou
/// não", não "fui clicado e algo aconteceu".
@immutable
class SelectableChipViewModel {
  final String label;
  final bool isSelected;
  final bool isEnabled;
  final SelectableChipShape shape;
  final SelectableChipSize size;
  final VoidCallback? onSelected;

  const SelectableChipViewModel({
    required this.label,
    this.isSelected = false,
    this.isEnabled = true,
    this.shape = SelectableChipShape.pillOutline,
    this.size = SelectableChipSize.medium,
    this.onSelected,
  });

  SelectableChipViewModel copyWith({
    String? label,
    bool? isSelected,
    bool? isEnabled,
    SelectableChipShape? shape,
    SelectableChipSize? size,
    VoidCallback? onSelected,
  }) {
    return SelectableChipViewModel(
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
      isEnabled: isEnabled ?? this.isEnabled,
      shape: shape ?? this.shape,
      size: size ?? this.size,
      onSelected: onSelected ?? this.onSelected,
    );
  }
}
