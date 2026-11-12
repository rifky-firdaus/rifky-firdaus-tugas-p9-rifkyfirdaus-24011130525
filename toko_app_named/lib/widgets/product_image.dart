import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.product,
    required this.width,
    required this.height,
    super.key,
  });

  final Product product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> imageProvider =
        product.imageUrl.startsWith('assets/')
        ? AssetImage(product.imageUrl)
        : NetworkImage(product.imageUrl);

    return SizedBox(
      width: width,
      height: height,
      child: Image(
        image: imageProvider,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : _ImagePlaceholder(product: product, width: width, height: height),
        errorBuilder: (context, error, stackTrace) =>
            _ImagePlaceholder(product: product, width: width, height: height),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({
    required this.product,
    required this.width,
    required this.height,
  });

  final Product product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final name = product.name.toLowerCase();
    final icon = name.contains('sepatu')
        ? Icons.directions_run
        : name.contains('tas')
        ? Icons.backpack
        : name.contains('jam')
        ? Icons.watch
        : name.contains('headphone')
        ? Icons.headphones
        : name.contains('botol')
        ? Icons.water_drop
        : Icons.shopping_bag;

    return Container(
      width: width.isFinite ? width : null,
      height: height,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: height * 0.45,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
