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
  double valueIMC = 0;
  String message = "IMC";
  Color color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: const BoxConstraints(maxWidth: 350),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  valueIMC.toStringAsFixed(2),
                  style: TextStyle(
                    color: color,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 25)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
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
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      TextFormField(
                        controller: _controlHeight,
                        validator: (String? value) =>
                            (value == null || value.isEmpty)
                                ? "Campo Obrigatório!"
                                : null,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Altura",
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      TextFormField(
                        controller: _controlWeight,
                        validator: (String? value) =>
                            (value == null || value.isEmpty)
                                ? "Campo Obrigatório!"
                                : null,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Peso",
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      ElevatedButton(
                        onPressed: () {
                          final validate = _formKey.currentState?.validate();
                          if (validate == true) {
                            setState(() {
                              Person person = Person(
                                name: _controlName.value,
                                height: _controlHeight.value,
                                weight: _controlWeight.value,
                              );
                              Map<String, dynamic> value =
                                  person.calculateIMC();
                              valueIMC = value["valueIMC"];
                              message = value["message"];
                              color = value["color"];
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
    );
  }
}
