import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_shopper/models/cart.dart';

class ShoppingCartButton extends ConsumerWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartProvider);
    final cartItemCount = ref.watch(cartProvider.notifier).count;
    return Badge.count(
      count: cartItemCount, // The count to display in the badge
      alignment: Alignment.topCenter, // Positioning of the badge
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () => context.go('/catalog/cart'),
      ),
    );
  }
}
