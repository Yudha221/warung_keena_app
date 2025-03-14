import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/order_report_provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<OrderReportProvider>(context, listen: false)
          .fetchOrderReports();
    });
  }

  String formatCurrency(double amount) {
    return NumberFormat("#,##0", "id_ID").format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final orderReports = Provider.of<OrderReportProvider>(context).orderReports;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Penjualan"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: orderReports.isEmpty
          ? const Center(child: Text("Belum ada laporan transaksi"))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Order ID")),
                  DataColumn(label: Text("Tanggal")),
                  DataColumn(label: Text("Total (Rp)")),
                  DataColumn(label: Text("Metode Pembayaran")),
                  DataColumn(label: Text("Tunai (Rp)")),
                  DataColumn(label: Text("Kembalian (Rp)")),
                  DataColumn(label: Text("Aksi")),
                ],
                rows: orderReports.map((report) {
                  return DataRow(cells: [
                    DataCell(Text(report.orderId.toString())),
                    DataCell(Text(report.date)),
                    DataCell(Text(formatCurrency(report.totalAmount))),
                    DataCell(Text(report.paymentMethod)),
                    DataCell(Text(formatCurrency(report.cash ?? 0))),
                    DataCell(Text(formatCurrency(report.change ?? 0))),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          print("OrderReport sebelum hapus: ${report.toMap()}");
                          if (report.id != null) {
                            Provider.of<OrderReportProvider>(context,
                                    listen: false)
                                .deleteOrderReport(report.id!);
                          } else {
                            print("Gagal menghapus: ID tidak ditemukan");
                          }
                        },
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}
