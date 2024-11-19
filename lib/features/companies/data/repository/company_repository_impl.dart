import 'dart:convert';

import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/data/data_sources/companies_api_service.dart';
import 'package:tractian_component_viewer/features/companies/data/models/company_model.dart';
import 'package:tractian_component_viewer/features/companies/domain/repository/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompaniesApiService _companiesApiService;

  CompanyRepositoryImpl(this._companiesApiService);
  @override
  Future<DataState<List<CompanyModel>>> getCompanies() async {
    final httpReponse = await _companiesApiService.getCompanies();
    if (httpReponse.statusCode == 200) {
      List<dynamic> jsonList = json.decode(httpReponse.body);
      List<CompanyModel> companies =
          jsonList.map((company) => CompanyModel.fromMap(company)).toList();

      return DataSuccess(companies);
    } else {
      return DataFailed(httpReponse);
    }
  }
}
