import 'package:equatable/equatable.dart';

class CompanyAssetEntity extends Equatable {
  final String? id;
  final String? locationId;
  final String? name;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? sensorId;
  const CompanyAssetEntity({
    this.id,
    this.locationId,
    this.name,
    this.parentId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.sensorId,
  });

  @override
  List<Object?> get props {
    return [
      id,
      locationId,
      name,
      parentId,
      sensorType,
      status,
      gatewayId,
      sensorId,
    ];
  }
}
