import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counterapp/data/model/product.dart';
import '../data/remote/product_api_impl.dart';

final productViewModel =ChangeNotifierProvider<ProductViewModel>((ref){
  return ProductViewModel();
});


class ProductViewModel extends ChangeNotifier{

  bool _loading=false;
  List<Product> _productList=[];

  bool get loading => _loading;
  List<Product> get productList => _productList;

  setLoading(bool loading){
    _loading=loading;
    notifyListeners();
  }

  setProductList(List<Product> productList){
    _productList=productList;
  }

  ///product api call
  fetchProducts() async{
    setLoading(true);
    var response= await ProductApiImple().getProducts();
    setProductList(response);
    setLoading(false);
  }
}