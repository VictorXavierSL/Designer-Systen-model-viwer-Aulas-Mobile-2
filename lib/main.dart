import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/app_colors.dart';
import 'common/app_typography.dart';
import 'components/action_button/action_button_component.dart';
import 'components/action_button/action_button_factory.dart';
import 'screens/sample_action_button_screen.dart';
import 'screens/sample_list_items_screen.dart';
import 'screens/sample_screen.dart';
import 'screens/sample_tab_bar_screen.dart';

void main() {
  runApp(const CoffeeDesignSystemApp());
}

/// Ponto de entrada do TEMPLATE.
///
/// Importante: este app não é o "Coffee Shop" em si — é um demonstrativo
/// do sistema de design extraído do Figma. A tela inicial é um índice
/// que leva às telas-espelho de cada componente e à tela principal
/// montada. Veja o README.md para como usar isto como ponto de partida
/// de um app real.
class CoffeeDesignSystemApp extends StatelessWidget {
  const CoffeeDesignSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Design System — Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.cream,
        ),
        textTheme: GoogleFonts.soraTextTheme(),
      ),
      home: const _DesignSystemIndexScreen(),
    );
  }
}

class _DesignSystemIndexScreen extends StatelessWidget {
  const _DesignSystemIndexScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        foregroundColor: AppColors.dark,
        title: Text('Coffee Design System', style: AppTypography.headingMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Demonstrativo do sistema de design "JavaGem — Coffee Shop", '
            'extraído do Figma Community. Cada item abaixo abre uma '
            'tela-espelho de um componente, ou a tela principal montada.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 24),
          _IndexEntry(
            title: 'Tela principal montada',
            subtitle: 'Home real, composta pelos componentes reutilizáveis.',
            onPressed: () => _push(context, const SampleScreen()),
          ),
          const SizedBox(height: 12),
          _IndexEntry(
            title: 'Action Button — variantes',
            subtitle: 'Primary, secondary, outline, ghost e icon.',
            onPressed: () => _push(context, const SampleActionButtonScreen()),
          ),
          const SizedBox(height: 12),
          _IndexEntry(
            title: 'Tab Bar — variantes',
            subtitle: 'Category chips e bottom navigation.',
            onPressed: () => _push(context, const SampleTabBarScreen()),
          ),
          const SizedBox(height: 12),
          _IndexEntry(
            title: 'List Items — variantes',
            subtitle: 'Product card e cart line.',
            onPressed: () => _push(context, const SampleListItemsScreen()),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _IndexEntry extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const _IndexEntry({required this.title, required this.subtitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleSmall),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ActionButtonComponent(
            viewModel: ActionButtonFactory.icon(
              icon: Icons.arrow_forward_rounded,
              isSelected: true,
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
