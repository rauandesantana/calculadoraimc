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
  String? valueMessage = "IMC";
  Color? color;
  List<Person> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 50),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth * 0.9,
                  height: constraints.maxHeight,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Column(
                    children: [
                      Text(
                        key: const Key("valueIMC"),
                        valueIMC?.toStringAsFixed(2) ?? "-1.00",
                        style: TextStyle(
                          color: color,
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        key: const Key("valueMessage"),
                        valueMessage ?? "Err",
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
                              key: const Key("fieldName"),
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
                              key: const Key("fieldHeight"),
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
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                            TextFormField(
                              key: const Key("fieldWeight"),
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
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                            ElevatedButton(
                              key: const Key("calculateAndSaveButton"),
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
                                    valueMessage = person.imc?.message;
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
                      const Padding(padding: EdgeInsets.only(bottom: 50)),
                      Row(
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
                            "IMC",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 15)),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            List<Person> listReversed = list.reversed.toList();
                            String name = listReversed[index].name.text;
                            String? message = listReversed[index].imc?.message;
                            double? imc = listReversed[index].imc?.value;
                            Color? color = listReversed[index].imc?.color;

                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color ?? Colors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        key: Key("nameItemList_$index"),
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        key: Key("messageItemList_$index"),
                                        message ?? "Err",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    key: Key("valueIMCItemList_$index"),
                                    imc?.toStringAsFixed(2) ?? "-1.00",
                                    style: const TextStyle(
                                      fontSize: 22,
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
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
