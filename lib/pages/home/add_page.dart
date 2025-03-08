import 'dart:io';
import 'package:flutter/material.dart';
import 'package:warung_keena_app/components/image_input.dart';
import 'package:warung_keena_app/data/models/product.dart';
import '../../data/datasources/local_datasources.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

  String? _imagePath; // Path gambar

  void _setImage(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        title: const Text(
          'Add Menu',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ImageInput(onImageSelected: _setImage),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Menu', border: OutlineInputBorder()),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Menu wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Deskripsi', border: OutlineInputBorder()),
              maxLines: 4,
              validator: (value) => value == null || value.isEmpty
                  ? 'Deskripsi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                  labelText: 'Harga', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Harga wajib diisi';
                if (double.tryParse(value) == null)
                  return 'Harga harus berupa angka';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(
                  labelText: 'Kuantitas', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Kuantitas wajib diisi';
                if (int.tryParse(value) == null)
                  return 'Kuantitas harus berupa angka bulat';
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (_imagePath == null || _imagePath!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gambar wajib diisi")),
                    );
                    return;
                  }

                  double price = double.parse(priceController.text);
                  int quantity = int.parse(quantityController.text);

                  Product newProduct = Product(
                    name: titleController.text,
                    image: _imagePath!,
                    description: descriptionController.text,
                    price: price,
                    quantity: quantity,
                  );

                  final db = LocalDatasource();
                  await db.insertProduct(newProduct);

                  print("✅ Produk Ditambahkan: ${newProduct.toJson()}");

                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
