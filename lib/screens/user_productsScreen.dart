import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/userProductItem.dart';
import '../screens/edit_product_screen.dart';
class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).Fetch();
  }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('your products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body:RefreshIndicator(
        onRefresh: ()=> _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => UserProductItem(
                id: productsData.items[i].id,
                title: productsData.items[i].title,
                ImageUrl: productsData.items[i].imageUrl),
          ),
        ),
      ),
    );
  }
}
