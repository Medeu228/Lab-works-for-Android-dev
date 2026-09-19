void checkBalance({required String name, required double balance}) =>
    print('$name\'s available balance: \$${balance.toStringAsFixed(2)}');

double deposit({required double currentBalance, double? amount}) {
  final double depositAmount = amount ?? 0.0;
  final double updatedBalance = currentBalance + depositAmount;
  print(
    'Deposit received: \$${depositAmount.toStringAsFixed(2)}. '
    'New balance: \$${updatedBalance.toStringAsFixed(2)}',
  );
  return updatedBalance;
}

double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  const int correctPin = 1234;
  final int enteredPin = pinCode ?? 0000;

  if (enteredPin != correctPin) {
    print('Transaction declined for $name: incorrect PIN code.');
    return currentBalance;
  }

  final double withdrawAmount = amount ?? 0.0;

  if (withdrawAmount > currentBalance) {
    print('Transaction declined for $name: insufficient funds.');
    return currentBalance;
  }

  final double updatedBalance = currentBalance - withdrawAmount;
  print(
    'Withdrawal approved for $name: -\$${withdrawAmount.toStringAsFixed(2)}. '
    'New balance: \$${updatedBalance.toStringAsFixed(2)}',
  );
  return updatedBalance;
}

void main() {
  String userName = 'Medeu';
  double balance = 500.0;

  checkBalance(name: userName, balance: balance);

  balance = deposit(currentBalance: balance, amount: 150.0);

  balance = deposit(currentBalance: balance);

  balance = withdraw(name: userName, currentBalance: balance, amount: 100.0, pinCode: 9999);

  balance = withdraw(name: userName, currentBalance: balance, amount: 200.0, pinCode: 1234);

  balance = withdraw(name: userName, currentBalance: balance, amount: 999999.0, pinCode: 1234);

  balance = withdraw(name: userName, currentBalance: balance, amount: 50.0);

  checkBalance(name: userName, balance: balance);
}