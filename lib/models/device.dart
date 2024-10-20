import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device.g.dart';

@Riverpod(keepAlive: true)
class Device extends _$Device {
  late User _user;

  @override
  User build() {
    _user = User("", Color.fromARGB(255, 0, 0, 0));
    return _user;
  }

  Color get color => _user.color;
  String get name => _user.name;

  void setName(String name) {
    _user = _user.copyWith(name: name);
    state = _user; // Update the state
  }

  void setThemeColor(Color newColor) {
    _user = _user.copyWith(color: newColor);
    state = _user; // Update the state
  }
}

class User {
  String name;
  Color color;
  User(this.name, this.color);

  User copyWith({String? name, Color? color}) {
    return User(
      name ?? this.name,
      color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is User && other.name == name && other.color == color;

  @override
  int get hashCode => name.hashCode ^ color.hashCode;
}
