class OrderReport {
  final int? id; //  Tambahkan id
  final String orderId;
  final String date;
  final double totalAmount;
  final String paymentMethod;
  final double? cash;
  final double? change;

  OrderReport({
    this.id, //  Jangan wajibkan id, karena di-generate SQLite
    required this.orderId,
    required this.date,
    required this.totalAmount,
    required this.paymentMethod,
    this.cash,
    this.change,
  });

  // metode fromMap
  factory OrderReport.fromMap(Map<String, dynamic> map) {
    return OrderReport(
      id: map['id'] as int?, //  Pastikan mengambil 'id'
      orderId: map['orderId'].toString(),
      date: map['date'].toString(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      paymentMethod: map['paymentMethod'].toString(),
      cash: map['cash'] != null ? (map['cash'] as num).toDouble() : null,
      change: map['change'] != null ? (map['change'] as num).toDouble() : null,
    );
  }

  // metode toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Simpan id jika ada
      'orderId': orderId,
      'date': date,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'cash': cash,
      'change': change,
    };
  }
}
