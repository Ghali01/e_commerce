import 'dart:convert';

import 'package:e_commerce/core/exceptions/server.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProductsRepository {
  Future<List<Map>> getAllProducts() async {
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

  Future<List<Map>> getCategoryProducts(Category category) async {
    try {
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

  Future<Map> getProduct(int id) async {
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
      print(response.body);
      throw ServerException(code: 400, message: 'An error occurred');
    }
  }
}
