import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';


part 'device.g.dart';

@Riverpod(keepAlive: true)
class Device extends _$Device {

  @override
  Color build() { 
    return Color(int.parse("FFffffff", radix: 16));
  }

  void setTheme(String theme) {
    state = Color(int.parse("ff$theme", radix: 16));
    print("Changed theme to $theme");
  }

  Color getThemeAsColor() {
    print("theme is $state");
    return state;
  }
}