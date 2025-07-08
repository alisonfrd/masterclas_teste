import 'package:api_test_dart/api_test_dart.dart';
import 'package:test/test.dart';

void main() {
  double peso = 80; // Peso em quilogramas
  double altura = 1.75; // Altura em metros

  test('Deve calcular o IMC corretamente', () {
    final result = imcCalc(altura, peso);
    expect(result, equals(26.122448979591837));
  });

  group('Excessões de parametros |', () {
    test('Deve lançar uma exceção se a altura for zero', () {
      expect(() => imcCalc(0, peso), throwsA(isA<Exception>()));
    });
    test('Deve lançar uma exceção se o peso for zero', () {
      expect(() => imcCalc(altura, 0), throwsA(isA<Exception>()));
    });
  });
}
