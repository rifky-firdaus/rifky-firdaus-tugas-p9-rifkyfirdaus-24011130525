import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

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
              CartScope.of(context).add(product);
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Keranjang'),
          ),
        ),
      ),
    );
  }
}
