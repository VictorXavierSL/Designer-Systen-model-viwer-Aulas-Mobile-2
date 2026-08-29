import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Escala tipográfica extraída do frame "Typography" do Figma.
///
/// A fonte identificada no style guide é **Sora** (Google Font gratuita).
/// Usamos o pacote `google_fonts` para carregá-la sem precisar embutir os
/// arquivos .ttf manualmente — veja o README para a alternativa "offline"
/// (fonte local em `pubspec.yaml`).
///
/// Os tamanhos/pesos abaixo foram inferidos das telas de alta fidelidade
/// (título de produto, preço, corpo de texto, labels de botão etc.) e
/// nomeados de forma semântica para facilitar o uso nos componentes.
class AppTypography {
  const AppTypography._();

  static TextStyle _sora({
    required double fontSize,
    required FontWeight fontWeight,
    Color color = AppColors.dark,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.sora(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Título grande de tela (ex.: nome do produto no Detail).
  static TextStyle get headingLarge =>
      _sora(fontSize: 24, fontWeight: FontWeight.w700, height: 1.2);

  /// Título de seção (ex.: "Description", "Size").
  static TextStyle get headingMedium =>
      _sora(fontSize: 18, fontWeight: FontWeight.w700, height: 1.3);

  /// Título de card de produto (ex.: "Caffe Mocha").
  static TextStyle get titleSmall =>
      _sora(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3);

  /// Corpo de texto padrão (descrições, endereços).
  static TextStyle get bodyMedium => _sora(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  /// Corpo de texto pequeno (subtítulos de card, ex.: "Deep Foam").
  static TextStyle get bodySmall => _sora(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  /// Legenda/caption (avaliações, contadores).
  static TextStyle get caption => _sora(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  /// Preço em destaque (ex.: "$ 4.53").
  static TextStyle get price =>
      _sora(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary);

  /// Texto de botão primário/secundário.
  static TextStyle get buttonLarge =>
      _sora(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white);

  /// Texto de botão pequeno / chip.
  static TextStyle get buttonSmall =>
      _sora(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dark);

  /// Label de navegação inferior.
  static TextStyle get navLabel =>
      _sora(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary);
}
