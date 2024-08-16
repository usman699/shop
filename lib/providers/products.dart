import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/pexels-ash-376464.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/pexels-marvin-ozz-2474661.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/images/pexels-maarten-van-den-heuvel-2284166.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-jane-doan-1099680.jpg',
    ),
    Product(
      id: 'p5',
      title: 'built in ',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-ash-376464.jpg',
    ),
    Product(
      id: 'p6',
      title: 'options',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-jane-doan-1099680.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Widgets ',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-maarten-van-den-heuvel-2284166.jpg',
    ),
    Product(
      id: 'p8',
      title: 'A service box',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-marvin-ozz-2474661.jpg',
    ),
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/pexels-ash-376464.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/pexels-marvin-ozz-2474661.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/images/pexels-maarten-van-den-heuvel-2284166.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-jane-doan-1099680.jpg',
    ),
    Product(
      id: 'p5',
      title: 'built in ',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-ash-376464.jpg',
    ),
    Product(
      id: 'p6',
      title: 'options',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-jane-doan-1099680.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Widgets ',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-maarten-van-den-heuvel-2284166.jpg',
    ),
    Product(
      id: 'p8',
      title: 'A service box',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/pexels-marvin-ozz-2474661.jpg',
    ),
  ];


  List<Product> get items {

    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
  Future<void> addProduct(Product product) async {
    var urlnn = Uri.parse(
        'https://hhhhhhh-a6e91-default-rtdb.firebaseio.com/product.json');
    await http
        .post(urlnn,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavroite': product.isFavorite,
            }))
        .then((response) {
      print(json.decode(response.body));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      // _items.add(value);
      notifyListeners();
    }).catchError((onError) {
      print(onError);
      throw onError;
    });
  }

  Future<void> Fetch() async {
    var url = Uri.parse(
        'https://hhhhhhh-a6e91-default-rtdb.firebaseio.com/product.json');
    try {
      final response = await http.get(url);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      print('extracted = $extracted');
      final List<Product> loadedProducts = [];
      extracted.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          imageUrl: prodData['imageUrl'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error );
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
      final ProdIndex = _items.indexWhere((element) => element.id == id);
      final url2 =
        'https://hhhhhhh-a6e91-default-rtdb.firebaseio.com/$id.json';
        await http.patch(Uri.parse(url2),
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price
        }));
    _items[ProdIndex] = newProduct;
    notifyListeners();
  }

  void DelteProducts(String Id) {
    _items.removeWhere((element) => element.id == Id);
    notifyListeners();
  }
}
