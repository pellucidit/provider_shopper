import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});
  
  @override 
  Widget build(BuildContext context, WidgetRef ref) {

    Device device = ref.watch(deviceProvider);

    return Card(
      color: device.getThemeAsColor(),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Footer'),
      ),
    );
  }

}