import 'package:e_commerce/core/exceptions/base.dart';

class ServerException extends AppException {
  ServerException({required super.message, required super.code});
}
