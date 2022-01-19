import 'package:riverpod_counterapp/data/model/product.dart';

abstract class ProductAPI
{
  Future<List<Product>> getProducts();

  Future<Product> getProductById(int id);

}