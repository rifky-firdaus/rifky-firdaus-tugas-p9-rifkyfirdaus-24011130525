import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../routes/app_routes.dart';
import '../widgets/product_image.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<void> _openDetail(Product product) async {
    final added = await Navigator.pushNamed(
      context,
      AppRoutes.productDetail,
      arguments: product,
    );

    if (!mounted) return;
    if (added != true) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          AnimatedBuilder(
            animation: cart,
            builder: (context, child) => Badge(
              label: Text('${cart.itemCount}'),
              isLabelVisible: cart.itemCount > 0,
              child: child,
            ),
            child: IconButton(
              tooltip: 'Buka keranjang',
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        itemCount: dummyProducts.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ProductImage(product: product, width: 56, height: 56),
            ),
            title: Text(product.name),
            subtitle: Text(product.formattedPrice),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openDetail(product),
          );
        },
      ),
    );
  }
}
