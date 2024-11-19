import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_asset_entity.dart';

abstract class CompanyAssetRepository {
  Future<DataState<List<CompanyAssetEntity>>> getCompanyAssets(
      {required String companyId});
}
