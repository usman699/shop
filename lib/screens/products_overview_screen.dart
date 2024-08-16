import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';

import 'package:badges/badges.dart' as badges;
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}


class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/productOverviewScreen';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var isnit = true;
  // @override
  // void initState() {
  //  Provider.of<Products>(context).Fetch()
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    if (isnit = true) {
      Provider.of<Products>(context).Fetch();
    }
    isnit = false;
    super.didChangeDependencies();
  }
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),

            ],
          ),

          Consumer<Cart>(
            builder: (_, cart, ch) =>   badges.Badge(
    badgeContent: Text(cart.itemCount .toString()),
    badgeStyle: badges.BadgeStyle(
        padding: EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(4),
      shape: badges.BadgeShape.circle
    ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
    )

          ),
          SizedBox(
            width: 20,
            height: 20,
          )
        ],
      ),

      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
