import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_locations_entity.dart';

abstract class CompanyLocationsRepository {
  Future<DataState<List<CompanyLocationsEntity>>> getCompanyLocations(
      {required String companyId});
}
