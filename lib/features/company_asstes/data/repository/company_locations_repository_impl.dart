import 'dart:convert';

import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_locations_api_service.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/models/company_locations_model.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/repository/company_locations_repository.dart';

class CompanyLocationsRepositoryImpl implements CompanyLocationsRepository {
  final CompanyLocationsApiService _companyLocationsApiService;

  CompanyLocationsRepositoryImpl(this._companyLocationsApiService);
  @override
  Future<DataState<List<CompanyLocationsModel>>> getCompanyLocations(
      {required String companyId}) async {
    final httpReponse = await _companyLocationsApiService.getCompanyLocations(
        companyId: companyId);
    if (httpReponse.statusCode == 200) {
      List<dynamic> jsonList = json.decode(httpReponse.body);
      List<CompanyLocationsModel> companyLocations = jsonList
          .map((company) => CompanyLocationsModel.fromMap(company))
          .toList();
      return DataSuccess(companyLocations);
    } else {
      return DataFailed(httpReponse);
    }
  }
}
