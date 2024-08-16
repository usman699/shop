import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFabs;
  ProductGrid({required this.showFabs});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Products>(context, listen: false);
    final products = showFabs ? data.favoriteItems : data.items;
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
             value: products[index],
              child: ProductItem(),
            ));
  }
}
