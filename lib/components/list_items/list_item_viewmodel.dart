import 'package:flutter/material.dart';

/// - [productCard] → card do grid da Home (imagem, badge de rating,
///                    nome, subtítulo, preço, botão de adicionar).
/// - [cartLine]     → linha compacta usada na tela de Order/Checkout
///                    (imagem pequena, nome+preço, stepper de qtd).
enum ListItemVariant { productCard, cartLine }

@immutable
class ListItemViewModel {
  final String title;
  final String? subtitle;
  final String price;
  final double? rating;
  final int? reviewCount;
  final String? imagePath;
  final ListItemVariant variant;
  final bool isAvailable;
  final int quantity;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;
  final ValueChanged<int>? onQuantityChanged;

  const ListItemViewModel({
    required this.title,
    this.subtitle,
    required this.price,
    this.rating,
    this.reviewCount,
    this.imagePath,
    this.variant = ListItemVariant.productCard,
    this.isAvailable = true,
    this.quantity = 1,
    this.onTap,
    this.onAdd,
    this.onQuantityChanged,
  });

  ListItemViewModel copyWith({
    String? title,
    String? subtitle,
    String? price,
    double? rating,
    int? reviewCount,
    String? imagePath,
    ListItemVariant? variant,
    bool? isAvailable,
    int? quantity,
    VoidCallback? onTap,
    VoidCallback? onAdd,
    ValueChanged<int>? onQuantityChanged,
  }) {
    return ListItemViewModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imagePath: imagePath ?? this.imagePath,
      variant: variant ?? this.variant,
      isAvailable: isAvailable ?? this.isAvailable,
      quantity: quantity ?? this.quantity,
      onTap: onTap ?? this.onTap,
      onAdd: onAdd ?? this.onAdd,
      onQuantityChanged: onQuantityChanged ?? this.onQuantityChanged,
    );
  }
}
