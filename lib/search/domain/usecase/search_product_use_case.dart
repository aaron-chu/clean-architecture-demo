import 'package:clean_architecture_demo/search/domain/data/search_product_repository.dart';
import 'package:clean_architecture_demo/search/domain/model/product.dart';

class SearchProductUseCase {
  final SearchProductRepository repository;

  SearchProductUseCase(this.repository);

  Future<List<Product>> call(String query) => repository.searchProduct(query);
}
