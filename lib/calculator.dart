import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number = "0";
  double firstNumber = 0;
  String operator = "";

  // =========================
  // NUMBER
  // =========================

  void numberButton(String value) {
    setState(() {
      if (number == "0" || number == "Error") {
        number = value;
      } else {
        number += value;
      }
    });
  }

  // =========================
  // DECIMAL
  // =========================

  void decimal() {
    setState(() {
      if (!number.contains(".")) {
        number += ".";
      }
    });
  }

  // =========================
  // OPERATOR
  // =========================

  void operation(String op) {
    setState(() {
      firstNumber = double.tryParse(number) ?? 0;
      operator = op;
      number = "0";
    });
  }

  // =========================
  // EQUAL
  // =========================

  void equal() {
    setState(() {
      double secondNumber = double.tryParse(number) ?? 0;
      double result = 0;

      if (operator == "+") {
        result = firstNumber + secondNumber;
      } else if (operator == "-") {
        result = firstNumber - secondNumber;
      } else if (operator == "×") {
        result = firstNumber * secondNumber;
      } else if (operator == "÷") {
        if (secondNumber == 0) {
          number = "Error";
          return;
        }

        result = firstNumber / secondNumber;
      }

      number = result.toString();

      if (number.endsWith(".0")) {
        number = number.substring(0, number.length - 2);
      }

      operator = "";
    });
  }

  // =========================
  // CLEAR
  // =========================

  void clear() {
    setState(() {
      number = "0";
      firstNumber = 0;
      operator = "";
    });
  }

  // =========================
  // CE
  // =========================

  void clearEntry() {
    setState(() {
      number = "0";
    });
  }

  // =========================
  // BACKSPACE
  // =========================

  void backspace() {
    setState(() {
      if (number.length > 1) {
        number = number.substring(0, number.length - 1);
      } else {
        number = "0";
      }
    });
  }

  // =========================
  // PERCENTAGE
  // =========================

  void percentage() {
    setState(() {
      double value = double.tryParse(number) ?? 0;

      value = value / 100;

      number = value.toString();

      if (number.endsWith(".0")) {
        number = number.substring(0, number.length - 2);
      }
    });
  }

  // =========================
  // PLUS MINUS
  // =========================

  void plusMinus() {
    setState(() {
      double value = double.tryParse(number) ?? 0;

      value = -value;

      number = value.toString();

      if (number.endsWith(".0")) {
        number = number.substring(0, number.length - 2);
      }
    });
  }

  // =========================
  // SQUARE
  // =========================

  void square() {
    setState(() {
      double value = double.tryParse(number) ?? 0;

      value = value * value;

      number = value.toString();

      if (number.endsWith(".0")) {
        number = number.substring(0, number.length - 2);
      }
    });
  }

  // =========================
  // SQUARE ROOT
  // =========================

  void squareRoot() {
    setState(() {
      double value = double.tryParse(number) ?? 0;

      if (value < 0) {
        number = "Error";
      } else {
        value = sqrt(value);

        number = value.toString();

        if (number.endsWith(".0")) {
          number = number.substring(0, number.length - 2);
        }
      }
    });
  }

  // =========================
  // RECIPROCAL
  // =========================

  void reciprocal() {
    setState(() {
      double value = double.tryParse(number) ?? 0;

      if (value == 0) {
        number = "Error";
      } else {
        value = 1 / value;

        number = value.toString();

        if (number.endsWith(".0")) {
          number = number.substring(0, number.length - 2);
        }
      }
    });
  }

  // =========================
  // NORMAL BUTTON
  // =========================

  Widget calculatorButton(
      String text,
      VoidCallback function,
      double height,
      ) {
    return Expanded(
      child: Container(
        height: height,
        margin: const EdgeInsets.all(2),
        child: ElevatedButton(
          onPressed: function,

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff383838),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.zero,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          child: FittedBox(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // EQUAL BUTTON
  // =========================

  Widget equalButton(double height) {
    return Expanded(
      child: Container(
        height: height,
        margin: const EdgeInsets.all(2),

        child: ElevatedButton(
          onPressed: equal,

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffd88ce5),
            foregroundColor: Colors.black,
            elevation: 0,
            padding: EdgeInsets.zero,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          child: const Text(
            "=",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // MEMORY BUTTON
  // =========================

  Widget memoryButton(String text) {
    return Expanded(
      child: TextButton(
        onPressed: () {},

        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),

        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // BUTTON ROW
  // =========================

  Widget buttonRow(
      List<Widget> buttons,
      double height,
      ) {
    return SizedBox(
      height: height,
      child: Row(
        children: buttons,
      ),
    );
  }

  // =========================
  // MAIN UI
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            // Screen ni height pramane
            // button height automatic calculate thase.
            double screenHeight = constraints.maxHeight;

            double displayHeight = screenHeight * 0.14;

            double memoryHeight = screenHeight * 0.06;

            double rowHeight = screenHeight * 0.095;

            return Column(
              children: [

                // =========================
                // DISPLAY
                // =========================

                SizedBox(
                  height: displayHeight,

                  child: Container(
                    width: double.infinity,

                    margin: const EdgeInsets.all(2),

                    padding: const EdgeInsets.only(
                      right: 12,
                    ),

                    alignment: Alignment.centerRight,

                    decoration: BoxDecoration(
                      color: const Color(0xff202020),

                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),

                      borderRadius:
                      BorderRadius.circular(6),
                    ),

                    child: FittedBox(
                      child: Text(
                        number,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.065,
                        ),
                      ),
                    ),
                  ),
                ),

                // =========================
                // MEMORY
                // =========================

                SizedBox(
                  height: memoryHeight,

                  child: Row(
                    children: [
                      memoryButton("MC"),
                      memoryButton("MR"),
                      memoryButton("M+"),
                      memoryButton("M−"),
                      memoryButton("MS"),
                      memoryButton("M⌄"),
                    ],
                  ),
                ),

                // =========================
                // EMPTY SPACE
                // =========================

                const Spacer(),

                // =========================
                // ROW 1
                // =========================

                buttonRow(
                  [
                    calculatorButton(
                      "%",
                      percentage,
                      rowHeight,
                    ),

                    calculatorButton(
                      "CE",
                      clearEntry,
                      rowHeight,
                    ),

                    calculatorButton(
                      "C",
                      clear,
                      rowHeight,
                    ),

                    calculatorButton(
                      "⌫",
                      backspace,
                      rowHeight,
                    ),
                  ],
                  rowHeight,
                ),

                // =========================
                // ROW 2
                // =========================

                buttonRow(
                  [
                    calculatorButton(
                      "¹⁄ₓ",
                      reciprocal,
                      rowHeight,
                    ),

                    calculatorButton(
                      "x²",
                      square,
                      rowHeight,
                    ),

                    calculatorButton(
                      "²√x",
                      squareRoot,
                      rowHeight,
                    ),

                    calculatorButton(
                      "÷",
                          () => operation("÷"),
                      rowHeight,
                    ),
                  ],
                  rowHeight,
                ),

                // =========================
                // ROW 3
                // =========================

                buttonRow(
                  [
                    calculatorButton(
                      "7",
                          () => numberButton("7"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "8",
                          () => numberButton("8"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "9",
                          () => numberButton("9"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "×",
                          () => operation("×"),
                      rowHeight,
                    ),
                  ],
                  rowHeight,
                ),

                // =========================
                // ROW 4
                // =========================

                buttonRow(
                  [
                    calculatorButton(
                      "4",
                          () => numberButton("4"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "5",
                          () => numberButton("5"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "6",
                          () => numberButton("6"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "−",
                          () => operation("-"),
                      rowHeight,
                    ),
                  ],
                  rowHeight,
                ),

                // =========================
                // ROW 5
                // =========================

                buttonRow(
                  [
                    calculatorButton(
                      "1",
                          () => numberButton("1"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "2",
                          () => numberButton("2"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "3",
                          () => numberButton("3"),
                      rowHeight,
                    ),

                    calculatorButton(
                      "+",
                          () => operation("+"),
                      rowHeight,
                    ),
                  ],
                  rowHeight,
                ),

                // =========================
                // ROW 6
                // =========================

                buttonRow(
                  [
                    calculatorButton(
                      "+/−",
                      plusMinus,
                      rowHeight,
                    ),

                    calculatorButton(
                      "0",
                          () => numberButton("0"),
                      rowHeight,
                    ),

                    calculatorButton(
                      ".",
                      decimal,
                      rowHeight,
                    ),

                    equalButton(rowHeight),
                  ],
                  rowHeight,
                ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}