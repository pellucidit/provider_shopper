import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingField extends ConsumerStatefulWidget {
  final String labelText;
  final String hintText;
  final String initialValue;
  final ValueSetter<String> onSave;
  final VoidCallback onClear;
  final String? Function(String)? validator;

  const SettingField({
    required this.labelText,
    required this.hintText,
    required this.initialValue,
    required this.onSave,
    required this.onClear,
    this.validator,
    super.key,
  });

  @override
  _SettingFieldState createState() => _SettingFieldState();
}

class _SettingFieldState extends ConsumerState<SettingField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: widget.onClear,
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            final value = _controller.text;
            if (widget.validator != null) {
              final error = widget.validator!(value);
              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
                return;
              }
            }
            widget.onSave(value);
          },
        ),
      ],
    );
  }
}
