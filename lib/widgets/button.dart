import 'package:flutter/material.dart';
import 'package:modern_calculator/themes/app_themes.dart';

class Button extends StatelessWidget {
  final String text;
  final bool check;
  final void Function() onTap;
  final AppThemes appThemes = AppThemes.instance();

  Button({
    required this.text,
    required this.check,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: appThemes.color2,
      shadowColor: appThemes.color2.withValues(alpha: 0.8),
      elevation: 10,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        splashColor: appThemes.color5,
        highlightColor: appThemes.color5,
        onTap: onTap,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Card(
            elevation: 1,
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
