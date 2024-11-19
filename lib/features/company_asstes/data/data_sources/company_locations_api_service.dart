import 'package:http/http.dart' as http;

abstract class CompanyLocationsApiService {
  Future<http.Response> getCompanyLocations({required String companyId});
}
