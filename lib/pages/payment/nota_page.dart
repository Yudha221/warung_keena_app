import 'package:flutter/material.dart';
import 'package:warung_keena_app/pages/home/dashboard_page.dart';

import '../../data/models/nota.dart';

class NotaPage extends StatelessWidget {
  final Nota nota;

  const NotaPage({super.key, required this.nota});

  // Fungsi untuk format harga dengan pemisah ribuan
  String formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nota Pembayaran"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Total Pembayaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              "Rp. ${formatPrice(nota.total)}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Metode: ${nota.paymentMethod}",
              style: const TextStyle(fontSize: 18),
            ),
            if (nota.paymentMethod == "Cash") ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildRow("Bayar", "Rp ${formatPrice(nota.cash ?? 0)}"),
                    const Divider(thickness: 1, height: 20),
                    _buildRow("Kembali", "Rp ${formatPrice(nota.change ?? 0)}"),
                  ],
                ),
              ),
            ],
            if (nota.paymentMethod == "QRIS") ...[
              const SizedBox(height: 16),
              Image.asset('assets/images/qiris_example.png',
                  width: 180, height: 180),
            ],
            const SizedBox(height: 30),
            _buildButton("Cetak Nota", Colors.blue, () {}),
            const SizedBox(height: 10),
            _buildButton("Selesai", Colors.green, () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
                (route) => false, // Hapus semua halaman sebelumnya
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
