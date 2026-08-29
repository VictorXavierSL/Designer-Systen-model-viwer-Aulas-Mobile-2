/// Caminhos de imagens usados pelos componentes de demonstração.
///
/// Este template NÃO inclui os arquivos binários originais do Figma
/// (eles expiram em 7 dias no link temporário do MCP). Em vez disso,
/// aponta para `assets/images/...`, que você deve preencher exportando
/// as imagens reais do arquivo Figma (Home > Product > Image).
///
/// Todos os componentes que usam [AppAssets] fazem fallback automático
/// para um placeholder visual (ver `AppImagePlaceholder` em
/// `components/list_items`) caso o arquivo não exista — assim o template
/// roda "out of the box" mesmo sem os assets reais.
class AppAssets {
  const AppAssets._();

  static const String _base = 'assets/images';

  static const String coffeeMocha = '$_base/coffee_mocha.png';
  static const String flatWhite = '$_base/flat_white.png';
  static const String cappuccino = '$_base/cappuccino.png';
  static const String americano = '$_base/americano.png';
  static const String promoBanner = '$_base/promo_banner.png';
  static const String avatarPlaceholder = '$_base/avatar_placeholder.png';
}
