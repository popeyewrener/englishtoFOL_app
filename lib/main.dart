import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fol_converter/api/apiCaller.dart';
import 'package:fol_converter/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FOL Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FOL Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String prompt = "";
  String result = "";
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 5,
            ),
            Container(
              width: 300,
              child: CustomTextField(
                  labelText: "Enter English logic",
                  hintText: "English Logic",
                  controller: controller),
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(elevation: MaterialStateProperty.all(5)),
              onPressed: () async {
                prompt = controller.text;
                try {
                  final response =
                      await ApiCaller().callGenerateEndpoint(controller.text);
                  result = response['response'];
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content:
                              Text("Kindly check your internet connection"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      });
                  (e.toString());
                }

                setState(() {
                  controller.clear();
                });
              },
              child: const Text('Convert'),
            ),
            Spacer(),
            prompt != ""
                ? Column(
                    children: [
                      Text(
                        "E N G L I S H   L O G I C",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(prompt),
                    ],
                  )
                : Text(""),
            Spacer(),
            result != ""
                ? Column(
                    children: [
                      Text(
                        "FOL Logic:",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(result),
                    ],
                  )
                : Text(""),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
