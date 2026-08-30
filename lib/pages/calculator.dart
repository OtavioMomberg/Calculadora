import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: appThemes.color1,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: false,
          statusBarColor: appThemes.color1,
          statusBarIconBrightness: appThemes.isDarkTheme ? .light : .dark,
          systemNavigationBarContrastEnforced: false,
          systemNavigationBarColor: appThemes.color6,
          systemNavigationBarIconBrightness: appThemes.isDarkTheme ? .light : .dark
        ),
      ),
      backgroundColor: appThemes.color6,
      body: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: appThemes.isDarkTheme 
              ? AppThemes.darkGradient 
              : AppThemes.lightGradient
          ),
          child: Column(
            spacing: 10,
            children: <Widget>[
              Flexible(
                child: Display(
                  result: _calculationServices.result,
                  setStateCallback: _setStateCallback,
                  onPressed: _changeAppTheme
                )
              ),
              Flexible(
                flex: 2,
                child: ButtonGrid(
                  caracters: _calculationServices.caracters,
                  onTapButton: _callCalculationService
                )
              )
            ]
          )
        )
      )
    );
  }

  void _callCalculationService({required int index}) {
    _calculationServices.buttonsFunction(index: index);
    setState(() => ());
  }

  Future<void> _changeAppTheme() async {
    await appThemes.changeTheme();
    setState(() => ());
  }

  void _setStateCallback() => setState(() => ());
}