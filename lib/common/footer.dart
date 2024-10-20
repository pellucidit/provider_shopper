import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_shopper/models/device.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(deviceProvider);

    return Card(
      color: user.color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(user.name),
      ),
    );
  }
}
