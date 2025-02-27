import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/exceptions/server.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/core/helpers_functions.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/models/product.dart';
import 'package:e_commerce/logic/data/repositories/products_repository.dart';

class ProductsProvider {
  final repository = ProductsRepository();

  //get all products
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      //get data from the repository
      final List<Map> rawData = await repository.getAllProducts();
      //convert the list of maps to a list of products
      final data = rawData.map((e) => Product.fromMap(e)).toList();
      return Right(data);
    } on ServerException catch (e) {
      //handle the exceptions
      if (e.code == 500) {
        return Left(
            Failure(code: e.code, message: "The server is down currently"));
      }

      return Left(Failure(code: e.code, message: "An server error occurred"));
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(code: 100, message: "An error occurred"));
    }
  }

  /// get the products of a certain category
  Future<Either<Failure, List<Product>>> getCategoryProducts(
      Category category) async {
    try {
      //get data from the repository
      final List<Map> rawData = await repository.getCategoryProducts(category);
      //convert the list of maps to a list of products
      final data = rawData.map((e) => Product.fromMap(e)).toList();
      return Right(data);
    } on ServerException catch (e) {
      //handle the exceptions
      if (e.code == 500) {
        return Left(
            Failure(code: e.code, message: "The server is down currently"));
      }
      if (e.code == 404) {
        return Left(Failure(code: e.code, message: e.message));
      }

      return Left(Failure(code: e.code, message: "An server error occurred"));
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(code: 100, message: "An error occurred"));
    }
  }

  /// get a single product
  Future<Either<Failure, Product>> getProduct(int id) async {
    try {
      //get data from the repository
      final Map rawData = await repository.getProduct(id);
      //convert the  map to a products
      final data = Product.fromMap(rawData);
      return Right(data);
    } on ServerException catch (e) {
      //handle the exceptions
      if (e.code == 500) {
        return Left(
            Failure(code: e.code, message: "The server is down currently"));
      }
      if (e.code == 404) {
        return Left(Failure(code: e.code, message: e.message));
      }

      return Left(Failure(code: e.code, message: "An server error occurred"));
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(code: 100, message: "An error occurred"));
    }
  }

  /// get all categories
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final List<String> rawData = await repository.getCategories();
      final data = rawData.map((e) => Category(e)).toList();
      return Right(data);
    } on ServerException catch (e) {
      if (e.code == 500) {
        return Left(
            Failure(code: e.code, message: "The server is down currently"));
      }
      return Left(Failure(code: e.code, message: "An server error occurred"));
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(code: 100, message: "An error occurred"));
    }
  }

  ///add new product
  Future<Either<Failure, void>> addProduct(Product product) async {
    try {
      await repository.addProduct(product.toMap());
      return const Right(null);
    } on ServerException catch (e) {
      if (e.code == 500) {
        return Left(
            Failure(code: e.code, message: "The server is down currently"));
      } else if (e.code == 400) {
        return Left(Failure(code: e.code, message: e.message));
      }
      return Left(Failure(code: e.code, message: "An server error occurred"));
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(code: 100, message: "An error occurred"));
    }
  }
}
