import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String? id;
  final String? name;
  const CompanyEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
