import 'dart:math' as math;
import 'package:flutter/material.dart';

class IMC {
  double height;
  double weight;
  String message = "ND";
  double value = 0.00;
  Color color = Colors.grey;

  IMC({
    required this.height,
    required this.weight,
  }) {
    try {
      double h = height;
      double w = weight;

      if(h <= 0 || w <= 0) throw "Invalid";

      double valueIMC = (w / math.pow(h, 2));
      value = valueIMC;

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
    } catch (error) {
      message = "Err";
      value = -1.00;
    }
  }
}
