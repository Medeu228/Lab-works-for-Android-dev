double processOrder({
  required String orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFee,
}) {
  final double discount = (promoCode == 'SAVE10') ? itemPrice * 0.10 : 0.0;
  final double priceAfterDiscount = itemPrice - discount;

  final double delivery = deliveryFee ?? 500.0;

  final double total = priceAfterDiscount + delivery;

  print('--- Order Summary ($orderId) ---');
  print('Item price: ${itemPrice.toStringAsFixed(2)}₸');
  if (discount > 0) {
    print('Discount (SAVE10): -${discount.toStringAsFixed(2)}₸');
  }
  print('Delivery fee: ${delivery.toStringAsFixed(2)}₸');
  print('Total: ${total.toStringAsFixed(2)}₸');
  print('');

  return total;
}

void main() {
  processOrder(orderId: 'A001', itemPrice: 5000.0, promoCode: 'SAVE10');

  processOrder(orderId: 'A002', itemPrice: 3000.0);

  processOrder(orderId: 'A003', itemPrice: 2000.0, promoCode: 'SAVE10', deliveryFee: 0.0);

  processOrder(orderId: 'A004', itemPrice: 1500.0, promoCode: 'WRONGCODE');
}