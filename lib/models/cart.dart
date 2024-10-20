// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:provider_shopper/models/catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart.g.dart';

@riverpod
class Cart extends _$Cart {
  late Catalog _catalog;
  final List<int> _itemIds = [];

  @override
  List<Item> build() {
    _catalog = ref.watch(catalogProvider.notifier);
    return _itemIds.map((id) => _catalog.getById(id)).toList();
  }

  /// If CartState is in use
  /*
  @override
  CartState build() {
    _catalog = ref.watch(catalogProvider.notifier);
    final items = _itemIds.map((id) => _catalog.getById(id)).toList();
    return CartState(items: items);
  }

  set catalog(Catalog newCatalog) {
    _catalog = newCatalog;
    final items = _itemIds.map((id) => _catalog.getById(id)).toList();
    state = CartState(items: items);
  }
  void add(Item item) {
    _itemIds.add(item.id);
    final items = _itemIds.map((id) => _catalog.getById(id)).toList();
    state = CartState(items: items);
  }
  void remove(Item item) {
    _itemIds.remove(item.id);
    final items = _itemIds.map((id) => _catalog.getById(id)).toList();
    state = CartState(items: items);
  }
  */

  /// The current catalog. Used to construct items from numeric ids.
  Catalog get catalog => _catalog;

  set catalog(Catalog newCatalog) {
    _catalog = newCatalog;
    state = _itemIds.map((id) => _catalog.getById(id)).toList();
  }

  /// List of items in the cart.
  List<Item> get items => state;

  /// List count of items in the cart.
  int get count => items.length;

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Checks if [item] is in the cart
  bool isInCart(Item item) {
    return items.contains(item);
  }

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _itemIds.add(item.id);
    state = _itemIds.map((id) => _catalog.getById(id)).toList();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    state = _itemIds.map((id) => _catalog.getById(id)).toList();
  }
}

/// Todo Consider adding CartState
class CartState {
  final List<Item> items;
  final int count;

  CartState({required this.items}) : count = items.length;
}
