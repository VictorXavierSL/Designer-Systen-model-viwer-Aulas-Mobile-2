import 'package:flutter/material.dart';

/// Controla o `ThemeMode` (claro/escuro) do sistema de design inteiro.
///
/// É um `ValueNotifier` simples exposto para toda a árvore via
/// [ThemeControllerScope], permitindo que QUALQUER tela (não só a
/// principal) tenha um botão de alternância de tema — essencial para
/// comparar as variações de cor dos componentes em ambos os temas sem
/// perder o contexto de navegação.
class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController([ThemeMode initial = ThemeMode.light]) : super(initial);

  bool get isDark => value == ThemeMode.dark;

  void toggle() {
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}

/// Disponibiliza o [ThemeController] para toda a árvore de widgets.
class ThemeControllerScope extends InheritedNotifier<ThemeController> {
  const ThemeControllerScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeControllerScope>();
    assert(scope != null, 'ThemeControllerScope não encontrado na árvore de widgets.');
    return scope!.notifier!;
  }
}
