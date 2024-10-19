// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:provider_shopper/models/catalog.dart';
// import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart.g.dart';

@riverpod
class CartModel extends _$CartModel {
  late CatalogModel _catalog;
  final List<int> _itemIds = [];

  @override
  List<Item> build() {
    return _itemIds.map((id) => _catalog.getById(id)).toList();
  }

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    state = _itemIds.map((id) => _catalog.getById(id)).toList();
  }

  /// List of items in the cart.
  List<Item> get items => state;

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

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
