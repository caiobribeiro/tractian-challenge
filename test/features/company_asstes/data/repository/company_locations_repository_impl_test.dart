import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_locations_api_service.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/models/company_locations_model.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/repository/company_locations_repository_impl.dart';
import 'package:http/http.dart' as http;

class MockCompanyLocationsApiService extends Mock
    implements CompanyLocationsApiService {}

void main() {
  late CompanyLocationsRepositoryImpl repository;
  late MockCompanyLocationsApiService mockApiService;

  setUp(() {
    mockApiService = MockCompanyLocationsApiService();
    repository = CompanyLocationsRepositoryImpl(mockApiService);
  });

  group('getCompanyLocations', () {
    test(
        'should return a list of company locations when the API response is successful',
        () async {
      const companyId = '123';
      const location1 = CompanyLocationsModel(id: '1', name: 'Location A');
      const location2 = CompanyLocationsModel(id: '2', name: 'Location B');
      final jsonList = [location1.toMap(), location2.toMap()];
      when(() => mockApiService.getCompanyLocations(companyId: companyId))
          .thenAnswer((_) async {
        return http.Response(json.encode(jsonList), 200);
      });

      final result = await repository.getCompanyLocations(companyId: companyId);

      expect(result, isA<DataState<List<CompanyLocationsModel>>>());
      expect(result, isA<DataSuccess>());
      expect(result.data, [location1, location2]);
    });

    test('should return an error when the API response is unsuccessful',
        () async {
      const companyId = '123';
      when(() => mockApiService.getCompanyLocations(companyId: companyId))
          .thenAnswer((_) async {
        return http.Response('', 404);
      });

      final result = await repository.getCompanyLocations(companyId: companyId);

      expect(result, isA<DataState<List<CompanyLocationsModel>>>());
      expect(result, isA<DataFailed>());
    });
  });
}
