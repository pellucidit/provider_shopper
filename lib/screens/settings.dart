import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/footer.dart';
import '../models/device.dart';

class Settings extends ConsumerWidget{
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(deviceProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
              color: ref.read(deviceProvider.notifier).getThemeAsColor(),
              child: const Text('Settings'),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Insert a color here',
                labelText: 'Color',
            ),
                onChanged: (value) {
                  if (value.isEmpty || value.length != 6) return;
                  ref.read(deviceProvider.notifier).setTheme(value);
                },
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}