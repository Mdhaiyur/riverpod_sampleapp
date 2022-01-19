import 'package:dio/dio.dart';
import 'package:riverpod_counterapp/data/model/product.dart';
import 'package:riverpod_counterapp/data/remote/product_api.dart';

class ProductApiImple extends ProductAPI {

  final options = BaseOptions(
    baseUrl: 'https://fakestoreapi.com',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  @override
  Future<List<Product>> getProducts() async {
    List<Product> productList = [];
    var response = await Dio(options).get('/products');
    if (response.statusCode == 200) {
      final List<dynamic> body = response.data;
      for (var product in body) {
        productList.add(Product.fromJson(product));
      }
      return productList;
    } else {
      throw Exception('Can\'t fetch product from server.');
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    var response = await Dio(options).get('/products/$id');
    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Can\'t fetch product from server.');
    }
  }
}
