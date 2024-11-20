import 'dart:convert';

import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_asset_api_service.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/models/company_asset_model.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/repository/company_asset_repository.dart';

class CompanyAssetRepositoryImpl implements CompanyAssetRepository {
  final CompanyAssetApiService _companyAssetApiService;

  CompanyAssetRepositoryImpl(this._companyAssetApiService);

  @override
  Future<DataState<List<CompanyAssetModel>>> getCompanyAssets(
      {required String companyId}) async {
    final httpReponse =
        await _companyAssetApiService.getCompanyAssets(companyId: companyId);
    if (httpReponse.statusCode == 200) {
      List<dynamic> jsonList = json.decode(httpReponse.body);
      List<CompanyAssetModel> companyAssets =
          jsonList.map((asset) => CompanyAssetModel.fromMap(asset)).toList();

      return DataSuccess(companyAssets);
    } else {
      return DataFailed(httpReponse);
    }
  }
}
