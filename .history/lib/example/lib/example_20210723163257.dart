import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:password_checker/checker.dart';
import "package:password_checker/generator.dart";

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  TextEditingController controller = new TextEditingController();

  int score = 0;

  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Checker"),
      ),
      body: Column(
        children: [
          controller.text.isNotEmpty
              ? Text(
                  "${controller.text} has a score of $score",
                  style: TextStyle(color: Colors.black),
                )
              : Text("Enter a Password", style: TextStyle(color: Colors.black)),
          TextFormField(
            controller: controller,
          ),
          CupertinoButton(
            child: Text("Check Password"),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  score = Checker.checkPassword(controller.text);
                });
              }
            },
          ),
          password.isNotEmpty
              ? Text(
                  password,
                  style: TextStyle(color: Colors.black),
                )
              : Text("Generate a Random Password",
                  style: TextStyle(color: Colors.black)),
          CupertinoButton(
            child: Text("Generate"),
            onPressed: () {
              setState(() {
                password = Generator.getRandomString(10, true, true, true, true);
                controller.text = password;
              });
            },
          ),
        ],
      ),
    );
  }
}
