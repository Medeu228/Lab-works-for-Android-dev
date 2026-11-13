import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/product.dart';

/// Opens a bottom sheet with the product's deep link and a Copy button.
Future<void> showShareLinkSheet(BuildContext context, Product product) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => _ShareLinkSheet(product: product),
  );
}

class _ShareLinkSheet extends StatelessWidget {
  const _ShareLinkSheet({required this.product});

  final Product product;

  String get _deepLink => 'narxoz://store/product/${product.id}';

  Future<void> _copy(BuildContext context) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: _deepLink));
    navigator.pop();
    messenger.showSnackBar(
      const SnackBar(content: Text('Link copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Share product',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SelectableText(
                      _deepLink,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _copy(context),
              icon: const Icon(Icons.copy),
              label: const Text('Copy link'),
            ),
          ],
        ),
      ),
    );
  }
}
