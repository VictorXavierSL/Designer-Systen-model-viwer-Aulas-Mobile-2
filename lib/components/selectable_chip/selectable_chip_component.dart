import 'package:flutter/material.dart';

import '../../common/app_theme.dart';
import '../../common/app_typography.dart';
import 'selectable_chip_viewmodel.dart';

export 'selectable_chip_viewmodel.dart';

/// A UI Visual do item selecionável.
///
/// Assim como o `ActionButtonComponent`, é um `StatelessWidget` puro:
/// só desenha o que o [SelectableChipViewModel] descreve, lendo cor por
/// papel semântico via `context.colors`.
class SelectableChipComponent extends StatelessWidget {
  final SelectableChipViewModel viewModel;

  const SelectableChipComponent({super.key, required this.viewModel});

  double get _height => viewModel.size == SelectableChipSize.small ? 32 : 41;

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    final disabled = !viewModel.isEnabled;
    final selected = viewModel.isSelected;

    final Color background;
    final Color foreground;
    final Color? borderColor;

    switch (viewModel.shape) {
      case SelectableChipShape.pillOutline:
        background = selected ? tokens.secondary : tokens.surface;
        foreground = disabled
            ? tokens.textSecondary
            : (selected ? tokens.onSecondary : tokens.onSurface);
        borderColor = selected ? tokens.primary : tokens.border;
        break;
      case SelectableChipShape.text:
        background = selected ? tokens.primary : Colors.transparent;
        foreground = disabled
            ? tokens.textSecondary
            : (selected ? tokens.onPrimary : tokens.textSecondary);
        borderColor = null;
        break;
    }

    final textStyle = (viewModel.size == SelectableChipSize.small
            ? AppTypography.buttonSmall
            : AppTypography.buttonLarge.copyWith(fontSize: 14))
        .copyWith(color: foreground, fontWeight: selected ? FontWeight.w700 : FontWeight.w600);

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(_height / 2),
        child: InkWell(
          borderRadius: BorderRadius.circular(_height / 2),
          onTap: disabled ? null : viewModel.onSelected,
          child: Container(
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_height / 2),
              border: borderColor != null ? Border.all(color: borderColor, width: 1.2) : null,
            ),
            child: Text(viewModel.label, style: textStyle),
          ),
        ),
      ),
    );
  }
}
