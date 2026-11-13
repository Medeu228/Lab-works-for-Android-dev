import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

/// Error with a message that can be shown on the error screen.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

/// All network code lives here — screens only call fetchProducts().
class ProductApi {
  static const _baseUrl = 'https://fakestoreapi.com';
  static const _timeout = Duration(seconds: 10);

  Future<List<Product>> fetchProducts() async {
    final http.Response response;
    try {
      response = await http
          .get(Uri.parse('$_baseUrl/products'))
          .timeout(_timeout); // no answer in 10 s -> TimeoutException
    } on TimeoutException {
      throw const ApiException(
        'The server took too long to respond (10 s timeout).',
      );
    } catch (_) {
      // http.ClientException / SocketException: no internet, airplane mode,
      // DNS failure...
      throw const ApiException(
        'No internet connection. Check Wi-Fi or mobile data.',
      );
    }

    // ---- HTTP status codes ----
    switch (response.statusCode) {
      case 200:
        break; // OK, parse below
      case 404:
        throw const ApiException('Products not found (404).');
      case >= 500:
        throw ApiException(
          'Server error (${response.statusCode}). Try again later.',
        );
      default:
        throw ApiException('Unexpected response (${response.statusCode}).');
    }

    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final list = decoded as List<dynamic>;
      return list
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } on FormatException {
      throw const ApiException('The server sent invalid data.');
    } catch (_) {
      // JSON was valid but not a list of objects (e.g. a field has a
      // totally wrong type)
      throw const ApiException('The server sent data in an unexpected format.');
    }
  }
}
