import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../widgets/product_image.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_shopping_cart, size: 64),
                  SizedBox(height: 12),
                  Text('Keranjang masih kosong'),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cart.items.length,
            separatorBuilder: (context, index) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ProductImage(
                      product: item.product,
                      width: 76,
                      height: 76,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(item.product.formattedPrice),
                        Text(
                          'Subtotal: ${_formatPrice(item.subtotal)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Row(
                          children: [
                            IconButton(
                              tooltip: 'Kurangi jumlah',
                              onPressed: () => cart.removeOne(item.product),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              tooltip: 'Tambah jumlah',
                              onPressed: () => cart.add(item.product),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                            const Spacer(),
                            IconButton(
                              tooltip: 'Hapus produk',
                              onPressed: () => cart.remove(item.product),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: cart,
        builder: (context, child) => cart.items.isEmpty
            ? const SizedBox.shrink()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: ${_formatPrice(cart.total)}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
      ),
    );
  }

  String _formatPrice(double price) {
    final digits = price.toStringAsFixed(0);
    final buffer = StringBuffer('Rp ');
    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && (digits.length - index) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[index]);
    }
    return buffer.toString();
  }
}
