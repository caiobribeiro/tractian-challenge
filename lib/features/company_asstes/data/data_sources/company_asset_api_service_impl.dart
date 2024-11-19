import 'package:http/http.dart' as http;
import 'package:tractian_component_viewer/core/constants/constants.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_asset_api_service.dart';

class CompanyAssetApiServiceImpl extends CompanyAssetApiService {
  @override
  Future<http.Response> getCompanyAssets({required String companyId}) async {
    final response =
        await http.get(Uri.parse('$baseApiUrl/companies/$companyId/assets'));
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }
}
