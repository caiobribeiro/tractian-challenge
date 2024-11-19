import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_asset_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_locations_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/usecases/get_company_locations_usecase.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/state_manager/company_assets_state.dart';

class CompanyAssetsController {
  final CompanyAssetsState _state = CompanyAssetsState();
  final GetCompanyLocationsUseCase _getCompanyLocationsUseCase;
  final GetCompanyAssetsUsecase _getCompanyAssetsUsecase;

  CompanyAssetsController(
    this._getCompanyAssetsUsecase,
    this._getCompanyLocationsUseCase,
  );

  Future<DataState<List<CompanyAssetEntity>>> loadCompanyAssets(
      {required String companyId}) async {
    _state.dataStateCompanyAssets =
        await _getCompanyAssetsUsecase.call(params: companyId);
    return _state.dataStateCompanyAssets!;
  }

  Future<DataState<List<CompanyLocationsEntity>>> loadCompanyLocations(
      {required String companyId}) async {
    _state.dataStateCompanyLocations =
        await _getCompanyLocationsUseCase.call(params: companyId);
    return _state.dataStateCompanyLocations!;
  }
}
