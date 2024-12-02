import 'dart:convert';

import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_locations_entity.dart';

class CompanyLocationsModel extends CompanyLocationsEntity {
  const CompanyLocationsModel({
    super.id,
    super.name,
    super.parentId,
  });

  factory CompanyLocationsModel.fromMap(Map<String, dynamic> map) {
    return CompanyLocationsModel(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  String toJson() => json.encode(toMap());

  factory CompanyLocationsModel.fromJson(String source) =>
      CompanyLocationsModel.fromMap(json.decode(source));
}
