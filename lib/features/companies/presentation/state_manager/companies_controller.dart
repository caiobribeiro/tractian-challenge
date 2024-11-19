import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/domain/entities/company_entity.dart';
import 'package:tractian_component_viewer/features/companies/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_component_viewer/features/companies/presentation/state_manager/companies_state.dart';

class CompaniesController {
  final CompaniesState _state = CompaniesState();
  final GetCompaniesUseCase _getCompaniesUseCase;

  CompaniesController(this._getCompaniesUseCase);

  Future<DataState<List<CompanyEntity>>> loadCompanies() async {
    _state.dataStateCompanies = await _getCompaniesUseCase.call();
    return _state.dataStateCompanies!;
  }
}
