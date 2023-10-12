import 'package:flutter_test/flutter_test.dart';
import 'package:calculadoraimc/main.dart';

void main() {
  testWidgets('Checar Estado dos Componentes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final valueIMC = find.bySemanticsLabel("0.00");
    final message = find.bySemanticsLabel("IMC");
    final name = find.bySemanticsLabel("Nome");
    final height = find.bySemanticsLabel("Altura");
    final weight = find.bySemanticsLabel("Peso");
    final calculateAndSave = find.bySemanticsLabel("Calcular e Salvar");

    expect(valueIMC, findsOneWidget);
    expect(message, findsOneWidget);
    expect(name, findsOneWidget);
    expect(height, findsOneWidget);
    expect(weight, findsOneWidget);
    expect(calculateAndSave, findsOneWidget);

    expect(find.text("0.00"), findsOneWidget);
    expect(find.text("IMC"), findsOneWidget);
    expect(find.text("Nome"), findsOneWidget);
    expect(find.text("Altura"), findsOneWidget);
    expect(find.text("Peso"), findsOneWidget);

    await tester.enterText(name, "Test Name");
    await tester.enterText(height, "1.65");
    await tester.enterText(weight, "88.6");
    await tester.tap(calculateAndSave);
    await tester.pump();

    expect(find.text('32.54'), findsOneWidget);
    expect(find.text('Obesidade Grau I'), findsOneWidget);
    expect(find.text('Test Name'), findsOneWidget);
    expect(find.text('1.65'), findsOneWidget);
    expect(find.text('88.6'), findsOneWidget);
  });
}
