import 'package:modulo_3/stream.dart';
import 'package:test/test.dart';

void main() {
  test('Deve completar a requisição trazendo uma lista de nomes', () async {
    final stream = getStreamList();
    // expect(stream, emits('Masterclass'));
    expect(stream, emitsInOrder(['Masterclass', 'Flutter']));
  });
}
