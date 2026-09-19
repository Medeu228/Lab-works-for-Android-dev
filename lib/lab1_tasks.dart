import 'dart:io';

void printMultiplicationTable() {
  for (int i = 1; i <= 10; i++) {
    for (int j = 1; j <= 10; j++) {
      stdout.write((i * j).toString().padLeft(5));
    }
    print('');
  }
}


bool isLeapYear(int year) {
  // divisible by 4, but not by 100 unless also divisible by 400
  return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

int daysInMonth(int month, int year) {
  const List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (month == 2 && isLeapYear(year)) return 29;
  return days[month - 1];
}

String? nextDay(int day, int month, int year) {
  if (month < 1 || month > 12) return null;
  if (day < 1 || day > daysInMonth(month, year)) return null;

  int nextD = day;
  int nextM = month;
  int nextY = year;

  if (day < daysInMonth(month, year)) {
    nextD = day + 1;
  } else {
    nextD = 1;
    if (month == 12) {
      nextM = 1;
      nextY = year + 1;
    } else {
      nextM = month + 1;
    }
  }

  return '${nextD.toString().padLeft(2, '0')}.${nextM.toString().padLeft(2, '0')}.$nextY';
}

void testNextDay() {
  final List<List<int>> testDates = [
    [5, 9, 2026],
    [28, 2, 2024],
    [28, 2, 2026],
    [29, 2, 2026],
    [28, 2, 2100],
    [28, 2, 2000],
    [31, 12, 2025],
  ];

  for (final d in testDates) {
    final input =
        '${d[0].toString().padLeft(2, '0')}.${d[1].toString().padLeft(2, '0')}.${d[2]}';
    final result = nextDay(d[0], d[1], d[2]);
    print('$input -> ${result ?? "invalid date"}');
  }
}


int countVowels(String text) {
  const vowels = 'aeiouAEIOU';
  int count = 0;
  for (int i = 0; i < text.length; i++) {
    if (vowels.contains(text[i])) count++;
  }
  return count;
}


void findMinMax(List<int> list) {
  int minVal = list[0];
  int maxVal = list[0];

  for (int i = 1; i < list.length; i++) {
    if (list[i] < minVal) minVal = list[i];
    if (list[i] > maxVal) maxVal = list[i];
  }

  print('list: $list -> max: $maxVal, min: $minVal');
}


bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void testPrime(int n) {
  print('$n -> ${isPrime(n) ? "prime number" : "not prime number"}');
}

void main() {
  print('TASK 1: Multiplication table 1-10');
  printMultiplicationTable();

  print('\nTASK 2: Next day calculator');
  testNextDay();

  print('\nTASK 3: Vowel counter');
  const phrase = 'flutter mobile development';
  print('"$phrase" -> ${countVowels(phrase)}');

  print('\nTASK 4: Manual min & max finder');
  findMinMax([14, 88, 3, 42, 99, 12, 67]);
  findMinMax([234, 34, 123, 44, 949, 112, 67]);

  print('\nTASK 5: Prime number checker');
  testPrime(3);
  testPrime(6);
  testPrime(17);
  testPrime(1);
}