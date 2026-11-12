import 'package:flutter/material.dart';

import 'product.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get subtotal => product.price * quantity;
}

class CartController extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => List.unmodifiable(_items.values);

  int get itemCount =>
      _items.values.fold(0, (total, item) => total + item.quantity);

  double get total => _items.values.fold(0, (sum, item) => sum + item.subtotal);

  void add(Product product) {
    final current = _items[product.id];
    _items[product.id] = CartItem(
      product: product,
      quantity: (current?.quantity ?? 0) + 1,
    );
    notifyListeners();
  }

  void removeOne(Product product) {
    final current = _items[product.id];
    if (current == null) return;

    if (current.quantity == 1) {
      _items.remove(product.id);
    } else {
      _items[product.id] = CartItem(
        product: product,
        quantity: current.quantity - 1,
      );
    }
    notifyListeners();
  }

  void remove(Product product) {
    if (_items.remove(product.id) != null) notifyListeners();
  }
}

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    required CartController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope is missing from the widget tree');
    return scope!.notifier!;
  }
}
