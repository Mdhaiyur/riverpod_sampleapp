import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_counterapp/data/model/product.dart';
import 'package:riverpod_counterapp/data/remote/product_api_impl.dart';

class ProductView extends ConsumerWidget {
  final productProvider = FutureProvider.autoDispose((_) {
    return ProductApiImple().getProducts();
  });

  final productProviderFamily = FutureProvider.autoDispose.family<Product,int>((_,productId) {
    return ProductApiImple().getProductById(productId);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //print(ref.watch(productProviderFamily(1)));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
        ),
        body: ref.watch(productProvider).when(data: (data) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Product product = data[index];
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
        }, error: (error, stackTrace) {
          return  Center(child: Text(error.toString()));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
