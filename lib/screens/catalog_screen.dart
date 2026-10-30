import 'dart:math';

import 'package:flutter/material.dart';

import '../data/catalog_data.dart';
import '../models/product.dart';
import '../widgets/delete_background.dart';
import '../widgets/empty_catalog.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/product_list_tile.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> _products = seedProducts();
  final _generator = ProductGenerator();
  bool _isGrid = false;

  // ---------------- actions ----------------

  void _toggleView() {
    setState(() => _isGrid = !_isGrid);
  }

  /// Pull-to-refresh: fake 1.5 s network request, then a new item at index 0.
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return; // the screen may be closed while we waited
    setState(() {
      _products.insert(0, _generator.next());
    });
  }

  /// Swipe-to-delete with UNDO.
  void _removeAt(int index) {
    final removed = _products[index];
    // must be removed from the list right away — a dismissed Dismissible
    // can't stay in the tree
    setState(() => _products.removeAt(index));

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        content: Text('${removed.title} deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            if (!mounted) return;
            setState(() {
              // back to the original index (or the end, if the list got
              // shorter in the meantime)
              final position = min(index, _products.length);
              _products.insert(position, removed);
            });
          },
        ),
      ),
    );
  }

  void _resetCatalog() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      _products
        ..clear()
        ..addAll(seedProducts());
    });
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text('Smart Catalog (${_products.length})'),
        actions: [
          IconButton(
            tooltip: _isGrid ? 'Show as list' : 'Show as grid',
            onPressed: _toggleView,
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
          ),
        ],
      ),
      // RefreshIndicator needs a scrollable child; it works in all
      // three states (list, grid, empty)
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _products.isEmpty
            ? _buildEmpty()
            : _isGrid
            ? _buildGrid()
            : _buildList(),
      ),
    );
  }

  /// List mode: ListView.separated builds rows lazily — only the ones on
  /// screen exist in memory, unlike a Column that builds all of them.
  Widget _buildList() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _products.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 0.5, indent: 76),
      itemBuilder: (context, index) {
        final product = _products[index];
        return Dismissible(
          key: ValueKey(product.id),
          direction: DismissDirection.endToStart, // right-to-left only
          background: const DeleteBackground(),
          onDismissed: (_) => _removeAt(index),
          child: ProductListTile(product: product),
        );
      },
    );
  }

  /// Grid mode: 2 columns, each cell 0.72 × as tall as wide.
  Widget _buildGrid() {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Dismissible(
          key: ValueKey(product.id),
          direction: DismissDirection.endToStart,
          background: const DeleteBackground(borderRadius: 16),
          onDismissed: (_) => _removeAt(index),
          child: ProductGridCard(product: product),
        );
      },
    );
  }

  /// Empty state inside a scrollable, so pull-to-refresh still works.
  Widget _buildEmpty() {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(child: EmptyCatalog(onReset: _resetCatalog)),
        ),
      ),
    );
  }
}
