import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/core/usecases/usecase.dart';
import 'package:tractian_component_viewer/features/companies/domain/entities/company_entity.dart';
import 'package:tractian_component_viewer/features/companies/domain/repository/company_repository.dart';

class GetCompaniesUseCase
    implements UseCase<DataState<List<CompanyEntity>>, void> {
  final CompanyRepository _companyRepository;

  GetCompaniesUseCase(this._companyRepository);

  @override
  Future<DataState<List<CompanyEntity>>> call({void params}) {
    return _companyRepository.getCompanies();
  }
}
