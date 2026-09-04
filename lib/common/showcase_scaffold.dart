import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'app_typography.dart';
import 'showcase_models.dart';
import 'theme_toggle_button.dart';

/// Scaffold compartilhado por todas as páginas de catálogo de componentes.
///
/// Cada página de catálogo (`components/*`) só precisa fornecer o
/// [title], a lista de [ShowcaseSection] (vinda de `*Factory.showcaseCatalog()`)
/// e como desenhar UM item (`itemBuilder`). A variação de conteúdo vive
/// nas factories; a variação de layout vive aqui — incluindo o botão de
/// alternância de tema, disponível em toda página do catálogo.
class ComponentCatalogScaffold<T> extends StatelessWidget {
  final String title;
  final String description;
  final List<ShowcaseSection<T>> sections;
  final Widget Function(BuildContext context, T viewModel) itemBuilder;
  final WrapAlignment itemsAlignment;

  const ComponentCatalogScaffold({
    super.key,
    required this.title,
    required this.description,
    required this.sections,
    required this.itemBuilder,
    this.itemsAlignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppTypography.headingMedium.copyWith(color: tokens.onSurface)),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          Text(description, style: AppTypography.bodyMedium.copyWith(color: tokens.textSecondary)),
          const SizedBox(height: 20),
          for (final section in sections) _buildSection(context, section),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, ShowcaseSection<T> section) {
    final tokens = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title.toUpperCase(),
              style: AppTypography.overline.copyWith(color: tokens.primary)),
          if (section.description != null) ...[
            const SizedBox(height: 4),
            Text(section.description!, style: AppTypography.bodySmall.copyWith(color: tokens.textSecondary)),
          ],
          const SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: itemsAlignment,
            children: [
              for (final item in section.items)
                _ShowcaseTile(caption: item.caption, child: itemBuilder(context, item.viewModel)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShowcaseTile extends StatelessWidget {
  final String caption;
  final Widget child;

  const _ShowcaseTile({required this.caption, required this.child});

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(height: 8),
          Text(caption, style: AppTypography.caption.copyWith(color: tokens.textSecondary)),
        ],
      ),
    );
  }
}
