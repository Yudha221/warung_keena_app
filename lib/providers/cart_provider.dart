import 'package:flutter/material.dart';
import 'package:warung_keena_app/data/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  void toggleProduct(Product product) {
    if (_cart.contains(product)) {
      increaseQuantity(product);
    } else {
      product.quantity = 1;
      _cart.add(product);
    }
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    product.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      _cart.remove(product);
    }
    notifyListeners();
  }

  double totalPrice() {
    return _cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
