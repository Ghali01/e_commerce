import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  const Category(
    this.name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
