import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_keena_app/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider?>(context, listen: true);
    if (provider == null) {
      return const Scaffold(
        body: Center(child: Text("Provider tidak ditemukan")),
      );
    }

    final finalList = provider.cart;
    final total =
        provider.totalPrice(); // Total dengan diskon atau pajak jika ada

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        title: const Text(
          'Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Spasi di atas daftar
          Expanded(
            child: ListView.builder(
              itemCount: finalList.length,
              itemBuilder: (context, index) {
                final product = finalList[index];

                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: product.image.startsWith('/')
                        ? Image.file(File(product.image), fit: BoxFit.cover)
                        : Image.asset(product.image, fit: BoxFit.cover),
                  ),
                  title: Text(product.name),
                  subtitle: Text('Rp. ${formatPrice(product.price)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          provider.decreaseQuantity(product); // Kurangi jumlah
                        },
                      ),
                      Text(
                        product.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () {
                          provider.increaseQuantity(product); // Tambah jumlah
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: 180,
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rp. ${formatPrice(total)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Spasi antara Subtotal dan Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rp. ${formatPrice(total)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Spasi sebelum tombol Payment
                SizedBox(
                  width: double.infinity, // Tombol melebar penuh
                  height: 50, // Tinggi tombol
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // Warna latar belakang tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Membuat tombol lebih rounded
                      ),
                    ),
                    child: const Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Warna teks tombol
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
