import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_asset_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_locations_entity.dart';

class CompanyAssetsState {
  DataState<List<CompanyLocationsEntity>>? dataStateCompanyLocations;
  DataState<List<CompanyAssetEntity>>? dataStateCompanyAssets;
  CompanyAssetsState({
    this.dataStateCompanyAssets,
    this.dataStateCompanyLocations,
  });
}
