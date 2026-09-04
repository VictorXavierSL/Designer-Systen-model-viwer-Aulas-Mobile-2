import 'package:flutter/material.dart';

/// Paleta bruta de cores — a única fonte de verdade dos valores hexadecimais.
///
/// A seção **Light** vem diretamente do frame "Color Guide" do arquivo
/// Figma "JavaGem - Coffee Shop Mobile App Design" (Community): cada
/// constante corresponde a um swatch numerado (01 a 05).
///
/// A seção **Dark** é uma EXTENSÃO deste template — o arquivo Figma
/// original só define um tema claro. Os valores abaixo foram derivados
/// a partir da paleta clara seguindo boas práticas de contraste (WCAG)
/// para um tema escuro coerente com a identidade visual da marca.
///
/// Este arquivo não deve ser referenciado diretamente pelos componentes.
/// Os componentes leem cores semânticas via `context.colors` (ver
/// `app_color_tokens.dart`), que mapeia estes valores brutos para papéis
/// (background, surface, texto, borda etc.) de acordo com o tema ativo.
class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------------
  // Light — extraído do Color Guide do Figma
  // ---------------------------------------------------------------------

  /// 01 — Laranja/Marrom.
  static const Color primary = Color(0xFFC67C4E);

  /// 02 — Creme rosado.
  static const Color secondaryLight = Color(0xFFEDD6C8);

  /// 03 — Quase preto.
  static const Color darkLight = Color(0xFF313131);

  /// 04 — Cinza claro.
  static const Color greyLight = Color(0xFFE3E3E3);

  /// 05 — Creme.
  static const Color creamLight = Color(0xFFF9F2ED);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textSecondaryLight = Color(0xFF8B8B8B);
  static const Color dangerLight = Color(0xFFE05C4E);
  static const Color successLight = Color(0xFF3E9B5B);

  // ---------------------------------------------------------------------
  // Dark — extensão do template (não vem do Figma)
  // ---------------------------------------------------------------------

  static const Color backgroundDark = Color(0xFF1B1512);
  static const Color surfaceDark = Color(0xFF241C18);
  static const Color borderDark = Color(0xFF3A2F29);
  static const Color secondaryDark = Color(0xFF4A372E);
  static const Color onSecondaryDark = Color(0xFFEFC9A8);
  static const Color textPrimaryDark = Color(0xFFF5EDE8);
  static const Color textSecondaryDark = Color(0xFFB4A79E);
  static const Color heroBackgroundDark = Color(0xFF120D0B);
  static const Color dangerDark = Color(0xFFE9897C);
  static const Color successDark = Color(0xFF6FC08A);
}
