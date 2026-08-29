import 'package:flutter/material.dart';

/// Variantes visuais do botão, mapeadas 1:1 com o que existe nas telas de
/// alta fidelidade do Figma:
///
/// - [primary]   → botão sólido laranja ("Buy Now", "Get Started")
/// - [secondary] → botão sólido escuro (ações secundárias de destaque)
/// - [outline]   → contorno, preenche quando selecionado (chip "Size: M")
/// - [ghost]     → texto puro, sem fundo (chip de categoria inativo)
/// - [icon]      → botão circular/quadrado só com ícone (voltar, favoritar,
///                 adicionar item, stepper de quantidade)
enum ActionButtonVariant { primary, secondary, outline, ghost, icon }

/// Tamanhos disponíveis. Os valores de altura/padding reais vivem no
/// [ActionButtonComponent] — o ViewModel só declara a intenção.
enum ActionButtonSize { small, medium, large }

/// Estado + dados completos de UMA instância de botão.
///
/// É um objeto imutável de propósito único: o [ActionButtonComponent]
/// apenas o "renderiza", e o [ActionButtonFactory] é quem sabe montar
/// as combinações válidas (regras de negócio/design ficam na factory,
/// não no componente visual).
@immutable
class ActionButtonViewModel {
  final String? label;
  final IconData? icon;
  final ActionButtonVariant variant;
  final ActionButtonSize size;
  final bool isSelected;
  final bool isEnabled;
  final bool isLoading;
  final bool expand;
  final VoidCallback? onPressed;

  const ActionButtonViewModel({
    this.label,
    this.icon,
    this.variant = ActionButtonVariant.primary,
    this.size = ActionButtonSize.medium,
    this.isSelected = false,
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
    ActionButtonSize? size,
    bool? isSelected,
    bool? isEnabled,
    bool? isLoading,
    bool? expand,
    VoidCallback? onPressed,
  }) {
    return ActionButtonViewModel(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      isSelected: isSelected ?? this.isSelected,
      isEnabled: isEnabled ?? this.isEnabled,
      isLoading: isLoading ?? this.isLoading,
      expand: expand ?? this.expand,
      onPressed: onPressed ?? this.onPressed,
    );
  }
}
