import 'package:flutter/material.dart';

import '../../common/showcase_models.dart';
import 'action_button_viewmodel.dart';

export 'action_button_viewmodel.dart';

/// O Criador de Variantes.
///
/// Centraliza TODA a lógica de "quais combinações de botão existem no
/// nosso design system" — inspirado diretamente nos botões reais das
/// telas do Figma (Home, Detail, Order, Onboarding). Telas de produto
/// nunca deveriam montar um [ActionButtonViewModel] "na unha"; elas
/// chamam um método desta factory.
class ActionButtonFactory {
  const ActionButtonFactory._();

  /// Botão sólido grande — ex.: "Buy Now" na tela Detail, "Get Started"
  /// no Onboarding.
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

  /// Botão sólido escuro — ações secundárias de destaque.
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

  /// Chip de seleção com contorno — ex.: seletor de tamanho "S / M / L"
  /// na tela Detail.
  static ActionButtonViewModel outlineChip({
    required String label,
    required bool isSelected,
    VoidCallback? onPressed,
  }) {
    return ActionButtonViewModel(
      label: label,
      variant: ActionButtonVariant.outline,
      size: ActionButtonSize.medium,
      isSelected: isSelected,
      onPressed: onPressed,
    );
  }

  /// Chip de categoria (texto) — ex.: "All Coffee / Machiato / Latte"
  /// no topo da Home.
  static ActionButtonViewModel categoryChip({
    required String label,
    required bool isSelected,
    VoidCallback? onPressed,
  }) {
    return ActionButtonViewModel(
      label: label,
      variant: ActionButtonVariant.ghost,
      size: ActionButtonSize.small,
      isSelected: isSelected,
      onPressed: onPressed,
    );
  }

  /// Botão circular só com ícone — voltar, favoritar, filtro, adicionar
  /// item, stepper de quantidade.
  static ActionButtonViewModel icon({
    required IconData icon,
    bool isSelected = false,
    bool isEnabled = true,
    ActionButtonSize size = ActionButtonSize.medium,
    VoidCallback? onPressed,
  }) {
    return ActionButtonViewModel(
      icon: icon,
      variant: ActionButtonVariant.icon,
      size: size,
      isSelected: isSelected,
      isEnabled: isEnabled,
      onPressed: onPressed,
    );
  }

  /// Catálogo completo usado pela tela-espelho `sample_action_button_screen`.
  /// Alterar/adicionar uma variante aqui atualiza a tela de showcase
  /// automaticamente — não é preciso tocar em nenhuma tela.
  static List<ShowcaseSection<ActionButtonViewModel>> showcaseCatalog() {
    return [
      ShowcaseSection(
        title: 'Primary',
        description: 'Ação principal da tela (ex.: "Buy Now").',
        items: [
          ShowcaseItem(caption: 'Large / Enabled', viewModel: primary(label: 'Buy Now')),
          ShowcaseItem(
            caption: 'Large / Loading',
            viewModel: primary(label: 'Buy Now', isLoading: true),
          ),
          ShowcaseItem(
            caption: 'Large / Disabled',
            viewModel: primary(label: 'Sold Out', isEnabled: false),
          ),
          ShowcaseItem(
            caption: 'Medium / Not expanded',
            viewModel: primary(
              label: 'Add to Cart',
              size: ActionButtonSize.medium,
              expand: false,
            ),
          ),
        ],
      ),
      ShowcaseSection(
        title: 'Secondary',
        description: 'Ação de destaque alternativa (fundo escuro).',
        items: [
          ShowcaseItem(caption: 'Medium / Enabled', viewModel: secondary(label: 'Track Order')),
          ShowcaseItem(
            caption: 'Medium / Disabled',
            viewModel: secondary(label: 'Track Order', isEnabled: false),
          ),
        ],
      ),
      ShowcaseSection(
        title: 'Outline Chip (seletor)',
        description: 'Usado no seletor de tamanho "S / M / L".',
        items: [
          ShowcaseItem(caption: 'Selecionado', viewModel: outlineChip(label: 'M', isSelected: true)),
          ShowcaseItem(
            caption: 'Não selecionado',
            viewModel: outlineChip(label: 'L', isSelected: false),
          ),
        ],
      ),
      ShowcaseSection(
        title: 'Category Chip (ghost)',
        description: 'Abas de categoria no topo da Home.',
        items: [
          ShowcaseItem(
            caption: 'Ativo',
            viewModel: categoryChip(label: 'All Coffee', isSelected: true),
          ),
          ShowcaseItem(
            caption: 'Inativo',
            viewModel: categoryChip(label: 'Machiato', isSelected: false),
          ),
        ],
      ),
      ShowcaseSection(
        title: 'Icon Button',
        description: 'Voltar, favoritar, filtro, adicionar item.',
        items: [
          ShowcaseItem(caption: 'Padrão', viewModel: icon(icon: Icons.arrow_back)),
          ShowcaseItem(
            caption: 'Selecionado (favoritado)',
            viewModel: icon(icon: Icons.favorite, isSelected: true),
          ),
          ShowcaseItem(
            caption: 'Pequeno',
            viewModel: icon(icon: Icons.add, size: ActionButtonSize.small),
          ),
          ShowcaseItem(
            caption: 'Desabilitado',
            viewModel: icon(icon: Icons.tune, isEnabled: false),
          ),
        ],
      ),
    ];
  }
}
