import 'package:flutter/material.dart';

class MeasureButton extends StatelessWidget {
  final Function onPressed;
  final List<Color> colors;
  final Widget child;

  MeasureButton({
    @required this.onPressed,
    @required this.colors,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 0.0),
      child: MaterialButton(
        elevation: 6.5,
        onPressed: onPressed,
        color: Colors.black38, // overlay
        padding: EdgeInsets.all(0.0),
        splashColor: Color(0xFF0D47A1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.75),
          alignment: Alignment.center,
          child: child,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: colors,
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
