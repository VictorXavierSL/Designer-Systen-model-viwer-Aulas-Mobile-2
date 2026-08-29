import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'showcase_models.dart';

/// Scaffold genérico de "tela-espelho".
///
/// Cada `sample_*_screen.dart` só precisa fornecer o [title], a lista de
/// [ShowcaseSection] (vinda de `*Factory.showcaseCatalog()`) e como
/// desenhar UM item (`itemBuilder`). Isso mantém as telas de showcase
/// finas — a variação de conteúdo vive nas factories, a variação de
/// layout vive aqui.
class ShowcaseScaffold<T> extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<ShowcaseSection<T>> sections;
  final Widget Function(BuildContext context, T viewModel) itemBuilder;
  final WrapAlignment itemsAlignment;

  const ShowcaseScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.sections,
    required this.itemBuilder,
    this.itemsAlignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        foregroundColor: AppColors.dark,
        title: Text(title, style: AppTypography.headingMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          Text(subtitle, style: AppTypography.bodyMedium),
          const SizedBox(height: 20),
          for (final section in sections) _buildSection(context, section),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, ShowcaseSection<T> section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title, style: AppTypography.headingMedium),
          if (section.description != null) ...[
            const SizedBox(height: 4),
            Text(section.description!, style: AppTypography.bodySmall),
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(height: 8),
          Text(caption, style: AppTypography.caption),
        ],
      ),
    );
  }
}
