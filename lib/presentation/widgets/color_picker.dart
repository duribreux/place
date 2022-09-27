import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    Key? key,
    required this.color,
    required this.onColorChanged,
  }) : super(key: key);

  final Color color;
  final void Function(Color) onColorChanged;

  @override
  Widget build(BuildContext context) => Flexible(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlockPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
            layoutBuilder: (context, colors, child) => Row(
              children: [for (Color color in colors) child(color)],
            ),
            availableColors: const [
              Colors.red,
              Colors.pink,
              Colors.purple,
              Colors.deepPurple,
              Colors.indigo,
              Colors.blue,
              Colors.lightBlue,
              Colors.cyan,
              Colors.teal,
              Colors.green,
              Colors.lightGreen,
              Colors.lime,
              Colors.yellow,
              Colors.amber,
              Colors.orange,
              Colors.deepOrange,
              Colors.brown,
              Colors.grey,
              Colors.blueGrey,
              Colors.black,
              Colors.white,
            ],
          ),
        ),
      );
}
