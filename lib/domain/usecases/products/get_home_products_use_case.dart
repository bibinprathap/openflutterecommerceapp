/// # 1. Home Screen
/// 1.1. Home Screen 1 use-case: Use loads the app, list of new products
/// for home page are loaded and displayed in the app.
/// https://medium.com/@openflutterproject/open-flutter-project-e-commerce-app-use-cases-and-features-6b7414a6e708

import 'package:openflutterecommerce/data/model/product.dart';
import 'package:openflutterecommerce/data/repositories/abstract/product_repository.dart';
import 'package:openflutterecommerce/domain/usecases/base_use_case.dart';
import 'package:openflutterecommerce/locator.dart';

abstract class GetHomePageProductsUseCase
    implements BaseUseCase<HomeProductsResult, HomeProductParams> {}

class GetHomePageProductsUseCaseImpl implements GetHomePageProductsUseCase {
  @override
  Future<HomeProductsResult> execute(HomeProductParams params) async {
    try {
      ProductRepository productRepository = sl();
      return HomeProductsResult(
        salesProducts: await productRepository.getHomeProducts(type: 0),
        newProducts: await productRepository.getHomeProducts(type: 1),
        topSeller: await productRepository.getHomeProducts(type: 2),
        availableOffers: await productRepository.getHomeProducts(type: 3),
        newArrivals: await productRepository.getHomeProducts(type: 4),
        result: false,
      );
    } catch (e) {
      return HomeProductsResult(
          salesProducts: [],
          newProducts: [],
          topSeller: [],
          availableOffers: [],
          newArrivals: [],
          result: false,
          exception: HomeProductsException());
    }
  }
}

class HomeProductParams {}

class HomeProductsResult extends UseCaseResult {
  final List<Product> salesProducts;
  final List<Product> availableOffers;
  final List<Product> newArrivals;
  final List<Product> topSeller;
  final List<Product> newProducts;

  HomeProductsResult(
      {this.salesProducts,
      this.newProducts,
      this.availableOffers,
      this.newArrivals,
      this.topSeller,
      Exception exception,
      bool result})
      : super(exception: exception, result: result);
}

class HomeProductsException implements Exception {}
