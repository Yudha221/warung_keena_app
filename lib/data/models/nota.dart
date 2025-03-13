class Nota {
  final double total;
  final String paymentMethod;
  final double? cash;
  final double? change;

  Nota({
    required this.total,
    required this.paymentMethod,
    this.cash,
    this.change,
  });
}
