import 'package:calculadoraimc/imc.dart';
import 'package:calculadoraimc/person.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const boxNamePerson = "PERSON";

class Storage {
  static late Box _boxPerson;

  Storage._load();

  static Future<Storage> openBoxPerson() async {
    if (Hive.isBoxOpen(boxNamePerson)) {
      _boxPerson = Hive.box(boxNamePerson);
    } else {
      _boxPerson = await Hive.openBox(boxNamePerson);
    }
    return Storage._load();
  }

  bool get boxPersonIsNotEmpty => _boxPerson.isNotEmpty;

  Person savePerson(Person person) {
    _boxPerson.add({
      "name": person.name,
      "height": person.height,
      "weight": person.weight,
      "imc": person.imc.value,
      "message": person.imc.message,
      "color": person.imc.color.value,
    });
    return person;
  }

  List<Person> getPersonList() {
    List<Person> listPerson = [];

    for (int i = 0; i < _boxPerson.length; i++) {
      Map<dynamic, dynamic> value = _boxPerson.getAt(i);

      listPerson.add(
        Person(
          name: value["name"],
          height: value["height"],
          weight: value["weight"],
          putIMC: IMC.recovery(
            message: value["message"],
            value: value["imc"],
            color: Color(value["color"]),
          ),
        ),
      );
    }

    return listPerson;
  }

  void clearPersonList() => _boxPerson.clear();

}
