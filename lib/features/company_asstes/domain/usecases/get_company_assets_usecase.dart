import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/core/usecases/usecase.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_asset_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/repository/company_asset_repository.dart';

class GetCompanyAssetsUsecase
    implements UseCase<DataState<List<CompanyAssetEntity>>, String> {
  final CompanyAssetRepository _companyAssetRepository;

  GetCompanyAssetsUsecase(this._companyAssetRepository);

  @override
  Future<DataState<List<CompanyAssetEntity>>> call({String? params}) {
    return _companyAssetRepository.getCompanyAssets(companyId: params!);
  }
}
