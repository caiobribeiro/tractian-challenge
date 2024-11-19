import 'package:flutter/material.dart';
import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/domain/entities/company_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_asset_api_service_impl.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/data_sources/company_locations_api_service_impl.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/repository/company_asset_repository_impl.dart';
import 'package:tractian_component_viewer/features/company_asstes/data/repository/company_locations_repository_impl.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_asset_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/entities/company_locations_entity.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian_component_viewer/features/company_asstes/domain/usecases/get_company_locations_usecase.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/state_manager/company_assets_controller.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/util/tree_node.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/widgets/tree_widget.dart';

class CompanyAssetsPage extends StatefulWidget {
  final CompanyEntity company;
  const CompanyAssetsPage({super.key, required this.company});

  @override
  State<CompanyAssetsPage> createState() => _CompanyAssetsPageState();
}

class _CompanyAssetsPageState extends State<CompanyAssetsPage> {
  late CompanyAssetsController companyAssetsController;
  List<CompanyLocationsEntity>? locations;
  List<CompanyAssetEntity>? assets;

  @override
  void initState() {
    super.initState();

    final CompanyLocationsApiServiceImpl apiLocationsService =
        CompanyLocationsApiServiceImpl();
    final CompanyLocationsRepositoryImpl repositoryLocations =
        CompanyLocationsRepositoryImpl(apiLocationsService);
    final GetCompanyLocationsUseCase getCompanyLocationsUseCase =
        GetCompanyLocationsUseCase(repositoryLocations);

    final CompanyAssetApiServiceImpl apiAssetService =
        CompanyAssetApiServiceImpl();
    final CompanyAssetRepositoryImpl repositoryAsset =
        CompanyAssetRepositoryImpl(apiAssetService);
    final GetCompanyAssetsUsecase getCompanyAssetsUseCase =
        GetCompanyAssetsUsecase(repositoryAsset);
    companyAssetsController = CompanyAssetsController(
        getCompanyAssetsUseCase, getCompanyLocationsUseCase);
  }

  Future<DataState<List<CompanyLocationsEntity>>> getLocations() async {
    final companyLocations = await companyAssetsController.loadCompanyLocations(
        companyId: widget.company.id!);
    return companyLocations;
  }

  Future<DataState<List<CompanyAssetEntity>>> getAssets() async {
    final companyAssets = await companyAssetsController.loadCompanyAssets(
        companyId: widget.company.id!);
    return companyAssets;
  }

  Future<Map<String, List>> loadLocationsAndAssets() async {
    final locationsFuture = companyAssetsController.loadCompanyLocations(
        companyId: widget.company.id!);
    final assetsFuture = companyAssetsController.loadCompanyAssets(
        companyId: widget.company.id!);

    final results = await Future.wait([locationsFuture, assetsFuture]);

    return {
      'locations':
          (results[0] as DataState<List<CompanyLocationsEntity>>).data ?? [],
      'assets': (results[1] as DataState<List<CompanyAssetEntity>>).data ?? [],
    };
  }

  List<TreeNode> buildTreeNodes(
      List<CompanyLocationsEntity> locations, List<CompanyAssetEntity> assets,
      {int maxDepth = 1000, int currentDepth = 0}) {
    if (currentDepth > maxDepth) {
      throw const StackOverflowError();
    }
    final Map<String?, List<CompanyLocationsEntity>>
        locationsGroupedByParentId = {};
    final Map<String?, List<CompanyAssetEntity>> assetsGroupedByLocationId = {};
    final Map<String?, List<CompanyAssetEntity>> assetsGroupedByParentId = {};
    for (var location in locations) {
      locationsGroupedByParentId
          .putIfAbsent(location.parentId, () => [])
          .add(location);
    }
    for (var asset in assets) {
      if (asset.locationId != null) {
        assetsGroupedByLocationId
            .putIfAbsent(asset.locationId, () => [])
            .add(asset);
      }
      if (asset.parentId != null) {
        assetsGroupedByParentId
            .putIfAbsent(asset.parentId, () => [])
            .add(asset);
      }
    }
    Set<String?> visited = {};
    List<TreeNode> buildNodes(String? parentId, String? locationId,
        {int depth = 0}) {
      if (visited.contains(parentId ?? locationId)) {
        return [];
      }
      visited.add(parentId ?? locationId);
      final locationChildren = locationsGroupedByParentId[parentId] ?? [];
      final locationAssets = locationId != null
          ? (assetsGroupedByLocationId[locationId] ?? [])
          : [];
      final locationNodes = locationChildren.map((location) {
        return TreeNode(
          title: location.name ?? 'Unknown Location',
          icon: NodeType.location,
          children: buildNodes(location.id, location.id, depth: depth + 1),
        );
      }).toList();
      final assetNodes = locationAssets.map((asset) {
        final childAssets = assetsGroupedByParentId[asset.id] ?? [];
        final childNodes = childAssets.map((childAsset) {
          return TreeNode(
            title: childAsset.name ?? 'Unknown Asset',
            icon: childAsset.sensorType != null
                ? NodeType.component
                : NodeType.asset,
            sensorstatus: _mapStatusToSensorStatus(childAsset.status),
            children: buildNodes(null, childAsset.id, depth: depth + 1),
          );
        }).toList();
        return TreeNode(
          title: asset.name ?? 'Unknown Asset',
          icon: asset.sensorType != null ? NodeType.component : NodeType.asset,
          sensorstatus: _mapStatusToSensorStatus(asset.status),
          children: childNodes,
        );
      }).toList();
      return [
        ...locationNodes,
        ...assetNodes,
      ];
    }

    return buildNodes(null, null);
  }

  Sensorstatus? _mapStatusToSensorStatus(String? status) {
    switch (status) {
      case 'operating':
        return Sensorstatus.operating;
      case 'alert':
        return Sensorstatus.alert;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Image.asset(
          'assets/tractian_logo.png',
          scale: 1.5,
        ),
      ),
      body: FutureBuilder<Map<String, List>>(
        future: loadLocationsAndAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final locations =
                snapshot.data!['locations'] as List<CompanyLocationsEntity>;
            final assets = snapshot.data!['assets'] as List<CompanyAssetEntity>;

            final treeData = buildTreeNodes(locations, assets);

            return TreeWidget(
              treeData: treeData,
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
