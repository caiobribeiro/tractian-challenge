import 'package:http/http.dart' as http;
import 'package:tractian_component_viewer/core/constants/constants.dart';
import 'companies_api_service.dart';

class CompaniesApiServiceImpl extends CompaniesApiService {
  @override
  Future<http.Response> getCompanies() async {
    final response = await http.get(Uri.parse('$baseApiUrl/companies'));
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }
}
