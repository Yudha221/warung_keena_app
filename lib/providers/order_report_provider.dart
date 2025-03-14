import 'package:flutter/material.dart';
import '../data/datasources/local_datasources.dart';
import '../data/models/order_report.dart';

class OrderReportProvider extends ChangeNotifier {
  final LocalDatasource _localDatasource = LocalDatasource();
  List<OrderReport> _orderReports = [];

  List<OrderReport> get orderReports => _orderReports;

  Future<void> fetchOrderReports() async {
    _orderReports = await _localDatasource.getAllOrderReports();
    notifyListeners();
  }

  Future<void> addOrderReport(OrderReport report) async {
    await _localDatasource.insertOrderReport(report);
    await fetchOrderReports(); // Refresh data setelah insert
  }

  Future<void> deleteOrderReport(int id) async {
    await _localDatasource.deleteOrderReportById(id);
    await fetchOrderReports(); // Refresh data setelah delete
  }
}
