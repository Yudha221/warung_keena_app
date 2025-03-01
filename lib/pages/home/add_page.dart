import 'package:flutter/material.dart';
import 'package:warung_keena_app/components/image_input.dart';
import 'package:warung_keena_app/models/product.dart';

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
  final imageController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        flexibleSpace: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Add Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
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
              validator: (value) => value == null || value.isEmpty
                  ? 'Deskripsi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            // Image Input
            ImageInput(),
            const SizedBox(height: 16),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                  labelText: 'Harga', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Harga wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(
                  labelText: 'Kuantitas', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty
                  ? 'Kuantitas wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  double price = double.tryParse(priceController.text) ?? 0.0;
                  int quantity = int.tryParse(quantityController.text) ?? 1;

                  Product newProduct = Product(
                    id: DateTime.now().millisecondsSinceEpoch, // ID unik
                    name: titleController.text,
                    image: imageController.text,
                    description: descriptionController.text,
                    price: price,
                    quantity: quantity,
                  );

                  print("Produk Ditambahkan: ${newProduct.toJson()}");

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
