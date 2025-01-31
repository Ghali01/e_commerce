import 'dart:convert';

import 'package:e_commerce/core/exceptions/server.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProductsRepository {
  /// Gets all products from the api
  ///
  /// Throws a [ServerException] if the server returns a non-200 status code
  ///
  /// Returns a [List] of [Map]s, where each [Map] represents a product.
  Future<List<Map>> getAllProducts() async {
    //Send the http request
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final data = List<Map>.from(jsonDecode(response.body));
      return data;
    } else if (response.statusCode == 500) {
      throw ServerException(code: 500, message: 'Internal Server Error');
    } else {
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }

  /// Gets all products from a certain category from the api
  ///
  /// Throws a [ServerException] if the server returns a non-200 status code
  ///
  /// Returns a [List] of [Map]s, where each [Map] represents a product.
  Future<List<Map>> getCategoryProducts(Category category) async {
    try {
      //Send the http request
      final response = await http.get(Uri.parse(
          'https://fakestoreapi.com/products/category/${category.name}'));
      if (response.statusCode == 200) {
        final data = List<Map>.from(jsonDecode(response.body));
        return data;
      } else if (response.statusCode == 500) {
        throw ServerException(code: 500, message: 'Internal Server Error');
      } else if (response.statusCode == 404) {
        throw ServerException(code: 404, message: 'Category not found');
      } else {
        throw ServerException(code: 400, message: 'An error occurred');
      }
    } catch (e) {
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }

  /// Gets a product with the given [id] from the api
  ///
  /// Throws a [ServerException] if the server returns a non-200 status code
  ///
  /// Returns a [Map] representing the product.
  Future<Map> getProduct(int id) async {
    //Send the http request
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 500) {
      throw ServerException(code: 500, message: 'Internal Server Error');
    } else if (response.statusCode == 404) {
      throw ServerException(code: 404, message: 'Product not found');
    } else {
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }

  /// Fetches the list of product categories from the API.
  ///
  /// Sends a GET request to the 'fakestoreapi.com' to retrieve all available
  /// product categories.
  ///
  /// Throws a [ServerException] if the server returns a non-200 status code.
  ///
  /// Returns a [List] of [String]s where each [String] is a category name.

  Future<List<String>> getCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      final data = List<String>.from(jsonDecode(response.body));
      return data;
    } else if (response.statusCode == 500) {
      throw ServerException(code: 500, message: 'Internal Server Error');
    } else {
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }

  //add cart
  /// Adds a cart with the specified list of items to the API.
  ///
  /// Sends a POST request to 'fakestoreapi.com/carts' with the current date
  /// and a list of products.
  ///
  /// Throws a [ServerException] if the server returns a non-200 status code.

  Future<void> addCart(List<Map> items) async {
    //get today date and format it
    final DateFormat dateFormat = DateFormat.yMd();
    final date = dateFormat.format(DateTime.now());
    //send the http request
    final response = await http.post(
        Uri.parse('https://fakestoreapi.com/carts'),
        body: jsonEncode({'userId': 5, 'date': date, 'products': items}));
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 500) {
      throw ServerException(code: 500, message: 'Internal Server Error');
    } else {
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }

  //add new product
  /// Adds a new product to the API.
  ///
  /// Sends a POST request to 'fakestoreapi.com/products' with the given
  /// product.
  ///
  /// Throws a [ServerException] if the server returns a non-200 status code.
  Future<void> addProduct(Map product) async {
    final response = await http.post(
        Uri.parse('https://fakestoreapi.com/products'),
        body: jsonEncode(product));
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 500) {
      throw ServerException(code: 500, message: 'Internal Server Error');
    } else {
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }
}
