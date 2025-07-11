import 'package:modulo_4/product.dart';
import 'package:uno/uno.dart';

class ApiService {
  final Uno uno;
  ApiService(
    this.uno,
  );

  Future<List<Product>> getProduct() async {
    try {
      final response = await uno.get('/product');
      final list = response.data as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } on UnoError {
      return [];
    }
  }
}
