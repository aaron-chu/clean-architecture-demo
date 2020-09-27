import 'package:clean_architecture_demo/search/presentation/product_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductSearchResultPage extends StatefulWidget {
  @override
  _ProductSearchResultPageState createState() => _ProductSearchResultPageState();
}

class _ProductSearchResultPageState extends State<ProductSearchResultPage> {
  @override
  Widget build(BuildContext context) => BlocBuilder<ProductSearchBloc, SearchProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError) {
            return Center(child: Text('${state.error}'));
          }

          return ListView.builder(itemBuilder: (context, index) => _buildProductListTile(state.data[index]));
        },
      );

  Widget _buildProductListTile(ProductViewModel viewModel) => ListTile(
        title: Text(viewModel.name),
        subtitle: Text(viewModel.price),
        leading: Image.network(viewModel.imageUrl),
        onTap: () => launch(viewModel.productUrl),
      );
}
