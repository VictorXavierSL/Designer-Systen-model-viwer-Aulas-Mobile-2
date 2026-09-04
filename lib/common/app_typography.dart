import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Escala tipográfica extraída do frame "Typography" do Figma.
///
/// A fonte identificada no style guide é **Sora** (Google Font gratuita).
///
/// IMPORTANTE: nenhum estilo aqui define `color`. Cor é um token de tema
/// (claro/escuro) e não de tipografia — os componentes aplicam a cor
/// correta via `.copyWith(color: context.colors.onSurface)` (ou o papel
/// semântico equivalente). Isso é o que permite a mesma escala
/// tipográfica funcionar em ambos os temas sem duplicação.
class AppTypography {
  const AppTypography._();

  static TextStyle _sora({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.sora(
      fontSize: fontSize,
      fontWeight: fontWeight,
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
  static TextStyle get bodyMedium =>
      _sora(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);

  /// Corpo de texto pequeno (subtítulos de card, ex.: "Deep Foam").
  static TextStyle get bodySmall =>
      _sora(fontSize: 13, fontWeight: FontWeight.w400, height: 1.4);

  /// Legenda/caption (avaliações, contadores, rótulos de exemplo).
  static TextStyle get caption =>
      _sora(fontSize: 12, fontWeight: FontWeight.w500, height: 1.3);

  /// Rótulo pequeno em maiúsculas, usado como cabeçalho de seção do
  /// catálogo (ex.: "COLOR / PRIMARY").
  static TextStyle get overline => _sora(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.8,
      );

  /// Preço em destaque (ex.: "$ 4.53").
  static TextStyle get price => _sora(fontSize: 18, fontWeight: FontWeight.w700);

  /// Texto de botão grande.
  static TextStyle get buttonLarge => _sora(fontSize: 16, fontWeight: FontWeight.w600);

  /// Texto de botão pequeno / chip.
  static TextStyle get buttonSmall => _sora(fontSize: 13, fontWeight: FontWeight.w600);

  /// Label de navegação inferior.
  static TextStyle get navLabel => _sora(fontSize: 11, fontWeight: FontWeight.w500);
}
