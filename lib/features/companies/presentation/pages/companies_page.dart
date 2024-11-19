import 'package:flutter/material.dart';
import 'package:tractian_component_viewer/core/resources/data_state.dart';
import 'package:tractian_component_viewer/features/companies/data/data_sources/companies_api_service_impl.dart';
import 'package:tractian_component_viewer/features/companies/data/repository/company_repository_impl.dart';
import 'package:tractian_component_viewer/features/companies/domain/entities/company_entity.dart';
import 'package:tractian_component_viewer/features/companies/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_component_viewer/features/companies/presentation/state_manager/companies_controller.dart';
import 'package:tractian_component_viewer/features/company_asstes/presentation/pages/company_assets_page.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});
  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  late CompaniesController companiesController;
  @override
  void initState() {
    super.initState();
    final CompaniesApiServiceImpl apiService = CompaniesApiServiceImpl();
    final CompanyRepositoryImpl repository = CompanyRepositoryImpl(apiService);
    final GetCompaniesUseCase getCompaniesUseCase =
        GetCompaniesUseCase(repository);
    companiesController = CompaniesController(getCompaniesUseCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        title: Image.asset(
          'assets/tractian_logo.png',
          scale: 1.5,
        ),
      ),
      body: FutureBuilder<DataState<List<CompanyEntity>>>(
        future: companiesController.loadCompanies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            if (snapshot.data is DataSuccess) {
              final companies =
                  (snapshot.data as DataSuccess<List<CompanyEntity>>).data!;
              return ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanyAssetsPage(
                                company: companies[index],
                              ),
                            ),
                          ),
                          child: Container(
                            width: 400,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2188FF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/company_icon.png',
                                      scale: 1,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '${companies[index].name ?? ''} Unit',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.data is DataFailed) {
              return const Center(child: Text('Failed to load companies'));
            }
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
