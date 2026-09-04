import 'package:flutter/material.dart';

import '../../common/app_theme.dart';
import '../../common/app_typography.dart';
import 'action_button_viewmodel.dart';

export 'action_button_viewmodel.dart';

/// A UI Visual do botão de ação.
///
/// Não decide regras de negócio nem cria variantes — só pinta o que o
/// [ActionButtonViewModel] descreve, lendo cor por papel semântico via
/// `context.colors` (funciona automaticamente em claro e escuro).
class ActionButtonComponent extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButtonComponent({super.key, required this.viewModel});

  double _heightFor(ActionButtonSize size) {
    switch (size) {
      case ActionButtonSize.small:
        return 32;
      case ActionButtonSize.medium:
        return 44;
      case ActionButtonSize.large:
        return 56;
    }
  }

  double _iconSizeFor(ActionButtonSize size) {
    switch (size) {
      case ActionButtonSize.small:
        return 16;
      case ActionButtonSize.medium:
        return 20;
      case ActionButtonSize.large:
        return 24;
    }
  }

  EdgeInsets _paddingFor(ActionButtonSize size) {
    switch (size) {
      case ActionButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 14);
      case ActionButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20);
      case ActionButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24);
    }
  }

  ({Color background, Color foreground}) _paletteFor(BuildContext context) {
    final tokens = context.colors;
    final disabled = !viewModel.isEnabled;

    switch (viewModel.variant) {
      case ActionButtonVariant.primary:
        return (
          background: disabled ? tokens.border : tokens.primary,
          foreground: disabled ? tokens.textSecondary : tokens.onPrimary,
        );
      case ActionButtonVariant.secondary:
        return (
          background: disabled ? tokens.border : tokens.onSurface,
          foreground: disabled ? tokens.textSecondary : tokens.surface,
        );
      case ActionButtonVariant.icon:
        final filled = viewModel.emphasis == ActionButtonEmphasis.filled;
        return (
          background: disabled
              ? tokens.border
              : (filled ? tokens.primary : tokens.secondary),
          foreground: disabled
              ? tokens.textSecondary
              : (filled ? tokens.onPrimary : tokens.onSecondary),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = _paletteFor(context);
    final disabled = !viewModel.isEnabled || viewModel.isLoading;
    final height = _heightFor(viewModel.size);
    final iconSize = _iconSizeFor(viewModel.size);

    if (viewModel.variant == ActionButtonVariant.icon) {
      return SizedBox(
        width: height,
        height: height,
        child: Material(
          color: palette.background,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: disabled ? null : viewModel.onPressed,
            child: Center(
              child: viewModel.isLoading
                  ? SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: CircularProgressIndicator(strokeWidth: 2, color: palette.foreground),
                    )
                  : Icon(viewModel.icon, size: iconSize, color: palette.foreground),
            ),
          ),
        ),
      );
    }

    final content = viewModel.isLoading
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(strokeWidth: 2, color: palette.foreground),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (viewModel.icon != null) ...[
                Icon(viewModel.icon, size: iconSize, color: palette.foreground),
                if (viewModel.label != null) const SizedBox(width: 8),
              ],
              if (viewModel.label != null)
                Text(
                  viewModel.label!,
                  style: (viewModel.size == ActionButtonSize.small
                          ? AppTypography.buttonSmall
                          : AppTypography.buttonLarge)
                      .copyWith(color: palette.foreground),
                ),
            ],
          );

    return SizedBox(
      width: viewModel.expand ? double.infinity : null,
      height: height,
      child: Material(
        color: palette.background,
        borderRadius: BorderRadius.circular(height / 2),
        child: InkWell(
          borderRadius: BorderRadius.circular(height / 2),
          onTap: disabled ? null : viewModel.onPressed,
          child: Container(
            padding: _paddingFor(viewModel.size),
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}
