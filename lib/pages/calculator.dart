import 'package:flutter/material.dart';
import 'package:modern_calculator/services/calculation_services.dart';
import 'package:modern_calculator/themes/app_themes.dart';
import 'package:modern_calculator/widgets/button_grid.dart';
import 'package:modern_calculator/widgets/display.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final AppThemes appThemes = AppThemes.instance();
  final CalculationServices _calculationServices = CalculationServices.instance();

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).viewPadding;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appThemes.color1,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0
      ),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: paddingTop.top,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            gradient: appThemes.isDarkTheme ? appThemes.darkGradient : appThemes.lightGradient
          ),
          child: Column(
            spacing: 20,
            children: <Widget>[
              Flexible(
                child: Display(
                  result: _calculationServices.result,
                  setStateCallback: setStateCallback,
                  onPressed: changeAppTheme
                )
              ),
              Flexible(
                flex: 2,
                child: ButtonGrid(
                  caracters: _calculationServices.caracters,
                  onTapButton: callCalculationService
                )
              )
            ]
          )
        )
      )
    );
  }

  void callCalculationService({required int index}) {
    _calculationServices.buttonsFunction(index: index);
    setStateCallback();
  }

  Future<void> changeAppTheme() async {
    await appThemes.changeTheme();
    setStateCallback();
  }

  void setStateCallback() => setState(() => ());
}