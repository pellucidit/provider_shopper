import 'package:dio/dio.dart';
import 'package:provider_shopper/models/catalog.dart';

class ItemAccess {
  ItemAccess({required this.client});

  final Dio client;

  Future<List<Item>> getItems() async {
    final url = "https://dummyjson.com/products";

    final Response response = await client.get(url);
    if (response.statusCode != 200) { return [];  }

    List<Item> items = (response.data['products'] as List)
        .map((item) => Item(item['id'] as int, item['title'] as String))
        .toList();
    return items;
  }
}