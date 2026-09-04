import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_tokens.dart';
import 'theme_controller.dart';

/// Monta os `ThemeData` de claro/escuro a partir dos [AppColorTokens].
///
/// Este é o único lugar do template que conhece a API do `ThemeData` —
/// componentes e telas nunca constroem `ThemeData` diretamente, apenas
/// consomem `context.colors`.
class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light, AppColorTokens.light());

  static ThemeData dark() => _build(Brightness.dark, AppColorTokens.dark());

  static ThemeData _build(Brightness brightness, AppColorTokens tokens) {
    final base = brightness == Brightness.light ? ThemeData.light() : ThemeData.dark();
    final textTheme = GoogleFonts.soraTextTheme(base.textTheme).apply(
      bodyColor: tokens.onSurface,
      displayColor: tokens.onSurface,
    );

    return base.copyWith(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: tokens.background,
      canvasColor: tokens.background,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: tokens.primary,
        brightness: brightness,
      ).copyWith(
        primary: tokens.primary,
        onPrimary: tokens.onPrimary,
        surface: tokens.surface,
        onSurface: tokens.onSurface,
        error: tokens.danger,
      ),
      extensions: [tokens],
    );
  }
}

/// Atalhos ergonômicos para acessar tokens de cor e o controlador de
/// tema a partir de qualquer `BuildContext`, sem precisar de um
/// gerenciador de estado externo.
extension AppThemeContextX on BuildContext {
  AppColorTokens get colors => Theme.of(this).extension<AppColorTokens>()!;

  ThemeController get themeController => ThemeControllerScope.of(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
