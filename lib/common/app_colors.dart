import 'package:flutter/material.dart';

/// Design tokens extraídos diretamente do frame "Color Guide" do arquivo
/// Figma "JavaGem - Coffee Shop Mobile App Design" (Community).
///
/// Cada token abaixo corresponde a um swatch numerado (01 a 05) na página
/// "Assets, Style Guide & Image" > "Color" do arquivo original. Se você
/// atualizar o design no Figma, atualize os valores aqui — este arquivo é
/// a ÚNICA fonte de verdade de cor para todo o sistema de componentes.
class AppColors {
  const AppColors._();

  /// 01 — Laranja/Marrom. Cor primária: botões principais, ícones ativos,
  /// preço em destaque, indicador de aba ativa.
  static const Color primary = Color(0xFFC67C4E);

  /// 02 — Creme rosado. Cor secundária: fundo de chip selecionado,
  /// bordas suaves, superfícies de destaque leve.
  static const Color secondary = Color(0xFFEDD6C8);

  /// 03 — Quase preto. Texto principal, cabeçalho escuro (hero da Home).
  static const Color dark = Color(0xFF313131);

  /// 04 — Cinza claro. Bordas neutras, ícones inativos, divisores.
  static const Color grey = Color(0xFFE3E3E3);

  /// 05 — Creme. Fundo padrão das telas (background da app).
  static const Color cream = Color(0xFFF9F2ED);

  // ---------------------------------------------------------------------
  // Tokens auxiliares (não vêm do Color Guide, mas são necessários em
  // qualquer app real). Documentados separadamente para deixar claro que
  // são extensões do template e não parte do guia original do Figma.
  // ---------------------------------------------------------------------

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Texto secundário (subtítulos, descrições) — derivado de [dark] com
  /// opacidade reduzida para manter a hierarquia tipográfica do design.
  static const Color textSecondary = Color(0xFF8B8B8B);

  /// Cor de aviso/erro, usada apenas em estados de exemplo (ex.: item
  /// esgotado). Não faz parte da paleta original do Figma.
  static const Color danger = Color(0xFFE05C4E);

  /// Cor de sucesso, usada apenas em estados de exemplo.
  static const Color success = Color(0xFF3E9B5B);

  /// Overlay escuro semitransparente usado sobre imagens (badges de
  /// avaliação, banners promocionais).
  static Color darkOverlay(double opacity) => black.withOpacity(opacity);
}
