// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/device.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleColor = ref.watch(deviceProvider).color;
    final name = ref.watch(deviceProvider).name;
    return Scaffold(
      appBar: AppBar(
        title: Text('$name Cart',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: titleColor, // Use the color from the device state
                )),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    var cart = ref.watch(cartModelProvider);

    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            ref.read(cartModelProvider.notifier).remove(cart[index]);
          },
        ),
        title: Text(
          cart[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hugeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);
    // Watch the cart state to trigger a rebuild when the cart changes
    ref.watch(cartModelProvider);
    // Get total price from the CartModel, which encapsulates the logic
    final totalPrice = ref.read(cartModelProvider.notifier).totalPrice;

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\$$totalPrice', style: hugeStyle),
            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
