class Caracter({
  required final String caracter, 
  required final bool isNumber
});

class Caracters {
  static final buttons = [
    Caracter(caracter: "AC", isNumber: false),
    Caracter(caracter: "⌫", isNumber: false),
    Caracter(caracter: "%", isNumber: false),
    Caracter(caracter: "/", isNumber: false),
    Caracter(caracter: "7", isNumber: true),
    Caracter(caracter: "8", isNumber: true),
    Caracter(caracter: "9", isNumber: true),
    Caracter(caracter: "x", isNumber: false),
    Caracter(caracter: "4", isNumber: true),
    Caracter(caracter: "5", isNumber: true),
    Caracter(caracter: "6", isNumber: true),
    Caracter(caracter: "-", isNumber: false),
    Caracter(caracter: "1", isNumber: true),
    Caracter(caracter: "2", isNumber: true),
    Caracter(caracter: "3", isNumber: true),
    Caracter(caracter: "+", isNumber: false),
    Caracter(caracter: "NC", isNumber: false),
    Caracter(caracter: "0", isNumber: true),
    Caracter(caracter: ".", isNumber: false),
    Caracter(caracter: "=", isNumber: false)
  ];

  static const operatorsList = ["+", "-", "x", "/"];
}
