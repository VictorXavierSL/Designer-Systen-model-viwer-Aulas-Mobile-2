import 'package:flutter/material.dart';

import '../../common/showcase_models.dart';
import 'action_button_viewmodel.dart';

export 'action_button_viewmodel.dart';

/// O Criador de Variantes do botão de ação.
///
/// Centraliza toda combinação válida de variante × ênfase × tamanho ×
/// estado do design system. Telas nunca montam um [ActionButtonViewModel]
/// diretamente — sempre chamam um método desta factory.
class ActionButtonFactory {
  const ActionButtonFactory._();

  static ActionButtonViewModel primary({
    required String label,
    VoidCallback? onPressed,
    bool isEnabled = true,
    bool isLoading = false,
    bool expand = true,
    ActionButtonSize size = ActionButtonSize.large,
  }) {
    return ActionButtonViewModel(
      label: label,
      variant: ActionButtonVariant.primary,
      size: size,
      isEnabled: isEnabled,
      isLoading: isLoading,
      expand: expand,
      onPressed: onPressed,
    );
  }

  static ActionButtonViewModel secondary({
    required String label,
    VoidCallback? onPressed,
    bool isEnabled = true,
    ActionButtonSize size = ActionButtonSize.medium,
  }) {
    return ActionButtonViewModel(
      label: label,
      variant: ActionButtonVariant.secondary,
      size: size,
      isEnabled: isEnabled,
      onPressed: onPressed,
    );
  }

  /// Botão circular só com ícone. `emphasis: filled` é a variante usada
  /// pelo botão de **adicionar item** e pelo filtro ativo; `neutral` é
  /// usada por voltar/favoritar/ícones de apoio.
  static ActionButtonViewModel icon({
    required IconData icon,
    ActionButtonEmphasis emphasis = ActionButtonEmphasis.neutral,
    bool isEnabled = true,
    ActionButtonSize size = ActionButtonSize.medium,
    VoidCallback? onPressed,
  }) {
    return ActionButtonViewModel(
      icon: icon,
      variant: ActionButtonVariant.icon,
      emphasis: emphasis,
      size: size,
      isEnabled: isEnabled,
      onPressed: onPressed,
    );
  }

  /// Atalho para o botão de **adicionar item** (usado nos cards de
  /// produto e na linha de carrinho) — sempre `icon` + `filled`.
  static ActionButtonViewModel addItem({
    ActionButtonSize size = ActionButtonSize.small,
    bool isEnabled = true,
    VoidCallback? onPressed,
  }) {
    return icon(
      icon: Icons.add_rounded,
      emphasis: ActionButtonEmphasis.filled,
      size: size,
      isEnabled: isEnabled,
      onPressed: onPressed,
    );
  }

  /// Catálogo completo usado pela tela de catálogo de botões.
  /// Organizado como matriz **cor/ênfase × tamanho × estado**, incluindo
  /// explicitamente o botão de adicionar item.
  static List<ShowcaseSection<ActionButtonViewModel>> showcaseCatalog() {
    return [
      ShowcaseSection(
        title: 'Primary — por tamanho',
        description: 'Ação principal da tela (ex.: "Buy Now"). Cor de marca sólida.',
        items: [
          ShowcaseItem(caption: 'Small', viewModel: primary(label: 'Buy Now', size: ActionButtonSize.small, expand: false)),
          ShowcaseItem(caption: 'Medium', viewModel: primary(label: 'Buy Now', size: ActionButtonSize.medium, expand: false)),
          ShowcaseItem(caption: 'Large', viewModel: primary(label: 'Buy Now', size: ActionButtonSize.large, expand: false)),
        ],
      ),
      ShowcaseSection(
        title: 'Primary — por estado',
        items: [
          ShowcaseItem(caption: 'Enabled', viewModel: primary(label: 'Buy Now', expand: false)),
          ShowcaseItem(caption: 'Loading', viewModel: primary(label: 'Buy Now', isLoading: true, expand: false)),
          ShowcaseItem(caption: 'Disabled', viewModel: primary(label: 'Sold Out', isEnabled: false, expand: false)),
        ],
      ),
      ShowcaseSection(
        title: 'Secondary — por tamanho e estado',
        description: 'Ação alternativa de destaque (fundo neutro escuro).',
        items: [
          ShowcaseItem(caption: 'Small', viewModel: secondary(label: 'Track Order', size: ActionButtonSize.small)),
          ShowcaseItem(caption: 'Medium', viewModel: secondary(label: 'Track Order')),
          ShowcaseItem(caption: 'Disabled', viewModel: secondary(label: 'Track Order', isEnabled: false)),
        ],
      ),
      ShowcaseSection(
        title: 'Icon Button — Adicionar item',
        description: 'O botão "+" dos cards de produto e da linha de carrinho. É um Icon Button com ênfase preenchida.',
        items: [
          ShowcaseItem(caption: 'Small', viewModel: addItem(size: ActionButtonSize.small)),
          ShowcaseItem(caption: 'Medium', viewModel: addItem(size: ActionButtonSize.medium)),
          ShowcaseItem(caption: 'Large', viewModel: addItem(size: ActionButtonSize.large)),
          ShowcaseItem(caption: 'Disabled', viewModel: addItem(isEnabled: false)),
        ],
      ),
      ShowcaseSection(
        title: 'Icon Button — Neutro',
        description: 'Voltar, favoritar, filtro — fundo discreto.',
        items: [
          ShowcaseItem(caption: 'Small', viewModel: icon(icon: Icons.arrow_back_rounded, size: ActionButtonSize.small)),
          ShowcaseItem(caption: 'Medium', viewModel: icon(icon: Icons.favorite_border_rounded, size: ActionButtonSize.medium)),
          ShowcaseItem(caption: 'Large', viewModel: icon(icon: Icons.tune_rounded, size: ActionButtonSize.large)),
          ShowcaseItem(caption: 'Disabled', viewModel: icon(icon: Icons.favorite_border_rounded, isEnabled: false)),
        ],
      ),
      ShowcaseSection(
        title: 'Icon Button — Preenchido (outras ações)',
        description: 'Mesma ênfase do "adicionar item", aplicada a outras ações de destaque (ex.: filtro ativo).',
        items: [
          ShowcaseItem(caption: 'Filtro ativo', viewModel: icon(icon: Icons.tune_rounded, emphasis: ActionButtonEmphasis.filled, size: ActionButtonSize.large)),
          ShowcaseItem(caption: 'Favorito ativo', viewModel: icon(icon: Icons.favorite_rounded, emphasis: ActionButtonEmphasis.filled)),
        ],
      ),
    ];
  }
}
