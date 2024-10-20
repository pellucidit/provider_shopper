// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider_shopper/common/client.dart';
import 'package:provider_shopper/common/fake_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalog.g.dart';

@riverpod
class Catalog extends _$Catalog {
  List<String> itemNames = [
    'Orange',
    'Guava',
    'Banana',
    'Apple',
    'Pear',
  ];

  // final targetClient = Dio();
  final targetClient = FakeDio();

  @override
  List<Item> build() {
    return List.generate(itemNames.length, (index) => getById(index));
  }

  /// Get item by [id].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    return getById(position);
  }

  Future<void> refresh() async {
    List<Item> items = await ItemAccess(client: targetClient).getItems();
    if (items.isEmpty) {
      return;
    }
    itemNames = items.map((item) => item.name).toList();
    state = List.generate(itemNames.length, (index) => getById(index));
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 10;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
