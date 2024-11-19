import 'package:http/http.dart' as http;

abstract class CompaniesApiService {
  Future<http.Response> getCompanies();
}
