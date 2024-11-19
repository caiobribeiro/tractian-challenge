import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/data/data_sources/companies_api_service.dart';
import 'package:tractian_component_viewer/features/companies/data/models/company_model.dart';
import 'package:tractian_component_viewer/features/companies/data/repository/company_repository_impl.dart';

class MockCompaniesApiService extends Mock implements CompaniesApiService {}

void main() {
  late CompanyRepositoryImpl repository;
  late MockCompaniesApiService mockCompaniesApiService;

  setUp(() {
    mockCompaniesApiService = MockCompaniesApiService();
    repository = CompanyRepositoryImpl(mockCompaniesApiService);
  });

  group('getCompanies', () {
    test(
        'should return a list of companies when the API response is successful',
        () async {
      // Arrange
      const companyModel1 = CompanyModel(id: '1', name: 'Company A');
      const companyModel2 = CompanyModel(id: '2', name: 'Company B');
      final jsonList = [companyModel1.toMap(), companyModel2.toMap()];
      when(() => mockCompaniesApiService.getCompanies()).thenAnswer((_) async {
        return http.Response(json.encode(jsonList), 200);
      });

      // Act
      final result = await repository.getCompanies();

      // Assert
      expect(result, isA<DataState<List<CompanyModel>>>());
      expect(result, isA<DataSuccess>());
      expect(result.data, [companyModel1, companyModel2]);
    });

    test('should return an error when the API response is unsuccessful',
        () async {
      // Arrange
      when(() => mockCompaniesApiService.getCompanies()).thenAnswer((_) async {
        return http.Response('', 404);
      });

      // Act
      final result = await repository.getCompanies();

      // Assert
      expect(result, isA<DataState<List<CompanyModel>>>());
      expect(result, isA<DataFailed>());
    });
  });
}
