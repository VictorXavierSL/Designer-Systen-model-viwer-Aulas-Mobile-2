import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_typography.dart';
import 'action_button_viewmodel.dart';

export 'action_button_viewmodel.dart';

/// A UI Visual do botão.
///
/// Este widget NÃO decide regras de negócio nem cria variantes — ele só
/// sabe pintar exatamente o que o [ActionButtonViewModel] descreve.
/// Isso mantém o componente 100% reutilizável e fácil de testar / usar
/// em qualquer tela (inclusive nas telas-espelho de showcase).
class ActionButtonComponent extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButtonComponent({super.key, required this.viewModel});

  double get _height {
    switch (viewModel.size) {
      case ActionButtonSize.small:
        return 32;
      case ActionButtonSize.medium:
        return 44;
      case ActionButtonSize.large:
        return 56;
    }
  }

  double get _iconSize {
    switch (viewModel.size) {
      case ActionButtonSize.small:
        return 16;
      case ActionButtonSize.medium:
        return 20;
      case ActionButtonSize.large:
        return 24;
    }
  }

  EdgeInsets get _padding {
    switch (viewModel.size) {
      case ActionButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 14);
      case ActionButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20);
      case ActionButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24);
    }
  }

  ({Color background, Color foreground, Color? border}) _paletteFor(
    BuildContext context,
  ) {
    final bool disabled = !viewModel.isEnabled;

    switch (viewModel.variant) {
      case ActionButtonVariant.primary:
        return (
          background: disabled ? AppColors.grey : AppColors.primary,
          foreground: disabled ? AppColors.textSecondary : AppColors.white,
          border: null,
        );
      case ActionButtonVariant.secondary:
        return (
          background: disabled ? AppColors.grey : AppColors.dark,
          foreground: AppColors.white,
          border: null,
        );
      case ActionButtonVariant.outline:
        final bool selected = viewModel.isSelected;
        return (
          background: selected ? AppColors.secondary : AppColors.white,
          foreground: selected ? AppColors.primary : AppColors.dark,
          border: selected ? AppColors.primary : AppColors.grey,
        );
      case ActionButtonVariant.ghost:
        final bool selected = viewModel.isSelected;
        return (
          background: selected ? AppColors.primary : Colors.transparent,
          foreground: selected ? AppColors.white : AppColors.textSecondary,
          border: null,
        );
      case ActionButtonVariant.icon:
        final bool selected = viewModel.isSelected;
        return (
          background: selected ? AppColors.primary : AppColors.cream,
          foreground: selected ? AppColors.white : AppColors.dark,
          border: null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = _paletteFor(context);
    final bool disabled = !viewModel.isEnabled || viewModel.isLoading;

    if (viewModel.variant == ActionButtonVariant.icon) {
      final double side = _height;
      return SizedBox(
        width: side,
        height: side,
        child: Material(
          color: palette.background,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: disabled ? null : viewModel.onPressed,
            child: Center(
              child: viewModel.isLoading
                  ? SizedBox(
                      width: _iconSize,
                      height: _iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: palette.foreground,
                      ),
                    )
                  : Icon(viewModel.icon, size: _iconSize, color: palette.foreground),
            ),
          ),
        ),
      );
    }

    final content = viewModel.isLoading
        ? SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: palette.foreground,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (viewModel.icon != null) ...[
                Icon(viewModel.icon, size: _iconSize, color: palette.foreground),
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
      height: _height,
      child: Material(
        color: palette.background,
        borderRadius: BorderRadius.circular(_height / 2),
        child: InkWell(
          borderRadius: BorderRadius.circular(_height / 2),
          onTap: disabled ? null : viewModel.onPressed,
          child: Container(
            padding: _padding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_height / 2),
              border: palette.border != null
                  ? Border.all(color: palette.border!, width: 1.2)
                  : null,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
