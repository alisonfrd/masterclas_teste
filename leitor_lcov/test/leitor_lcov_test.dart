import 'package:leitor_lcov/leitor_lcov.dart';
import 'package:leitor_lcov/line_report.dart';
import 'package:test/test.dart';

void main() {
  test('Deve pegar porcentagem de cobertura', () {
    final result = coverage('./coverage/lcov.info');
    expect(result, '100%');
  });

  test('Deve retornar 50% nos testes', () {
    final result = calculatePercent([
      LineReport(sourceFile: '', lineFound: 18, lineHit: 9),
      LineReport(sourceFile: '', lineFound: 10, lineHit: 5),
    ]);
    expect(result, 50);
  });
}
