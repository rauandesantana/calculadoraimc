import 'dart:math' as math;
import 'package:flutter/material.dart';

class IMC {
  late String _message;
  late double _value;
  late Color _color;

  IMC({
    required double height,
    required double weight,
  }) {
    if (height <= 0 || weight <= 0) {
      _value = 0.0;
      _message = "Entradas Inválidas";
      _color = Colors.grey;
    } else {
      double valueIMC = (weight / math.pow(height, 2));
      _value = valueIMC;

      if (valueIMC < 16) {
        _message = "Magreza Grave";
        _color = Colors.red;
      } else if (valueIMC >= 16 && valueIMC < 17) {
        _message = "Magreza Moderada";
        _color = Colors.orange;
      } else if (valueIMC >= 17 && valueIMC < 18.5) {
        _message = "Magreza Leve";
        _color = Colors.yellow.shade600;
      } else if (valueIMC >= 18.5 && valueIMC < 25) {
        _message = "Saudável";
        _color = Colors.green;
      } else if (valueIMC >= 25 && valueIMC < 30) {
        _message = "Sobrepeso";
        _color = Colors.yellow.shade600;
      } else if (valueIMC >= 30 && valueIMC < 35) {
        _message = "Obesidade Grau I";
        _color = Colors.orange;
      } else if (valueIMC >= 35 && valueIMC < 40) {
        _message = "Obesidade Grau II";
        _color = Colors.red;
      } else if (valueIMC >= 40) {
        _message = "Obesidade Grau III";
        _color = Colors.red.shade900;
      }
    }
  }

  IMC.recovery({
    required String message,
    required double value,
    required Color color,
  }) {
    _message = message;
    _value = value;
    _color = color;
  }

  String get message => _message;
  double get value => _value;
  Color get color => _color;
}
