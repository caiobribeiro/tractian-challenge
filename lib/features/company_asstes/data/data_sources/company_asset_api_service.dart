import 'package:http/http.dart' as http;

abstract class CompanyAssetApiService {
  Future<http.Response> getCompanyAssets({required String companyId});
}
