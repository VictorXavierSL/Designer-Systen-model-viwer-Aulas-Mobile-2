import 'package:flutter/material.dart';

/// Variantes de **botão de ação** (dispara uma ação, não representa
/// seleção — para chips seletores, ver `components/selectable_chip`):
///
/// - [primary]   → botão sólido de cor de marca ("Buy Now", "Get Started")
/// - [secondary] → botão sólido de superfície escura (ação secundária)
/// - [icon]      → botão circular só com ícone (voltar, favoritar,
///                 filtrar, **adicionar item**, stepper de quantidade).
///                 Repare: o botão de "adicionar item" é um Icon Button
///                 com `emphasis: filled`, catalogado junto dos demais.
enum ActionButtonVariant { primary, secondary, icon }

/// Ênfase visual do botão — controla a intensidade da cor de fundo.
/// Principalmente relevante para [ActionButtonVariant.icon]:
/// [neutral] = fundo neutro discreto (voltar, favoritar inativo);
/// [filled]  = fundo de cor de marca (adicionar item, filtro ativo).
enum ActionButtonEmphasis { neutral, filled }

enum ActionButtonSize { small, medium, large }

/// Estado + dados completos de UMA instância de botão.
///
/// Objeto imutável de propósito único: o [ActionButtonComponent] apenas
/// o renderiza; o [ActionButtonFactory] sabe montar as combinações
/// válidas de cor × tamanho × estado.
@immutable
class ActionButtonViewModel {
  final String? label;
  final IconData? icon;
  final ActionButtonVariant variant;
  final ActionButtonEmphasis emphasis;
  final ActionButtonSize size;
  final bool isEnabled;
  final bool isLoading;
  final bool expand;
  final VoidCallback? onPressed;

  const ActionButtonViewModel({
    this.label,
    this.icon,
    this.variant = ActionButtonVariant.primary,
    this.emphasis = ActionButtonEmphasis.filled,
    this.size = ActionButtonSize.medium,
    this.isEnabled = true,
    this.isLoading = false,
    this.expand = false,
    this.onPressed,
  }) : assert(
          label != null || icon != null,
          'ActionButtonViewModel precisa de um label e/ou um icon.',
        );

  ActionButtonViewModel copyWith({
    String? label,
    IconData? icon,
    ActionButtonVariant? variant,
    ActionButtonEmphasis? emphasis,
    ActionButtonSize? size,
    bool? isEnabled,
    bool? isLoading,
    bool? expand,
    VoidCallback? onPressed,
  }) {
    return ActionButtonViewModel(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      variant: variant ?? this.variant,
      emphasis: emphasis ?? this.emphasis,
      size: size ?? this.size,
      isEnabled: isEnabled ?? this.isEnabled,
      isLoading: isLoading ?? this.isLoading,
      expand: expand ?? this.expand,
      onPressed: onPressed ?? this.onPressed,
    );
  }
}
