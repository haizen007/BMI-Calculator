import 'package:flutter/material.dart';

class MeasureContent extends StatelessWidget {
  final Function onPressed;
  final List<Color> measureColor;
  final Widget measureChild;

  MeasureContent({
    @required this.onPressed,
    @required this.measureColor,
    @required this.measureChild,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 0.0),
      child: RaisedButton(
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
          child: measureChild,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: measureColor,
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}

/**
 * to change back from RaisedButton to GestureDetector
 */
// @override
// Widget build(BuildContext context) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       alignment: Alignment.center,
//       child: measureChild,
//       margin: EdgeInsets.symmetric(horizontal: 12.5),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         // color: measureColor,
//         borderRadius: BorderRadius.circular(5),
//         gradient: LinearGradient(
//           colors: measureColor,
//         ),
//       ),
//     ),
//   );
// }
