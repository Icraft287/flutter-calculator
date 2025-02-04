import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        expression = "";
        result = "";
      } else if (value == "=") {
        try {
          Expression exp = Expression.parse(expression);
          final evaluator = const ExpressionEvaluator();
          var evalResult = evaluator.eval(exp, {});
          result = evalResult.toString();
          expression += " = $result";
        } catch (e) {
          result = "Error - Clear";
        }
      } else {
        expression += value;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onButtonPressed(text),
        child: Text(text, style: TextStyle(fontSize: 28)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.centerRight,
              child: Text(expression, style: TextStyle(fontSize: 44)),
            ),
          ),
          Row(children: [
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildButton("/")
          ]),
          Row(children: [
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildButton("*")
          ]),
          Row(children: [
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildButton("-")
          ]),
          Row(children: [
            buildButton("C"),
            buildButton("0"),
            buildButton("="),
            buildButton("+")
          ]),
           Row(children: [buildButton("^2"), buildButton("%")]),
        ],
      ),
    );
  }
}
