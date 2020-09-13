import 'package:clean_architecture_demo/search/domain/model/product.dart';

abstract class SearchProductRepository {
  Future<List<Product>> searchProduct(String query);
}
