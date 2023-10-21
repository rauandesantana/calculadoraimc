import 'package:calculadoraimc/person.dart';
import 'package:calculadoraimc/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final docDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(docDirectory.path);
  Storage storage = await Storage.openBoxPerson();
  runApp(
    MyApp(storage: storage),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.storage,
  });

  final Storage storage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Calculadora IMC',
        storage: storage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.storage,
  });

  final String title;
  final Storage storage;

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
  bool listView = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (list.isEmpty && widget.storage.boxPersonIsNotEmpty) {
      list = widget.storage.getPersonList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: listView,
            child: FloatingActionButton(
              child: const Icon(Icons.delete_rounded),
              onPressed: () => setState(() {
                widget.storage.clearPersonList();
                list.clear();
              }),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          FloatingActionButton(
            child: Icon(
              (listView) ? Icons.close_rounded : Icons.history_rounded,
            ),
            onPressed: () => setState(() {
              listView = !listView;
            }),
          )
        ],
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                          visible: !listView,
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
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 25)),
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    ElevatedButton(
                                      key: const Key("calculateAndSaveButton"),
                                      onPressed: () {
                                        final validate =
                                            _formKey.currentState?.validate();
                                        if (validate == true) {
                                          setState(() {
                                            String height = _controlHeight.text;
                                            String weight = _controlWeight.text;
                                            Person person = Person(
                                              name: _controlName.text,
                                              height: double.tryParse(height) ??
                                                  0.00,
                                              weight: double.tryParse(weight) ??
                                                  0.00,
                                            );
                                            valueIMC = person.imc.value;
                                            valueMessage = person.imc.message;
                                            color = person.imc.color;
                                            list.add(widget.storage
                                                .savePerson(person));
                                          });
                                        }
                                      },
                                      child: const Text("Calcular e Salvar"),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 50)),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: listView,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  List<Person> listReversed =
                                      list.reversed.toList();
                                  String name = listReversed[index].name;
                                  String? message =
                                      listReversed[index].imc.message;
                                  double? imc = listReversed[index].imc.value;
                                  Color? color = listReversed[index].imc.color;

                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              key:
                                                  Key("messageItemList_$index"),
                                              message,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          key: Key("valueIMCItemList_$index"),
                                          imc.toStringAsFixed(2),
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
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: list.reversed.length,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
