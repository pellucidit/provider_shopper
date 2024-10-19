// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/device.dart';


class MyLogin extends ConsumerWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: ref.read(deviceProvider.notifier).getThemeAsColor(),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {context.pushReplacement('/settings');})
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushReplacement('/catalog');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text('ENTER'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
