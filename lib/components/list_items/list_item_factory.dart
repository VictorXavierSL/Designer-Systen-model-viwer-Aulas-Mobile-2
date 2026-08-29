import 'package:flutter/material.dart';

import '../../common/app_assets.dart';
import '../../common/showcase_models.dart';
import 'list_item_viewmodel.dart';

/// O Criador de Variantes de cards de produto/carrinho.
class ListItemFactory {
  const ListItemFactory._();

  static ListItemViewModel productCard({
    required String title,
    String? subtitle,
    required String price,
    double? rating,
    int? reviewCount,
    String? imagePath,
    bool isAvailable = true,
    VoidCallback? onTap,
    VoidCallback? onAdd,
  }) {
    return ListItemViewModel(
      title: title,
      subtitle: subtitle,
      price: price,
      rating: rating,
      reviewCount: reviewCount,
      imagePath: imagePath,
      variant: ListItemVariant.productCard,
      isAvailable: isAvailable,
      onTap: onTap,
      onAdd: onAdd,
    );
  }

  static ListItemViewModel cartLine({
    required String title,
    required String price,
    String? imagePath,
    int quantity = 1,
    ValueChanged<int>? onQuantityChanged,
  }) {
    return ListItemViewModel(
      title: title,
      price: price,
      imagePath: imagePath,
      variant: ListItemVariant.cartLine,
      quantity: quantity,
      onQuantityChanged: onQuantityChanged,
    );
  }

  /// Produtos "reais" (nomes/preços/ratings) extraídos da tela Home em
  /// alta fidelidade do Figma — usados no [sample_screen] e no showcase.
  static List<ListItemViewModel> demoMenu() {
    return [
      productCard(
        title: 'Caffe Mocha',
        subtitle: 'Deep Foam',
        price: '\$ 4.53',
        rating: 4.8,
        reviewCount: 230,
        imagePath: AppAssets.coffeeMocha,
      ),
      productCard(
        title: 'Flat White',
        subtitle: 'Espresso',
        price: '\$ 3.53',
        rating: 4.8,
        reviewCount: 189,
        imagePath: AppAssets.flatWhite,
      ),
      productCard(
        title: 'Cappuccino',
        subtitle: 'Ice/Hot',
        price: '\$ 4.20',
        rating: 4.7,
        reviewCount: 142,
        imagePath: AppAssets.cappuccino,
      ),
      productCard(
        title: 'Americano',
        subtitle: 'Ice/Hot',
        price: '\$ 3.10',
        rating: 4.5,
        reviewCount: 98,
        imagePath: AppAssets.americano,
      ),
    ];
  }

  /// Catálogo completo usado por `sample_list_items_screen`.
  static List<ShowcaseSection<ListItemViewModel>> showcaseCatalog() {
    return [
      ShowcaseSection(
        title: 'Product Card',
        description: 'Card do grid da Home, com variações de estado.',
        items: [
          ShowcaseItem(caption: 'Disponível', viewModel: demoMenu().first),
          ShowcaseItem(
            caption: 'Sem avaliação',
            viewModel: productCard(title: 'House Blend', price: '\$ 2.90'),
          ),
          ShowcaseItem(
            caption: 'Esgotado (disabled)',
            viewModel: productCard(
              title: 'Cold Brew',
              price: '\$ 3.80',
              rating: 4.6,
              isAvailable: false,
            ),
          ),
        ],
      ),
      ShowcaseSection(
        title: 'Cart Line',
        description: 'Linha compacta usada na tela de Order/Checkout.',
        items: [
          ShowcaseItem(
            caption: 'Quantidade 1',
            viewModel: cartLine(title: 'Caffe Mocha', price: '\$ 4.53', quantity: 1),
          ),
          ShowcaseItem(
            caption: 'Quantidade 3',
            viewModel: cartLine(title: 'Flat White', price: '\$ 3.53', quantity: 3),
          ),
        ],
      ),
    ];
  }
}
