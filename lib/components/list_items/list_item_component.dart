import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_typography.dart';
import '../action_button/action_button_component.dart';
import '../action_button/action_button_factory.dart';
import 'list_item_viewmodel.dart';

export 'list_item_viewmodel.dart';

/// A UI Visual do card/linha de produto.
class ListItemComponent extends StatelessWidget {
  final ListItemViewModel viewModel;

  const ListItemComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    switch (viewModel.variant) {
      case ListItemVariant.productCard:
        return _ProductCard(viewModel: viewModel);
      case ListItemVariant.cartLine:
        return _CartLine(viewModel: viewModel);
    }
  }
}

/// Placeholder visual usado sempre que `imagePath` não existir no bundle
/// de assets — assim o template roda mesmo sem as imagens reais do Figma.
class _CoffeeImage extends StatelessWidget {
  final String? path;
  final double size;
  final BorderRadius borderRadius;

  const _CoffeeImage({required this.path, required this.size, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: size,
        height: size,
        child: path == null
            ? _placeholder()
            : Image.asset(
                path!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(),
              ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.secondary,
      alignment: Alignment.center,
      child: const Icon(Icons.coffee_rounded, color: AppColors.primary),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ListItemViewModel viewModel;

  const _ProductCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: viewModel.isAvailable ? 1 : 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: viewModel.isAvailable ? viewModel.onTap : null,
        child: Container(
          width: 156,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _CoffeeImage(
                    path: viewModel.imagePath,
                    size: 140,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  if (viewModel.rating != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.darkOverlay(0.55),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              viewModel.rating!.toStringAsFixed(1),
                              style: AppTypography.caption.copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (!viewModel.isAvailable)
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Sold Out',
                              style: AppTypography.caption.copyWith(color: AppColors.white)),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(viewModel.title, style: AppTypography.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              if (viewModel.subtitle != null)
                Text(viewModel.subtitle!, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel.price, style: AppTypography.price),
                  ActionButtonComponent(
                    viewModel: ActionButtonFactory.icon(
                      icon: Icons.add_rounded,
                      isSelected: true,
                      isEnabled: viewModel.isAvailable,
                      size: ActionButtonSize.small,
                      onPressed: viewModel.onAdd,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartLine extends StatelessWidget {
  final ListItemViewModel viewModel;

  const _CartLine({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CoffeeImage(path: viewModel.imagePath, size: 54, borderRadius: BorderRadius.circular(12)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(viewModel.title, style: AppTypography.titleSmall),
              const SizedBox(height: 4),
              Text(viewModel.price, style: AppTypography.price.copyWith(fontSize: 14)),
            ],
          ),
        ),
        ActionButtonComponent(
          viewModel: ActionButtonFactory.icon(
            icon: Icons.remove_rounded,
            size: ActionButtonSize.small,
            onPressed: () => viewModel.onQuantityChanged?.call(viewModel.quantity - 1),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text('${viewModel.quantity}', textAlign: TextAlign.center, style: AppTypography.titleSmall),
        ),
        ActionButtonComponent(
          viewModel: ActionButtonFactory.icon(
            icon: Icons.add_rounded,
            isSelected: true,
            size: ActionButtonSize.small,
            onPressed: () => viewModel.onQuantityChanged?.call(viewModel.quantity + 1),
          ),
        ),
      ],
    );
  }
}
