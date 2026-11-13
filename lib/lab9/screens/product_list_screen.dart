import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_api.dart';
import '../widgets/error_view.dart';
import '../widgets/product_tile.dart';
import 'product_detail_screen.dart';

/// The 3 UI states of the screen.
enum LoadState { loading, success, error }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _api = ProductApi();

  LoadState _state = LoadState.loading;
  List<Product> _products = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  /// First load and the "Retry Connection" button:
  /// spinner -> list, or spinner -> error screen.
  Future<void> _loadProducts() async {
    if (_state != LoadState.loading) {
      setState(() => _state = LoadState.loading);
    }
    try {
      final products = await _api.fetchProducts();
      if (!mounted) return;
      setState(() {
        _products = products;
        _state = LoadState.success;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _state = LoadState.error;
      });
    }
  }

  /// Pull-to-refresh: keeps the old list on screen while loading.
  /// If the refresh fails, the list stays and a SnackBar explains why.
  Future<void> _refresh() async {
    try {
      final products = await _api.fetchProducts();
      if (!mounted) return;
      setState(() => _products = products);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Refresh failed: ${e.message}')));
    }
  }

  void _openDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Product Explorer'),
        actions: [
          if (_state == LoadState.success)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(child: Text('${_products.length} items')),
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return switch (_state) {
      LoadState.loading => const Center(child: CircularProgressIndicator()),
      LoadState.error => ErrorView(
        message: _errorMessage,
        onRetry: _loadProducts,
      ),
      LoadState.success => RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _products.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 1, indent: 100),
          itemBuilder: (context, index) {
            final product = _products[index];
            return ProductTile(
              product: product,
              onTap: () => _openDetail(product),
            );
          },
        ),
      ),
    };
  }
}
