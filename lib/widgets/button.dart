import 'package:flutter/material.dart';
import 'package:modern_calculator/themes/app_themes.dart';

class Button extends StatelessWidget {
  final String text;
  final bool check;
  final void Function()? onTap;
  final AppThemes appThemes = AppThemes.instance();

  Button({
    required this.text,
    required this.check,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: appThemes.color2,
      shadowColor: appThemes.color1,
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        splashColor: appThemes.color5,
        highlightColor: appThemes.color5,
        onTap: () {
          if (onTap == null) { return; }
          onTap!();
        },
        child: SizedBox.square(
          dimension: 100,
          child: Card(
            color: appThemes.color2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                width: 2,
                color: appThemes.color1
              )
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: check
                    ? appThemes.color3
                    : appThemes.color4,
                  fontSize: text == "=" ? 35 : 25
                )
              )
            )
          )
        )
      )
    );
  }
}
