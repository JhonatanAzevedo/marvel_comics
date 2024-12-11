import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String name;

  const Comic({required this.name});

  @override
  List<Object?> get props => [name];
}
