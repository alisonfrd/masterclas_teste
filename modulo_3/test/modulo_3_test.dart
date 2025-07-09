import 'package:modulo_3/future.dart';
import 'package:test/test.dart';

void main() {
  test('deve completar a requisição trazendo uma lista de nomes', () {
    final result = getFutureList();
    // expect(result, completes);
    // expect(result, completion(isA<List<String>>()));
    expect(result, completion(equals(['Flutter', 'Tester'])));
  });
}
