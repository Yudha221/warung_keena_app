import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:warung_keena_app/data/models/nota.dart';
import 'package:warung_keena_app/data/models/order_report.dart';
import 'package:warung_keena_app/pages/payment/nota_page.dart';
import 'package:warung_keena_app/providers/order_report_provider.dart';

class PaymentPage extends StatefulWidget {
  final double total;

  const PaymentPage({super.key, required this.total});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'Cash'; // Default metode pembayaran
  final TextEditingController _amountController = TextEditingController();

  String formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.');
  }

  Widget buildPaymentOption(String method, IconData icon) {
    bool isSelected = _selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            const SizedBox(width: 10),
            Text(
              method,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Menampilkan total pembayaran di tengah
            Column(
              children: [
                Text(
                  "Rp. ${formatPrice(widget.total)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pilih Metode Pembayaran:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Opsi pembayaran dalam Container
            Row(
              children: [
                Expanded(child: buildPaymentOption('Cash', Icons.money)),
                const SizedBox(width: 10),
                Expanded(child: buildPaymentOption('QRIS', Icons.qr_code)),
              ],
            ),

            const SizedBox(height: 20),

            // Input jumlah pembayaran jika metode Cash dipilih
            if (_selectedPaymentMethod == 'Cash')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Masukkan Uang yang Dibayarkan:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan nominal",
                      ),
                    ),
                  ),
                ],
              ),

            // Menampilkan QR Code jika memilih QRIS
            if (_selectedPaymentMethod == 'QRIS')
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/qiris_example.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Scan QR untuk melakukan pembayaran",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Tombol Bayar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final orderReportProvider =
                      Provider.of<OrderReportProvider>(context, listen: false);

                  double? cashAmount;
                  double? change;

                  if (_selectedPaymentMethod == 'Cash') {
                    cashAmount = double.tryParse(_amountController.text) ?? 0;
                    change = cashAmount - widget.total;

                    if (cashAmount < widget.total) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Uang kurang!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                  }

                  // Format waktu transaksi
                  String formattedDate =
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                  // Simpan ke dalam laporan (OrderReportProvider)
                  final orderReport = OrderReport(
                    orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                    // ✅ Gunakan int langsung
                    date: DateTime.now()
                        .toIso8601String(), // ✅ Ubah DateTime ke String
                    totalAmount: widget.total,
                    paymentMethod: _selectedPaymentMethod,
                    cash: cashAmount,
                    change: change,
                  );

                  await orderReportProvider.addOrderReport(orderReport);

                  // Navigasi ke halaman Nota
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotaPage(
                        nota: Nota(
                          total: widget.total,
                          paymentMethod: _selectedPaymentMethod,
                          cash: cashAmount,
                          change: change,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Bayar",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
