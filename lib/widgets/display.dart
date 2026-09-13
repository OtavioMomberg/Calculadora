import 'package:auto_size_text/auto_size_text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:modern_calculator/services/calculation_service.dart';
import 'package:modern_calculator/core/themes/app_themes.dart';

class Display extends StatelessWidget {
  final String result;
  final VoidCallback setStateCallback;
  final VoidCallback onPressed;
  final AppThemes appThemes;
  final CalculationService calculationServices;

  const new({
    required this.result,
    required this.setStateCallback,
    required this.onPressed,
    required this.appThemes,
    required this.calculationServices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: (context, cadidateItens, _) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            color: appThemes.color2,
            shadowColor: appThemes.color2,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
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
                        appThemes.isDarkTheme
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: appThemes.color3,
                      ),
                    ),
                  ],
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
                    style: TextStyle(color: appThemes.color3, fontSize: 40),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onAcceptWithDetails: (details) {
        calculationServices.buttonsFunction(index: details.data);
        setStateCallback();
      },
    );
  }
}
