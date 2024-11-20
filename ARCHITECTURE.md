# ARCHITECTURE

## Goal
This doc has the main goal to organize the process of app development.

This project follows the Clean Architecture approach. Clean Architecture organizes the code to be independent of frameworks, UI, databases, or any external agents, and is divided into several layers. Below is a detailed explanation of the structure and components of the project.

## Project Structure
Core:
- baseApiUrl: Contains the base URL of the API;
- DataState: Abstract class representing the state of the data (success or failure);
- UseCase: Abstract class for use cases.

Features Domain:
- Entities: Defines the domain entities.
- Repository: Interface for repositories.
- UseCases: Implementation of use cases.

Data:
- Models: Data representations exchanged with the API.
- DataSources: Defines data access services.
- RepositoryImpl: Concrete implementation of the repositories.

Presentation:
- State: State management.
- Controller: Controller using the use cases.
- Pages: Presentation pages (UI).

Directory Estucture
```shell
  .
  └── lib/
      └── core/
          └── constants/
          └── resources/
          └── usecases/
      └── features/
          └── feature-example/
              └── data/
                  └── data_source/
                  └── models/
                  └── repository/
              └── domain/
                  └── entities/
                  └── repository/
                  └── usecases/
              └── presentation/
                  └── pages/
                  └── state_manager/
  ├── ARCHITECTURE.md
  ├── README.md
  └── test/
      └── features/
          └── feature-example/
              └── domain/
                  └── entities/
                  └── repository/
                  └── usecases/
```

## Packages
Packages from The official package repository for Dart and Flutter apps.


- [HTTP] - A composable, Future-based library for making HTTP requests;
- [Mocktail] - Mocktail focuses on providing a familiar, simple API for creating mocks in Dart (with null-safety) without the need for manual mocks or code generation;
- [Equatable] - Being able to compare objects in Dart often involves having to override the == operator as well as hashCode;



    [HTTP]: <https://pub.dev/packages/http>
    [Mocktail]: <https://pub.dev/packages/mocktail>
    [Equatable]: <https://pub.dev/packages/equatable>
   
  