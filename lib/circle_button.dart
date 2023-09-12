import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {

  final onTap;
  final double? radius;
  final borderSize;
  final borderColor;
  final foregroundColor;
  final child;


  CircleButton({this.onTap, this.radius, this.borderSize, this.borderColor,
      this.foregroundColor, this.child, super.key});

  @override
  Widget build(BuildContext context) {

    return ClipOval(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          border:  Border.all(color: borderColor, width: borderSize),
          color: foregroundColor,
          shape: BoxShape.circle
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            radius: radius,
            child: child ?? SizedBox(),
            onTap: () async {
              if(onTap != null) {
                onTap();
              }
            },
          ),
        ),
      ),
    );
  }
}