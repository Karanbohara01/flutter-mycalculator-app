import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculatorView extends StatefulWidget {
  const MyCalculatorView({super.key});

  @override
  State<MyCalculatorView> createState() => _MyCalculatorViewState();
}

class _MyCalculatorViewState extends State<MyCalculatorView> {
  String input = ""; // Holds the current input
  String result = ""; // Holds the calculated result
  final TextEditingController _controller = TextEditingController();

  // Function to handle button presses
  void buttonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        input = "";
        result = "";
      } else if (symbol == "<-") {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      } else if (symbol == "=") {
        try {
          Parser parser = Parser();
          Expression expression = parser.parse(input);
          result = expression
              .evaluate(EvaluationType.REAL, ContextModel())
              .toString();
          input = result; // Set the result as the next input
        } catch (e) {
          result = "Error";
        }
      } else {
        input += symbol; // Append the symbol to the input
      }
      _controller.text = input; // Update the TextField
    });
  }

  // Calculator buttons
  final List<String> lstSymbols = [
    "C",
    "<-",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Column(
        children: [
          // Display field for input/result
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              readOnly: true,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
          // Buttons grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: lstSymbols.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => buttonPressed(lstSymbols[index]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lstSymbols[index] == "="
                        ? Colors.green
                        : lstSymbols[index] == "C" || lstSymbols[index] == "<-"
                            ? Colors.red
                            : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    lstSymbols[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
