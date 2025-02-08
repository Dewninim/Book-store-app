import 'package:flutter/material.dart';
import 'book.dart';

class CartPage extends StatelessWidget {
  final List<Book> cart;
  final Function(String) removeFromCart;

  const CartPage({required this.cart, required this.removeFromCart});

  @override
  Widget build(BuildContext context) {
    return cart.isEmpty
        ? Center(child: Text('Your cart is empty'))
        : ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final book = cart[index];
              return ListTile(
                title: Text(book.title),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () => removeFromCart(book.title),
                ),
              );
            },
          );
  }
}
