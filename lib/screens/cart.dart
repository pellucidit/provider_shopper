// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_shopper/models/cart.dart';
import '../models/device.dart';

class MyCart extends ConsumerWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: ref.read(deviceProvider.notifier).getThemeAsColor(),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {context.pushReplacement('/settings');}),
          IconButton(icon: const Icon(Icons.store), onPressed: () {context.pushReplacement('/catalog');})
        ],
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
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    
    CartModel cart = ref.watch(cartModelProvider.notifier);
    
    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            cart.remove(cart.items[index]);
          },
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Another way to listen to a model's change is to include
            // the Consumer widget. This widget will automatically listen
            // to CartModel and rerun its builder on every change.
            //
            // The important thing is that it will not rebuild
            // the rest of the widgets in this build method.
            Consumer(
                builder: (context, ref, child) {
                    final cart = ref.watch(cartModelProvider.notifier);
                    return Text('\$${cart.totalPrice}', style: hugeStyle);
                },
            ),
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
