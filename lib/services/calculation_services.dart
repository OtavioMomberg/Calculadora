import 'dart:math';
import 'package:modern_calculator/models/caracteres.dart';

const subtractionSignal = "—";

class CalculationServices {
  final caracters = Caracters.buttons;
  final operators = Caracters.operatorsList;
  static const decimalCases = 2;
  List<String> listaOperadores = [];
  String result = "0";

  static final _instance = CalculationServices._();
  factory CalculationServices.instance() => _instance;
  CalculationServices._();

  void buttonsFunction({required int index}) {
    final char = caracters[index].caracter;
    List<String> number = result.split(RegExp(r"[+\-\x\/]"));
    if (number.length == 1 && number[0] == "0") number[0] = "";

    if (char == "AC") {
      result = "0";
      return;
    }

    if (char == "⌫") {
      result.length - 1 > 0
        ? result = result.substring(0, result.length - 1)
        : result = "0";
      return;
    }

    if (char == "NC") {
      _scientificNotation(number: number);
      return;
    }

    if (!_validations(index: index, char: char)) { return; }

    if (char != "=" && char != "%") { result += char; }

    if (result[0] == "-" && result.length == 2) { 
      _switchSignal(option: 0); 
    } else {
      _switchSignal(option: 1);
    }

    if (char == "%") {
      _percentage(number: number);
      return;
    }

    if (char == "=" && !result.contains("^")) {
      _doCalculation(numbers: number);
      result = number.first;
      if (result.startsWith("-")) { _switchSignal(option: 0); } 
    } else if (result.contains("^")) {
      result = "0";
    }
  }

  void _scientificNotation({required List<String> number}) {
    if (result == "0") {
      return;
    }
    if (result.contains("^")) { return; }

    if (result.endsWith(".")) { return; }

    for (int i = 0; i < result.length; i++) {
      if (operators.contains(result[i])) {
        return;
      }
    }

    int numSize;
    List<String> values = result.split(".");

    if (number[0].startsWith("—")) { number = _convertToNegativeNumber(numbers: number); }
    double uniqueNumber = double.parse(number[0]);
    double aux = uniqueNumber;

    values.isNotEmpty
      ? numSize = values[0].length-1
      : numSize = result.length-1;

    uniqueNumber /= pow(10, uniqueNumber >= 1 ? numSize : numSize-1);

    result = "${uniqueNumber.toString()} x 10 ^ ${aux >= 1 ? numSize : numSize-1}";
  }

  bool _checkCaracter({required int index, required String char}) {
    return operators.contains(char) && char != "-" ? true : false;
  }

  bool _validations({required int index, required String char}) {
    if (operators.contains(result[result.length-1]) && char == ".") {
      return false;
    }
    if (result.endsWith("/") && char == "0") {
      return false;
    }
    if (result.endsWith(".") && operators.contains(char)) {
      return false;
    }
    if (result.endsWith("—") && (operators.contains(char))) {
      return false;
    }
    if (result.endsWith("-") && char == "=") {
      return false;
    }

    if ((operators.contains(result[result.length - 1])) &&
        _checkCaracter(index: index, char: char)) {
      result = result.substring(0, result.length - 1);
    }

    if (result[result.length - 1] == "." && char == ".") {
      return false;
    }

    if (result == "0") {
      if (char == "%") {
        return false;
      }
      if (char != "." && ((!operators.contains(char)) || char == "-")) {
        result = "";
      }
    }

    if (result.isNotEmpty) {
      if (result[0] == "-" && char == "-") {
        return false;
      }
    }
    return true;
  }

  void _switchSignal({required int option}) {
    switch (option) {
      case 0: {
        result = result.replaceFirst("-", "—");
        break;
      }
      case 1: {
        for (int i = 0; i < result.length - 1; i++) {
          if (operators.contains(result[i]) && result[i + 1] == "-") {
            if (result[i] == "-") {
              String aux = result.substring(i + 1, result.length);
              aux = aux.replaceFirst("-", "—");
              result = result.substring(0, i + 1) + aux;
              break;
            } else {
              result = result.replaceFirst("-", "—");
            }
          }
        }
        break;
      }
    } 
  }

  void _percentage({required List<String> number}) {
    if (operators.contains(result[result.length - 1])) { return; }
    if (result.endsWith("—")) { return; }
    if (result.endsWith(".")) { return; }

    int size = result.length;
    double partialResult = 0.0;
    number = _convertToNegativeNumber(numbers: number);
    for (int i = size - 1; i >= 0; i--) {
      if (result[i] == "x" || result[i] == "/") { break; }

      if (operators.contains(result[i])) {
        partialResult = double.parse(number[0]) / 100.0 * double.parse(number[number.length - 1]);
        break;
      }
      result = result.substring(0, i);
    }
    if (partialResult > 0.0) {
      result += partialResult.toString();
    } else {
      result += (double.parse(number[number.length - 1]) / 100.0).toString();
    }
  }

  void _doCalculation({required List<String> numbers}) {
    listaOperadores.clear();
    for (int i = 0; i < result.length; i++) {
      if (operators.contains(result[i])) {
        listaOperadores.add(result[i]);
      }
    }

    int index = 0;
    while (listaOperadores.isNotEmpty) {
      bool verificaOrdem = false;
      for (int i = 0; i < listaOperadores.length; i++) {
        if (listaOperadores.contains("x") || listaOperadores.contains("/")) {
          verificaOrdem = true;
          break;
        }
      }
      if (verificaOrdem) {
        if (listaOperadores[index] == "x") {
          numbers = _convertToNegativeNumber(numbers: numbers);
          double aux = (double.parse(numbers[index]) * double.parse(numbers[index + 1]));
          _updateLists(number: numbers, aux: aux, index: index);
          index = 0;
          continue;
        }
        if (listaOperadores[index] == "/") {
          numbers = _convertToNegativeNumber(numbers: numbers);
          double aux = (double.parse(numbers[index]) / double.parse(numbers[index + 1]));
          _updateLists(number: numbers, aux: aux, index: index);
          index = 0;
          continue;
        }
        index += 1;
      } else {
        index = 0;
        if (listaOperadores[index] == "+") {
          numbers = _convertToNegativeNumber(numbers: numbers);
          double aux = (double.parse(numbers[index]) + double.parse(numbers[index+1]));
          _updateLists(number: numbers, aux: aux, index: index);
          continue;
        }
        if (listaOperadores[index] == "-") {
          numbers = _convertToNegativeNumber(numbers: numbers);
          double aux = (double.parse(numbers[index]) - double.parse(numbers[index+1]));
          _updateLists(number: numbers, aux: aux, index: index);
        }
      }
    }
  }

  List<String> _convertToNegativeNumber({required List<String> numbers}) {
    for (int i = 0; i < numbers.length; i++) {
      if (numbers.isNotEmpty && numbers[i].startsWith("—")) {
        numbers[i] = numbers[i].substring(1, numbers[i].length);
        numbers[i] = (double.parse(numbers[i]) * -1).toString();
      }
    }
    return numbers;
  }

  void _updateLists({required List<String> number, required double aux, required int index}) {
    listaOperadores.removeAt(index);
    number.removeAt(index);
    number.removeAt(index);
    number.insert(
      index,
      aux % 1 == 0 ? aux.toInt().toString() : aux.toStringAsFixed(decimalCases),
    );
  }
}