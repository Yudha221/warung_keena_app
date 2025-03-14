import 'dart:io';
import 'package:flutter/material.dart';
import '../data/models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    bool isLocalFile = widget.product.image.startsWith('/data/user') ||
        widget.product.image.startsWith('/storage/');

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: 140,
            child: isLocalFile
                ? Image.file(File(widget.product.image),
                    fit: BoxFit.cover) //  Gambar dari kamera/gallery
                : Image.asset(widget.product.image,
                    fit: BoxFit.cover), //  Gambar dari assets
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Rp. ${widget.product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.')}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
