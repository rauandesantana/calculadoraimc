import 'package:calculadoraimc/imc.dart';
import 'package:flutter/material.dart';

class Person {
  TextEditingValue name;
  TextEditingValue height;
  TextEditingValue weight;
  IMC? imc;

  Person({
    required this.name,
    required this.height,
    required this.weight,
  }) {
    imc = IMC(
      height: double.tryParse(height.text) ?? 0,
      weight: double.tryParse(weight.text) ?? 0,
    );
  }
}
