import 'package:calculadoraimc/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
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
  final _formKey = GlobalKey<FormState>();
  final _controlName = TextEditingController();
  final _controlHeight = TextEditingController();
  final _controlWeight = TextEditingController();
  double? valueIMC = 0.00;
  String? message = "IMC";
  Color? color;
  List<Person> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          valueIMC?.toStringAsFixed(2) ?? "-1.00",
                          style: TextStyle(
                            color: color,
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          message ?? "Err",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 25)),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _controlName,
                                validator: (String? value) =>
                                    (value == null || value.isEmpty)
                                        ? "Campo Obrigatório!"
                                        : null,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Nome",
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              TextFormField(
                                controller: _controlHeight,
                                validator: (String? value) =>
                                    (value == null || value.isEmpty)
                                        ? "Campo Obrigatório!"
                                        : null,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Altura",
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              TextFormField(
                                controller: _controlWeight,
                                validator: (String? value) =>
                                    (value == null || value.isEmpty)
                                        ? "Campo Obrigatório!"
                                        : null,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Peso",
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              ElevatedButton(
                                onPressed: () {
                                  final validate =
                                      _formKey.currentState?.validate();
                                  if (validate == true) {
                                    setState(() {
                                      Person person = Person(
                                        name: _controlName.value,
                                        height: _controlHeight.value,
                                        weight: _controlWeight.value,
                                      );
                                      valueIMC = person.imc?.value;
                                      message = person.imc?.message;
                                      color = person.imc?.color;
                                      list.add(person);
                                    });
                                  }
                                },
                                child: const Text("Calcular e Salvar"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 350),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    Text(
                      "Observação",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    Text(
                      "IMC",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      List<Person> listReversed = list.reversed.toList();
                      String name = listReversed[index].name.text;
                      String? message = listReversed[index].imc?.message;
                      double? imc = listReversed[index].imc?.value;
                      Color? color = listReversed[index].imc?.color;

                      return Container(
                        height: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color ?? Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              message ?? "Err",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              imc?.toStringAsFixed(2) ?? "-1.00",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: list.reversed.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
