import 'package:clean_architecture_demo/search/domain/data/search_product_repository.dart';
import 'package:clean_architecture_demo/search/domain/usecase/search_product_use_case.dart';
import 'package:clean_architecture_demo/search/presentation/product_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductSearchResultPage extends StatefulWidget {
  const ProductSearchResultPage({Key key, this.query}) : super(key: key);

  final String query;

  @override
  _ProductSearchResultPageState createState() => _ProductSearchResultPageState();

  static Widget create(String query) => BlocProvider(
        create: (context) {
          final searchProductRepository =
              Provider.of<SearchProductRepository>(context, listen: false);
          return ProductSearchBloc(SearchProductUseCase(searchProductRepository));
        },
        child: ProductSearchResultPage(query: query),
      );
}

class _ProductSearchResultPageState extends State<ProductSearchResultPage> {
  @override
  void initState() {
    super.initState();
    context.bloc<ProductSearchBloc>().add(SearchProductEvent(widget.query));
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductSearchBloc, SearchProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError) {
            return Center(child: Text('${state.error}'));
          }

          return ListView.builder(
              itemBuilder: (context, index) => _buildProductListTile(state.data[index]));
        },
      );

  Widget _buildProductListTile(ProductViewModel viewModel) => ListTile(
        title: Text(viewModel.name),
        subtitle: Text(viewModel.price),
        leading: Image.network(viewModel.imageUrl),
        onTap: () => launch(viewModel.productUrl),
      );
}
