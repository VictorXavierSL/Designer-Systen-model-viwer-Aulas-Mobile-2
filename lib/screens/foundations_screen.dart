import 'package:flutter/material.dart';

import '../common/app_theme.dart';
import '../common/app_typography.dart';
import '../common/theme_toggle_button.dart';

/// Catálogo de **Foundations**: os tokens de cor e a escala tipográfica
/// que sustentam todos os componentes. Os swatches de cor refletem o
/// tema ativo no momento (use o botão no canto superior direito para
/// alternar entre claro e escuro e ver os valores mudarem em tempo real).
class FoundationsScreen extends StatelessWidget {
  const FoundationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    final isDark = context.isDarkMode;

    final swatches = <_Swatch>[
      _Swatch('Primary', tokens.primary, 'context.colors.primary'),
      _Swatch('On Primary', tokens.onPrimary, 'context.colors.onPrimary'),
      _Swatch('Secondary', tokens.secondary, 'context.colors.secondary'),
      _Swatch('On Secondary', tokens.onSecondary, 'context.colors.onSecondary'),
      _Swatch('Background', tokens.background, 'context.colors.background'),
      _Swatch('Surface', tokens.surface, 'context.colors.surface'),
      _Swatch('On Surface', tokens.onSurface, 'context.colors.onSurface'),
      _Swatch('Text Secondary', tokens.textSecondary, 'context.colors.textSecondary'),
      _Swatch('Border', tokens.border, 'context.colors.border'),
      _Swatch('Hero Background', tokens.heroBackground, 'context.colors.heroBackground'),
      _Swatch('Danger', tokens.danger, 'context.colors.danger'),
      _Swatch('Success', tokens.success, 'context.colors.success'),
    ];

    final specimens = <_Specimen>[
      _Specimen('Heading Large', AppTypography.headingLarge, '24 / 700'),
      _Specimen('Heading Medium', AppTypography.headingMedium, '18 / 700'),
      _Specimen('Title Small', AppTypography.titleSmall, '16 / 600'),
      _Specimen('Body Medium', AppTypography.bodyMedium, '14 / 400'),
      _Specimen('Body Small', AppTypography.bodySmall, '13 / 400'),
      _Specimen('Price', AppTypography.price, '18 / 700'),
      _Specimen('Button Large', AppTypography.buttonLarge, '16 / 600'),
      _Specimen('Caption', AppTypography.caption, '12 / 500'),
      _Specimen('Overline', AppTypography.overline, '11 / 700'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Foundations', style: AppTypography.headingMedium.copyWith(color: tokens.onSurface)),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          Text(
            'Tokens de cor e tipografia consumidos por todo o sistema. '
            'Tema exibido no momento: ${isDark ? 'Dark' : 'Light'}.',
            style: AppTypography.bodyMedium.copyWith(color: tokens.textSecondary),
          ),
          const SizedBox(height: 24),
          Text('COLOR', style: AppTypography.overline.copyWith(color: tokens.primary)),
          const SizedBox(height: 4),
          Text('Fonte: Color Guide do Figma (light) + extensão do template (dark).',
              style: AppTypography.bodySmall.copyWith(color: tokens.textSecondary)),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: swatches.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.6,
            ),
            itemBuilder: (context, index) => _ColorSwatchTile(swatch: swatches[index]),
          ),
          const SizedBox(height: 32),
          Text('TYPOGRAPHY', style: AppTypography.overline.copyWith(color: tokens.primary)),
          const SizedBox(height: 4),
          Text('Fonte: Sora (Google Fonts), extraída do frame "Typography" do Figma.',
              style: AppTypography.bodySmall.copyWith(color: tokens.textSecondary)),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: tokens.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: tokens.border),
            ),
            child: Column(
              children: [
                for (int i = 0; i < specimens.length; i++)
                  _TypeSpecimenTile(specimen: specimens[i], showDivider: i != specimens.length - 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Swatch {
  final String name;
  final Color color;
  final String token;

  const _Swatch(this.name, this.color, this.token);
}

class _Specimen {
  final String name;
  final TextStyle style;
  final String meta;

  const _Specimen(this.name, this.style, this.meta);
}

class _ColorSwatchTile extends StatelessWidget {
  final _Swatch swatch;

  const _ColorSwatchTile({required this.swatch});

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    final hex = '#${swatch.color.value.toRadixString(16).substring(2).toUpperCase()}';
    return Container(
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tokens.border),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: swatch.color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: tokens.border),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(swatch.name,
                    style: AppTypography.bodySmall.copyWith(color: tokens.onSurface, fontWeight: FontWeight.w600)),
                Text(hex, style: AppTypography.caption.copyWith(color: tokens.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeSpecimenTile extends StatelessWidget {
  final _Specimen specimen;
  final bool showDivider;

  const _TypeSpecimenTile({required this.specimen, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Text('Aa Sora', style: specimen.style.copyWith(color: tokens.onSurface)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(specimen.name,
                        style: AppTypography.bodySmall.copyWith(color: tokens.onSurface, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.end),
                    Text(specimen.meta, style: AppTypography.caption.copyWith(color: tokens.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: tokens.border),
      ],
    );
  }
}
