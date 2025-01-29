import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/failure.dart';

abstract class BaseUseCase<I, O> {
  Future<Either<Failure, O>> call(I input);
}

class NoParams {}
