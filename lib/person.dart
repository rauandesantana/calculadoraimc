import 'dart:math' as math;
import 'package:flutter/material.dart';

class Person {
  TextEditingValue name;
  TextEditingValue height;
  TextEditingValue weight;

  Person({
    required this.name,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> calculateIMC() {
    try {
      double h = double.tryParse(height.text) ?? 0;
      double w = double.tryParse(weight.text) ?? 0;
      double valueIMC = (w / math.pow(h, 2));
      String message = "IMC";
      Color color = Colors.grey;

      if (valueIMC < 16) {
        message = "Magreza Grave";
        color = Colors.red;
      } else if (valueIMC >= 16 && valueIMC < 17) {
        message = "Magreza Moderada";
        color = Colors.orange;
      } else if (valueIMC >= 17 && valueIMC < 18.5) {
        message = "Magreza Leve";
        color = Colors.yellow.shade600;
      } else if (valueIMC >= 18.5 && valueIMC < 25) {
        message = "Saudável";
        color = Colors.green;
      } else if (valueIMC >= 25 && valueIMC < 30) {
        message = "Sobrepeso";
        color = Colors.yellow.shade600;
      } else if (valueIMC >= 30 && valueIMC < 35) {
        message = "Obesidade Grau I";
        color = Colors.orange;
      } else if (valueIMC >= 35 && valueIMC < 40) {
        message = "Obesidade Grau II";
        color = Colors.red;
      } else if (valueIMC >= 40) {
        message = "Obesidade Grau III";
        color = Colors.red.shade900;
      }

      return {
        "valueIMC": valueIMC,
        "message": message,
        "color": color,
      };
    } catch (error) {
      return {
        "valueIMC": -1.00,
        "message": "Err",
        "color": Colors.grey,
      };
    }
  }
}
