import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final List<String> children;
  final Function onChange;
  final int value;

  final Color activeColor;
  final Color defaultColor;

  ToggleSwitch({
    Key key,
    this.children,
    this.onChange,
    this.value,
    this.activeColor = Colors.blue,
    this.defaultColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlatButton> childrenList = List(children.length);

    for (int i = 0; i < childrenList.length; i++) {
      ShapeBorder shape;

      if (i == 0) {
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
          side: BorderSide(
            color: activeColor,
          ),
        );
      } else if (i == children.length - 1) {
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
          side: BorderSide(
            color: activeColor,
          ),
        );
      } else {
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(
            color: activeColor,
          ),
        );
      }

      childrenList[i] = FlatButton(
        onPressed: () {
          onChange(i);
        },
        child: Text(
          children[i],
          style: TextStyle(
            color: i == value ? defaultColor : activeColor,
          ),
        ),
        color: i == value ? activeColor : defaultColor,
        shape: shape,
      );
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: childrenList,
      ),
    );
  }
}
