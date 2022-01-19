import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_counterapp/data/model/product.dart';
import 'package:riverpod_counterapp/data/remote/product_api_impl.dart';
import 'package:riverpod_counterapp/viewmodel/product_viewmodel.dart';

class UserView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ProductViewModel model=ref.watch(productViewModel).fetchProducts();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
        ),
        body:productView(model) );
  }

  productView(ProductViewModel productViewModel)
  {
    if(productViewModel.loading)
      {
        return const Center(child: CircularProgressIndicator(),);
      }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: productViewModel.productList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Product product = productViewModel.productList[index];
          return Row(
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(15))),
                child: Image.network(
                  product.image!,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      product.description!,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12, color: Colors.black38)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                '\$${product.price!.toString()}',
                maxLines: 1,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 15,
          );
        },
      ),
    );
  }
}
