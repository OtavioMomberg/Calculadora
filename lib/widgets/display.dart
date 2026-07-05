import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modern_calculator/services/calculation_services.dart';
import 'package:modern_calculator/themes/app_themes.dart';

class Display extends StatelessWidget {
  final String result;
  final VoidCallback setStateCallback;
  final VoidCallback onPressed;
  final AppThemes appThemes = AppThemes.instance();
  final CalculationServices calculationServices = CalculationServices.instance();

  Display({
    required this.result, 
    required this.setStateCallback,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (context, cadidateItens, _) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            color: appThemes.color2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                width: 1,
                color: appThemes.color1,
              )
            ),
            elevation: 10,
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: .center,
                  children: <Widget>[
                    IconButton(
                      onPressed: onPressed, 
                      icon: Icon(
                        appThemes.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                        color: appThemes.color3,
                      )
                    )
                  ]
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(color: appThemes.color3),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  child: AutoSizeText(
                    result,
                    minFontSize: 15,
                    maxFontSize: 45,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                      color: appThemes.color3,
                      fontSize: 40
                    )
                  )
                )
              ]
            )
          )
        );
      },
      onAcceptWithDetails: (details) {
        calculationServices.buttonsFunction(index: details.data);
        setStateCallback();
      }
    );
  }
}
