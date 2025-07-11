import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modulo_4/api_service.dart';
import 'package:modulo_4/product.dart';
import 'package:uno/uno.dart';

// class UnoMock implements Uno {
//   final bool withError;

//   UnoMock([this.withError = false]);

//   @override
//   Future<Response> get(String url,
//       {Duration? timeout,
//       Map<String, String> params = const {},
//       Map<String, String> headers = const {},
//       ResponseType responseType = ResponseType.json,
//       DownloadCallback? onDownloadProgress,
//       ValidateCallback? validateStatus}) async {
//     if (withError) {
//       throw const UnoError('Aiai');
//     }
//     return Response(
//       headers: {},
//       request: Request(
//         uri: Uri(),
//         method: 'get',
//         headers: {},
//         timeout: Duration.zero,
//       ),
//       status: 200,
//       data: productListJson,
//     );
//   }

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }

class UnoMock extends Mock implements Uno {}

class ResponseMock extends Mock implements Response {}

void main() {
  final uno = UnoMock();
  tearDown(() => reset(uno));
  test('Deve retornar uma lista de Product', () async {
    final response = ResponseMock();
    when(
      () => response.data,
    ).thenReturn(productListJson);
    when(
      () => uno.get(any()),
    ).thenAnswer(
      (__) async => response,
    );
    final apiService = ApiService(uno);
    expect(
        apiService.getProduct(),
        completion([
          const Product(id: 1, title: 'title', price: 12.0),
          const Product(id: 2, title: 'title2', price: 13.0),
        ]));
  });

  test('Deve retornar uma lista de Product vazia em caso de erro', () async {
    when(
      () => uno.get(any()),
    ).thenThrow(const UnoError('aiaia'));
    final apiService = ApiService(uno);

    expect(apiService.getProduct(), completion([]));
  });
}

final productListJson = [
  {'id': 1, 'title': 'title', 'price': 12.0},
  {'id': 2, 'title': 'title2', 'price': 13.0},
];
