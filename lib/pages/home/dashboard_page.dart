import 'dart:async';

import 'package:flutter/material.dart';
import 'package:warung_keena_app/components/my_drawer.dart';
import 'package:warung_keena_app/components/product_card.dart';
import 'package:warung_keena_app/data/datasources/local_datasources.dart';
import 'package:warung_keena_app/data/models/product.dart';
import 'package:warung_keena_app/pages/cart/cart_page.dart';
import 'package:warung_keena_app/pages/home/detail_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Product> products = [];
  bool isLoading = false;
  String searchQuery = '';

  Future<void> getProducts() async {
    setState(() {
      isLoading = true;
    });

    // Ambil produk dari database
    List<Product> fetchedProducts = await LocalDatasource().getProducts();

    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart),
            padding: const EdgeInsets.only(
              right: 10,
            ),
            color: Colors.white,
          ),
        ],
      ),
      drawer: MyDrawer(
          onRefresh: getProducts), // Pastikan `MyDrawer` sudah didefinisikan
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator()) // Menampilkan loading
                : products.isEmpty
                    ? const Center(child: Text('Produk tidak tersedia'))
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailPage(
                                    product:
                                        products[index]); // Perbaikan di sini
                              }));
                            },
                            child: ProductCard(
                              product: products[index], // Perbaikan di sini
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
