import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../state/cart_state.dart';
import '../widgets/product_image.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.cartState,
  });

  final int? productId;
  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    final id = productId;
    final product = id == null ? null : findProductById(id);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Produk')),
        body: const Center(child: Text('Produk tidak ditemukan')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ProductImage(
              product: product,
              width: double.infinity,
              height: 220,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            product.formattedPrice,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.description),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () {
              cartState.add(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} ditambahkan ke keranjang'),
                ),
              );
              context.pop();
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Keranjang'),
          ),
        ),
      ),
    );
  }
}
