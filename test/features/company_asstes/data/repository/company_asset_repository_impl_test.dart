import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_asset_api_service.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/models/company_asset_model.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/repository/company_asset_repository_impl.dart';
import 'package:http/http.dart' as http;

class MockCompanyAssetApiService extends Mock
    implements CompanyAssetApiService {}

void main() {
  late CompanyAssetRepositoryImpl repository;
  late MockCompanyAssetApiService mockApiService;

  setUp(() {
    mockApiService = MockCompanyAssetApiService();
    repository = CompanyAssetRepositoryImpl(mockApiService);
  });

  group('getCompanyAssets', () {
    test(
        'should return a list of company assets when the API response is successful',
        () async {
      // Arrange
      const companyId = '123';
      const asset1 = CompanyAssetModel(id: '1', name: 'Asset A');
      const asset2 = CompanyAssetModel(id: '2', name: 'Asset B');
      final jsonList = [asset1.toMap(), asset2.toMap()];
      when(() => mockApiService.getCompanyAssets(companyId: companyId))
          .thenAnswer((_) async {
        return http.Response(json.encode(jsonList), 200);
      });

      // Act
      final result = await repository.getCompanyAssets(companyId: companyId);

      // Assert
      expect(result, isA<DataState<List<CompanyAssetModel>>>());
      expect(result, isA<DataSuccess>());
      expect(result.data, [asset1, asset2]);
    });

    test('should return an error when the API response is unsuccessful',
        () async {
      // Arrange
      const companyId = '123';
      when(() => mockApiService.getCompanyAssets(companyId: companyId))
          .thenAnswer((_) async {
        return http.Response('', 404);
      });

      // Act
      final result = await repository.getCompanyAssets(companyId: companyId);

      // Assert
      expect(result, isA<DataState<List<CompanyAssetModel>>>());
      expect(result, isA<DataFailed>());
    });
  });
}
