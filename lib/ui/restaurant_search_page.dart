import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/custom_widget/card_restaurant_search.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/search';

  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final _textController = TextEditingController();
  bool _isIconVisible = false;
  final FocusNode _focusNode = FocusNode();

  clearSearchQuery() {
    setState(() {
      _textController.text = "";
      _isIconVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set fokus ke TextField ketika halaman dimuat
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pencarian"),
      ),
      body: SafeArea(
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantSearchProvider(
          apiService: ApiService(), query: _textController.text),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  focusNode: _focusNode,
                  autofocus: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Cari Nama Restoran atau Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    suffixIcon: _isIconVisible
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              clearSearchQuery();
                            },
                          )
                        : null,
                  ),
                  onChanged: (query) {
                    state.findRestaurant(_textController.text);
                    setState(() => query.isNotEmpty
                        ? _isIconVisible = true
                        : _isIconVisible = false);
                  },
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _textController.text.isEmpty
                      ? _emptyRestaurant(context)
                      : _findRestaurant(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _findRestaurant() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultSearchState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultSearchState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.resultRestaurantSearch.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.resultRestaurantSearch.restaurants[index];
              return CardRestaurantSearch(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultSearchState.noData) {
          return Center(
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 100.0,
                  ),
                  const SizedBox(height: 20),
                  Text(state.message,
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          );
        } else if (state.state == ResultSearchState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _emptyRestaurant(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            color: Colors.blue,
            size: 100.0,
          ),
          const SizedBox(height: 20),
          Text(
            "Eksplorasi Rasa di Jelajah Kuliner Kami",
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
