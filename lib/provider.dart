import 'package:riverpod_annotation/riverpod_annotation.dart';
import './models/cart.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
CartModel cartModel(CartModelRef ref) => CartModel();