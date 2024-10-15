import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';


part 'device.g.dart';

@riverpod
Device device(DeviceRef ref) => Device(theme: "32332A");

class Device {
  Device({required this.theme});
  
  String theme;

  void setTheme(String theme) {
    this.theme = theme;
  }

  Color getThemeAsColor() {
    Color color = Color(int.parse(theme, radix: 16));
    print(color);
    return color;
  }
}