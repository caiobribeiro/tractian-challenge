import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/core/usecases/usecase.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_locations_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/repository/company_locations_repository.dart';

class GetCompanyLocationsUseCase
    implements UseCase<DataState<List<CompanyLocationsEntity>>, String> {
  final CompanyLocationsRepository _companyLocationsRepository;

  GetCompanyLocationsUseCase(this._companyLocationsRepository);

  @override
  Future<DataState<List<CompanyLocationsEntity>>> call({String? params}) {
    return _companyLocationsRepository.getCompanyLocations(companyId: params!);
  }
}
