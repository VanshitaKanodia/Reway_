import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customButton({onPress, color, textColor, String? title, shape}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shape,
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).bold.make());
}
