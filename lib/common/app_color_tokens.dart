import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tokens semânticos de cor — o que os componentes de fato consomem.
///
/// Em vez de espalhar `AppColors.primary` / `AppColors.dark` pelos
/// componentes (o que impede um tema escuro real), cada componente lê
/// papéis semânticos (`primary`, `surface`, `onSurface`, `border`...)
/// através de `context.colors` (extensão em `app_theme.dart`). Isso é o
/// que torna o toggle claro/escuro funcionar de verdade em todo o
/// sistema de design, e não só na tela de cores.
///
/// [AppColorTokens.light] mapeia 1:1 para os valores do Color Guide do
/// Figma. [AppColorTokens.dark] é a extensão do template.
@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  /// Cor de marca — ações principais, preço, item ativo.
  final Color primary;

  /// Cor de conteúdo sobre [primary] (texto/ícone dentro de um botão sólido).
  final Color onPrimary;

  /// Fundo de superfícies selecionadas/destacadas (chip selecionado).
  final Color secondary;

  /// Cor de conteúdo sobre [secondary].
  final Color onSecondary;

  /// Fundo padrão da tela.
  final Color background;

  /// Fundo de cards e superfícies elevadas.
  final Color surface;

  /// Texto/ícone principal sobre [surface] / [background].
  final Color onSurface;

  /// Texto/ícone secundário (subtítulos, legendas).
  final Color textSecondary;

  /// Bordas e divisores neutros.
  final Color border;

  /// Fundo do painel "hero" escuro (cabeçalho da Home).
  final Color heroBackground;

  /// Texto/ícone sobre [heroBackground].
  final Color onHero;

  /// Estado de erro/aviso (ex.: item esgotado).
  final Color danger;

  /// Estado de sucesso/confirmação.
  final Color success;

  const AppColorTokens({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.textSecondary,
    required this.border,
    required this.heroBackground,
    required this.onHero,
    required this.danger,
    required this.success,
  });

  factory AppColorTokens.light() => const AppColorTokens(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.primary,
        background: AppColors.creamLight,
        surface: AppColors.white,
        onSurface: AppColors.darkLight,
        textSecondary: AppColors.textSecondaryLight,
        border: AppColors.greyLight,
        heroBackground: AppColors.darkLight,
        onHero: AppColors.white,
        danger: AppColors.dangerLight,
        success: AppColors.successLight,
      );

  factory AppColorTokens.dark() => const AppColorTokens(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondaryDark,
        onSecondary: AppColors.onSecondaryDark,
        background: AppColors.backgroundDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        textSecondary: AppColors.textSecondaryDark,
        border: AppColors.borderDark,
        heroBackground: AppColors.heroBackgroundDark,
        onHero: AppColors.textPrimaryDark,
        danger: AppColors.dangerDark,
        success: AppColors.successDark,
      );

  @override
  AppColorTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? surface,
    Color? onSurface,
    Color? textSecondary,
    Color? border,
    Color? heroBackground,
    Color? onHero,
    Color? danger,
    Color? success,
  }) {
    return AppColorTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      heroBackground: heroBackground ?? this.heroBackground,
      onHero: onHero ?? this.onHero,
      danger: danger ?? this.danger,
      success: success ?? this.success,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      heroBackground: Color.lerp(heroBackground, other.heroBackground, t)!,
      onHero: Color.lerp(onHero, other.onHero, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}
