import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/api_service.dart';
import '../widgets/category/category_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<Category> _categories;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();


  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       hintText: 'Search Pokemon by name...',
          //       prefixIcon: const Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     onChanged: (value) {
          //       setState(() {
          //         _searchQuery = value;
          //       });
          //       _filterPokemon(value);
          //     },
          //   ),
          // ),
          Expanded(
            child: _categories.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Category found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  // const SizedBox(height: 8),
                  // TextButton(
                  //   onPressed: _isSearching
                  //       ? null
                  //       : () async {
                  //     await _searchPokemonByName(_searchQuery);
                  //   },
                  //   child: _isSearching
                  //       ? const SizedBox(
                  //     width: 20,
                  //     height: 20,
                  //     child: CircularProgressIndicator(strokeWidth: 2),
                  //   )
                  //       : const Text('Search in API'),
                  // ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CategoryGrid(categories: _categories),
            ),
          ),
        ],
      ),
    );
  }

  void _loadCategoryList() async {
    final categoryList = await _apiService.loadCategoryList();

    setState(() {
      _categories = categoryList;
      _isLoading = false;
    });
  }
}