import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Botão de alternância claro/escuro, reutilizado em toda AppBar do
/// sistema de design — permite comparar qualquer página do catálogo em
/// ambos os temas sem perder o contexto de navegação.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.themeController;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => IconButton(
        tooltip: controller.isDark ? 'Mudar para tema claro' : 'Mudar para tema escuro',
        onPressed: controller.toggle,
        icon: Icon(controller.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
      ),
    );
  }
}
