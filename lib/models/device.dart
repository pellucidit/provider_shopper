import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';


part 'device.g.dart';

@Riverpod(keepAlive: true)
class Device extends _$Device {
  Color theme = Color(int.parse("FFffffff", radix: 16));

  @override
  Color build() { 
    return theme;
  }

  void setTheme(String theme) {
    try{
      this.theme = Color(int.parse("ff$theme", radix: 16));
    }
    catch(e){
      this.theme = Colors.white;
    }
    
    ref.notifyListeners();
  }

  Color getThemeAsColor() {
    return theme;
  }
}