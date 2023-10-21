import 'package:calculadoraimc/imc.dart';

class Person {
  late String _name;
  late double _height;
  late double _weight;
  late IMC _imc;

  Person({
    required String name,
    required double height,
    required double weight,
    IMC? putIMC,
  }) {
    _name = name;
    _height = height;
    _weight = weight;

    if (putIMC != null) {
      _imc = putIMC;
    } else {
      _imc = IMC(
        height: height,
        weight: weight,
      );
    }
  }

  String get name => _name;
  double get height => _height;
  double get weight => _weight;
  IMC get imc => _imc;
}
