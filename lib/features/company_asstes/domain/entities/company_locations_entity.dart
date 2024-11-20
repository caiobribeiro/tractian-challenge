import 'package:equatable/equatable.dart';

class CompanyLocationsEntity extends Equatable {
  final String? id;
  final String? name;
  final String? parentId;

  const CompanyLocationsEntity({this.id, this.name, this.parentId});

  @override
  List<Object?> get props => [id, name, parentId];
}
