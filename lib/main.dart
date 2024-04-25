import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({
    super.key,
  });

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';

  void _handleButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _input = _calculateResult();
      } else if (buttonText == 'AC') {
        _input = '';
      } else if (buttonText == '√') {
        _input = _calculateSquareRoot();
      } else if (buttonText == 'sin') {
        _input = 'sin($_input)';
      } else if (buttonText == 'cos') {
        _input = 'cos($_input)';
      } else if (buttonText == 'tan') {
        _input = 'tan($_input)';
      } else if (buttonText == 'ln') {
        _input = 'ln($_input)';
      } else if (buttonText == 'log') {
        _input = 'log($_input)';
      } else if (buttonText == 'π') {
        _input = '3.14159'; // Value of Pi
      } else if (buttonText == 'x!') {
        _input = '($_input)!';
      } else if (buttonText == 'x^y') {
        _input = '$_input^';
      } else {
        _input += buttonText;
      }
    });
  }

  String _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      if (result.isNaN) {
        return 'Error';
      }
      return result.toStringAsFixed(2); // Format result to two decimal places
    } catch (e) {
      return 'Error';
    }
  }

  String _calculateSquareRoot() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('sqrt($_input)');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      if (result.isNaN) {
        return 'Error';
      }
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  _buildButtonRow(['AC', '√', 'sin', 'cos']),
                  _buildButtonRow(['7', '8', '9', 'tan']),
                  _buildButtonRow(['4', '5', '6', '-']),
                  _buildButtonRow(['1', '2', '3', '+']),
                  _buildButtonRow(['0', '.', '=']),
                  _buildButtonRow(['%', 'x!', 'ln', 'log']),
                  _buildButtonRow(['π', 'x^y', '/', '*']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonLabels) {
    return Expanded(
      child: Row(
        children: buttonLabels
            .map((label) => Expanded(child: _buildButton(label)))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => _handleButtonPressed(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(135, 255, 255, 255)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    ),
  );
}
