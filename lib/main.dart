import 'package:flutter/material.dart';

import 'common/app_theme.dart';
import 'common/theme_controller.dart';
import 'common/theme_toggle_button.dart';
import 'common/app_typography.dart';
import 'screens/foundations_screen.dart';
import 'screens/sample_action_button_screen.dart';
import 'screens/sample_list_items_screen.dart';
import 'screens/sample_screen.dart';
import 'screens/sample_tab_bar_screen.dart';
import 'screens/selectable_items_screen.dart';

void main() {
  runApp(const CoffeeDesignSystemApp());
}

/// Ponto de entrada do TEMPLATE.
///
/// Este app é o **catálogo do sistema de design** "JavaGem — Coffee
/// Shop", extraído de um arquivo Figma. Não é o produto final: é a
/// referência viva de tokens e componentes que você usa como ponto de
/// partida para construir o app real. Veja o README.md.
class CoffeeDesignSystemApp extends StatefulWidget {
  const CoffeeDesignSystemApp({super.key});

  @override
  State<CoffeeDesignSystemApp> createState() => _CoffeeDesignSystemAppState();
}

class _CoffeeDesignSystemAppState extends State<CoffeeDesignSystemApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeControllerScope(
      controller: _themeController,
      child: AnimatedBuilder(
        animation: _themeController,
        builder: (context, _) {
          return MaterialApp(
            title: 'Coffee Design System',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _themeController.value,
            home: const DesignSystemHomeScreen(),
          );
        },
      ),
    );
  }
}

class _CatalogEntry {
  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;

  const _CatalogEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
  });
}

class DesignSystemHomeScreen extends StatelessWidget {
  const DesignSystemHomeScreen({super.key});

  static const _foundations = [
    _CatalogEntry(
      title: 'Foundations',
      subtitle: 'Cores (claro/escuro) e escala tipográfica.',
      icon: Icons.palette_outlined,
      builder: _buildFoundations,
    ),
  ];

  static const _components = [
    _CatalogEntry(
      title: 'Button',
      subtitle: 'Primary, secondary e icon — por cor, tamanho e estado.',
      icon: Icons.smart_button_outlined,
      builder: _buildButtonCatalog,
    ),
    _CatalogEntry(
      title: 'Selectable Item',
      subtitle: 'Chips de seleção: seletor de tamanho e abas de categoria.',
      icon: Icons.check_circle_outline,
      builder: _buildSelectableCatalog,
    ),
    _CatalogEntry(
      title: 'Navigation',
      subtitle: 'Abas de categoria e navegação inferior.',
      icon: Icons.view_carousel_outlined,
      builder: _buildNavigationCatalog,
    ),
    _CatalogEntry(
      title: 'Card & List Item',
      subtitle: 'Card de produto e linha de carrinho.',
      icon: Icons.grid_view_outlined,
      builder: _buildCardCatalog,
    ),
  ];

  static const _preview = [
    _CatalogEntry(
      title: 'Composição de Uso',
      subtitle: 'Os componentes acima combinados em uma tela real.',
      icon: Icons.smartphone_outlined,
      builder: _buildComposition,
    ),
  ];

  static Widget _buildFoundations(BuildContext _) => const FoundationsScreen();
  static Widget _buildButtonCatalog(BuildContext _) => const SampleActionButtonScreen();
  static Widget _buildSelectableCatalog(BuildContext _) => const SelectableItemsScreen();
  static Widget _buildNavigationCatalog(BuildContext _) => const SampleTabBarScreen();
  static Widget _buildCardCatalog(BuildContext _) => const SampleListItemsScreen();
  static Widget _buildComposition(BuildContext _) => const SampleScreen();

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Design System', style: AppTypography.headingMedium.copyWith(color: tokens.onSurface)),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Sistema de design "JavaGem — Coffee Shop", extraído de um arquivo Figma '
            'e implementado em Dart/Flutter com o padrão Component / ViewModel / Factory.',
            style: AppTypography.bodyMedium.copyWith(color: tokens.textSecondary),
          ),
          const SizedBox(height: 28),
          _SectionLabel('FOUNDATIONS'),
          const SizedBox(height: 12),
          for (final entry in _foundations) ...[
            _CatalogCard(entry: entry),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 16),
          _SectionLabel('COMPONENTS'),
          const SizedBox(height: 12),
          for (final entry in _components) ...[
            _CatalogCard(entry: entry),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 16),
          _SectionLabel('PREVIEW'),
          const SizedBox(height: 12),
          for (final entry in _preview) ...[
            _CatalogCard(entry: entry),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Text(label, style: AppTypography.overline.copyWith(color: tokens.primary));
  }
}

class _CatalogCard extends StatelessWidget {
  final _CatalogEntry entry;

  const _CatalogCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Material(
      color: tokens.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: entry.builder)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: tokens.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: tokens.secondary, borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Icon(entry.icon, color: tokens.onSecondary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.title,
                        style: AppTypography.titleSmall.copyWith(color: tokens.onSurface)),
                    const SizedBox(height: 2),
                    Text(entry.subtitle, style: AppTypography.bodySmall.copyWith(color: tokens.textSecondary)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: tokens.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
