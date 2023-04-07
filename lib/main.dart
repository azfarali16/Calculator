import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RobotoMono',
      ),
      title: "Calculator",
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String equation = "";
  String expression = "0"; // this is for showing
  String result = "0";
  double ans = 0;
  double exp_Size = 60.0;
  double res_Size = 40.0;

  void eval(String eq) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(equation);
      ContextModel cm = ContextModel();
      ans = exp.evaluate(EvaluationType.REAL, cm);
      result = "$ans";
    } catch (e) {
      result = "ERROR";
    }
  }

  void Button_Pressed(String val) {
    setState(() {
      if (val == "CLR") {
        equation = "";
        expression = '0';
        result = "0";
      } else if (val == "Del") {
        equation = equation.substring(0, equation.length - 1);
        expression = expression.substring(0, expression.length - 1);
      } else if (expression.length < 10) {
        if (val == "x") {
          equation = equation + "*";
          expression = expression + "×";
        } else if (val == "mod") {
          equation = equation + "%";
          expression = expression + "%";
        } else if (val == "÷") {
          equation = equation + '/';
          expression = expression + "÷";
        } else if (val == "=") {
          //EVALUATE MATHEMATICAL EXPRESSION HERE AND PUT THE VALUE IN RESULT!
          eval(equation);
        } else {
          if (expression == "0") {
            expression = "";
          }
          equation = equation + val;
          expression = expression + val;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Digit limits reached!"),
          backgroundColor: Colors.deepOrangeAccent,
          duration: Duration(seconds: 1),
        ));
        debugPrint("limit reached!");
      }

      if (expression == "") {
        expression = "0";
      }
    });
  }

  Widget Button(String number, double height, double width) {
    return GestureDetector(
      onTap: () {
        Button_Pressed(number);
        debugPrint(
            " $number  is printed\nEquation = $equation \nExpression = $expression");
      },
      child: Container(
        // height: 90,
        // width: 90,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
            color: Colors.white,
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen_height = MediaQuery.of(context).size.height;
    final screen_width = MediaQuery.of(context).size.width;
    debugPrint("Screen WIDTH: $screen_width");
    debugPrint("Screen HEIGHT: $screen_height");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "CALCULATOR",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SCREEN CONTAINER
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
              child: Container(
                alignment: Alignment.centerRight,
                height: screen_height * 0.19157,
                child: Text(
                  expression,
                  style: TextStyle(
                    fontSize: exp_Size,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // RESULT CONTAINER
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 5, 1),
              child: Container(
                  alignment: Alignment.centerRight,
                  // color: Colors.black12,
                  // height: screen_height * 0.08298,
                  height: screen_height * 0.06,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: res_Size,
                      color: Colors.white,
                    ),
                  )),
            ),

            // KEYPADS

            //ROW 1
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button("CLR", screen_height * 0.115, screen_width * 0.23),
                  Button("Del", screen_height * 0.115, screen_width * 0.23),
                  Button("÷", screen_height * 0.115, screen_width * 0.23),
                  Button("mod", screen_height * 0.115, screen_width * 0.23),
                ],
              ),
            ),

            //ROW 2
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button("7", screen_height * 0.115, screen_width * 0.23),
                  Button("8", screen_height * 0.115, screen_width * 0.23),
                  Button("9", screen_height * 0.115, screen_width * 0.23),
                  Button("x", screen_height * 0.115, screen_width * 0.23),
                ],
              ),
            ),

            //ROW 3
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button("4", screen_height * 0.115, screen_width * 0.23),
                  Button("5", screen_height * 0.115, screen_width * 0.23),
                  Button("6", screen_height * 0.115, screen_width * 0.23),
                  Button("-", screen_height * 0.115, screen_width * 0.23),
                ],
              ),
            ),

            //ROW 4
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button("1", screen_height * 0.115, screen_width * 0.23),
                  Button("2", screen_height * 0.115, screen_width * 0.23),
                  Button("3", screen_height * 0.115, screen_width * 0.23),
                  Button("+", screen_height * 0.115, screen_width * 0.23),
                ],
              ),
            ),

            //ROW 5
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(".", screen_height * 0.115, screen_width * 0.23),
                  Button("0", screen_height * 0.115, screen_width * 0.23),
                  Button("00", screen_height * 0.115, screen_width * 0.23),
                  Button("=", screen_height * 0.115, screen_width * 0.23),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
