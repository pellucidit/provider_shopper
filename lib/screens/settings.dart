import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/footer.dart';
import '../models/device.dart';

class Settings extends ConsumerWidget{
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Device device = ref.watch(deviceProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
              color: device.getThemeAsColor(),
              child: const Text('Settings'),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Insert a color here',
                labelText: 'Color',
            ),
                onChanged: (value) {
                  print(value);
                  if (value.isEmpty || value.length != 6) return;
                  print("Changing theme to $value");
                  ref.read(deviceProvider).setTheme(value);
                },
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}