import 'package:bloc/bloc.dart';
import 'package:clean_architecture_demo/bloc_data_loading_state.dart';
import 'package:clean_architecture_demo/search/domain/usecase/search_product_use_case.dart';
import 'package:intl/intl.dart';

import '../domain/model/product.dart';

class ProductSearchBloc extends Bloc<SearchProductEvent, SearchProductState> {
  ProductSearchBloc(this.searchProductUseCase) : super(const SearchProductState.loading());

  final SearchProductUseCase searchProductUseCase;

  @override
  Stream<SearchProductState> mapEventToState(SearchProductEvent event) async* {
    yield const SearchProductState.loading();
    try {
      final List<Product> products = await searchProductUseCase(event.query);
      final List<ProductViewModel> productViewModels = products.map(_convertToViewModel).toList();
      yield SearchProductState.success(productViewModels);
    } on Exception catch (error) {
      yield SearchProductState.error(error);
    }
  }

  ProductViewModel _convertToViewModel(Product product) => ProductViewModel(
        name: product.name,
        imageUrl: product.imageUrl,
        productUrl: product.productUrl,
        price: NumberFormat('#,##0', 'en_US').format(product.price),
      );
}

class SearchProductEvent {
  final String query;

  const SearchProductEvent(this.query);
}

class SearchProductState extends BlocDataLoadingState<List<ProductViewModel>> {
  const SearchProductState.loading() : super(isLoading: true);

  const SearchProductState.success(List<ProductViewModel> productViewModels) : super(data: productViewModels);

  const SearchProductState.error(Object error) : super(error: error);
}

class ProductViewModel {
  ProductViewModel({this.name, this.imageUrl, this.productUrl, this.price});

  final String name;
  final String imageUrl;
  final String productUrl;
  final String price;
}
