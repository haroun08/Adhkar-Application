import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salati/features/categories/cubit/categories_cubit.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'أذكار',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return switch (state) {
            CategoriesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CategoriesLoaded() => GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Single column layout
                childAspectRatio: 3, // Adjust height of each item
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return Card(
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the category details or perform another action
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
            CategoriesError() => Center(
              child: Text(state.message),
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
