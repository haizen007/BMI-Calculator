import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double thumbShape;
  final double overlayShape;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Function onChanged;

  CustomSlider({
    @required this.value,
    @required this.min,
    @required this.max,
    @required this.divisions,
    @required this.thumbShape,
    @required this.overlayShape,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbColor: Color(0xFFEB1555),
        inactiveTrackColor: Color(0xFF8D8E98),
        activeTrackColor: Color(0xFFEB1555),
        overlayColor: Color(0x29EB1555),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: thumbShape),
        overlayShape: RoundSliderOverlayShape(overlayRadius: overlayShape),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        // activeColor: Color(0xFFEB1555),
        onChanged: onChanged,
      ),
    );
  }
}
