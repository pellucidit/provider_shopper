import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_shopper/common/setting_field.dart';
import 'package:provider_shopper/common/shopping_cart_button.dart';
import 'package:provider_shopper/models/device.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _SettingsScreenAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            _NameSetting(),
            const SizedBox(height: 20),
            _ColorSetting(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SettingsScreenAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleColor = ref.watch(deviceProvider).color;
    return AppBar(
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: titleColor, // Use the color from the device state
            ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.go('/catalog'),
        ),
        ShoppingCartButton(),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => context.go('/login'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ColorSetting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(deviceProvider).color;
    final hexColor = color.value.toRadixString(16).substring(2).toUpperCase();

    return SettingField(
      labelText: 'Color',
      hintText: 'Insert a hex color here (e.g., FF5733)',
      initialValue: hexColor,
      onSave: (value) {
        if (value.isEmpty || value.length != 6) return;
        // Try parsing the hex string into a Color object
        try {
          final hexColor = int.parse(value, radix: 16);
          final color =
              Color(0xFF000000 | hexColor); // Prepend 0xFF for full opacity
          ref.read(deviceProvider.notifier).setThemeColor(color);
        } catch (e) {
          // Handle invalid hex value here
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid hex value.')));
        }
      },
      onClear: () {
        ref.read(deviceProvider.notifier).setThemeColor(Color(0xFF000000));
      },
      validator: (value) {
        if (value.length != 6) {
          return 'Please enter a valid 6-character hex color';
        }
        return null;
      },
    );
  }
}

class _NameSetting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentName = ref.watch(deviceProvider).name;
    return SettingField(
      labelText: 'Name',
      hintText: 'Update your name.',
      initialValue: currentName,
      onSave: (value) {
        ref.read(deviceProvider.notifier).setName(value);
      },
      onClear: () {
        ref.read(deviceProvider.notifier).setName("");
      },
      validator: (value) {
        if (value.isEmpty || value.length > 16) {
          return 'Please enter a maximum of 16 characters.';
        }
        return null;
      },
    );
  }
}
