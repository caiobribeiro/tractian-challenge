import 'dart:convert';

import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_asset_entity.dart';

class CompanyAssetModel extends CompanyAssetEntity {
  const CompanyAssetModel({
    super.id,
    super.locationId,
    super.name,
    super.parentId,
    super.sensorType,
    super.status,
    super.gatewayId,
    super.sensorId,
  });

  factory CompanyAssetModel.fromMap(Map<String, dynamic> map) {
    return CompanyAssetModel(
      id: map['id'],
      locationId: map['locationId'],
      name: map['name'],
      parentId: map['parentId'],
      sensorType: map['sensorType'],
      status: map['status'],
      gatewayId: map['gatewayId'],
      sensorId: map['sensorId'],
    );
  }

  factory CompanyAssetModel.fromJson(String source) =>
      CompanyAssetModel.fromMap(json.decode(source));
}
