import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final double price;
  final double rating;
  final bool bestSeller;
  final String image;

  Book({
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.bestSeller,
    required this.image,
  });
}

class Bookstore extends StatelessWidget {
  final List<Book> cart;

  const Bookstore({required this.cart});

  @override
  Widget build(BuildContext context) {
    List<Book> books = [
      Book(
        title: "Harry Potter and the Deathly Hallows",
        author: "J.K. Rowling",
        price: 10,
        rating: 4.5,
        bestSeller: true,
        image: 'assets/im/image1.jpg',
      ),
      Book(
        title: "Crooked Kingdom",
        author: "Leigh Bardugo",
        price: 15,
        rating: 4.8,
        bestSeller: true,
        image: 'assets/im/image2.jpg',
      ),
      Book(
        title: "Words of Radiance",
        author: "Brandon Sanderson",
        price: 10,
        rating: 4.5,
        bestSeller: true,
        image: 'assets/im/image3.jpg',
      ),
      Book(
        title: "Fourth Wing",
        author: "Rebecca Yarros",
        price: 12,
        rating: 4.7,
        bestSeller: false,
        image: 'assets/im/image4.jpg',
      ),
    ];

    void addToCart(Book book) {
      cart.add(book);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // If screen width is less than 600, use 1 column, else 2 columns
          int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onAddToCart: () => addToCart(book),
              );
            },
          );
        },
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onAddToCart;

  const BookCard({required this.book, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 231, 231, 231),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          if (book.bestSeller)
            Container(
              padding: EdgeInsets.all(4),
              color: Colors.red,
              child: Text(
                'Best Seller',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(book.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Author: ${book.author}", style: TextStyle(color: Colors.grey)),
                Text("Price: \$${book.price}", style: TextStyle(color: Colors.green)),
                Text("Rating: ${book.rating} ★", style: TextStyle(color: Colors.amber)),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onAddToCart,
                  child: Text('Add to Cart', style: TextStyle(color: const Color.fromARGB(255, 9, 0, 14))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 140,
            child: ClipOval(
              child: Image.asset('assets/im/prof.jpg', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 16),
          Text('Email: user@example.com', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Username: john_doe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Password: password123', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
