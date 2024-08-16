import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
class UserProductItem extends StatelessWidget {
  final title;
  final ImageUrl;
  final id;
  UserProductItem(
      {@required this.title, @required this.ImageUrl, @required this.id});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: AssetImage(ImageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor)),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen:false).DelteProducts(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                )),
          ],
        ),
      ),
    );
  }
}
