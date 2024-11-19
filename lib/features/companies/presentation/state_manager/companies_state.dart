import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/domain/entities/company_entity.dart';

class CompaniesState {
  DataState<List<CompanyEntity>>? dataStateCompanies;
  CompaniesState({this.dataStateCompanies});
}
