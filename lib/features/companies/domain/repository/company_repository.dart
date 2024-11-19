import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/domain/entities/company_entity.dart';

abstract class CompanyRepository {
  Future<DataState<List<CompanyEntity>>> getCompanies();
}
