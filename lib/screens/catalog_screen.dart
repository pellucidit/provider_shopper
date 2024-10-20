// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_shopper/common/shopping_cart_button.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/models/device.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CatalogScreenAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _CatalogScreenAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleColor = ref.watch(deviceProvider).color;
    return SliverAppBar(
      title: Text(
        'Catalog',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: titleColor, // Use the color from the device state
            ),
      ),
      floating: true,
      actions: [
        ShoppingCartButton(),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => context.go('/settings'),
        ),
      ],
    );
  }
}

class _CartItemActionButton extends ConsumerWidget {
  final Item item;

  const _CartItemActionButton({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch if the item is in the cart
    final isItemInCart = ref.watch(cartProvider.notifier).isInCart(item);
    void removeItem() {
      ref.read(cartProvider.notifier).remove(item);
    }

    void addItem() {
      ref.read(cartProvider.notifier).add(item);
    }

    return TextButton(
      onPressed: isItemInCart ? removeItem : addItem,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isItemInCart
          ? const Icon(Icons.remove_circle_outline, semanticLabel: 'REMOVE')
          : const Text('ADD'),
    );
  }
}

class _MyListItem extends ConsumerWidget {
  final int index;
  const _MyListItem(this.index);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartProvider);
    final item = ref.read(catalogProvider.notifier).getByPosition(index);

    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _CartItemActionButton(item: item),
          ],
        ),
      ),
    );
  }
}
