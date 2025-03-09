import 'package:flutter/material.dart';
import 'package:warung_keena_app/components/image_input.dart';
import 'package:warung_keena_app/data/models/product.dart';

import '../../data/datasources/local_datasources.dart';
import 'dashboard_page.dart';

class EditPage extends StatefulWidget {
  final Product product;

  const EditPage({super.key, required this.product});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    titleController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    descriptionController.text = widget.product.description;
    quantityController.text = widget.product.quantity.toString();
    _imagePath = widget.product.image;
    super.initState();
  }

  void _setImage(String imagePath) {
    setState(() {
      _imagePath = imagePath; // Simpan path gambar yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ImageInput(
              onImageSelected: _setImage,
              initialImage: _imagePath,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Menu',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Menu wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                  labelText: 'Harga', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Konversi harga dan jumlah ke tipe data yang sesuai
            double price = double.tryParse(priceController.text) ?? 0.0;
            int quantity = int.tryParse(quantityController.text) ?? 0;

            // Buat objek Product yang telah diperbarui
            Product updatedProduct = Product(
              id: widget.product.id,
              name: titleController.text,
              image: _imagePath ?? widget.product.image,
              description: descriptionController.text,
              price: price,
              quantity: quantity,
            );

            // Update produk di database
            LocalDatasource().updateProduct(updatedProduct);

            // Kembali ke halaman utama setelah update
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const DashboardPage();
            }));
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
