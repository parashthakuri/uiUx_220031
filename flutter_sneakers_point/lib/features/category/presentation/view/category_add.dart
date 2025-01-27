import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';
import 'package:sneakers_point/features/category/presentation/view_model/category_view_model.dart';

class AdminAddCategory extends ConsumerStatefulWidget {
  const AdminAddCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddCategoryState();
}

class _AdminAddCategoryState extends ConsumerState<AdminAddCategory> {
  final categoryNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categoryState.showMessage) {
        showSnackBar(message: 'Category Added', context: context);
        ref.read(categoryViewModelProvider.notifier).resetMessage(false);
      }
      if (categoryState.showCategoryDeleteMessage) {
        showSnackBar(message: 'Category deleted', context: context);
        ref.read(categoryViewModelProvider.notifier).resetMessage(false);
      }
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Meat Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            TextFormField(
              controller: categoryNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Category Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter category name';
                }
                return null;
              },
            ),
            gap,
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Category Description',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter category description';
                }
                return null;
              },
            ),
            gap,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  CategoryEntity categoryEntity = CategoryEntity(
                    categoryName: categoryNameController.text.trim(),
                    description: descriptionController.text.trim(),
                  );
                  ref
                      .read(categoryViewModelProvider.notifier)
                      .addCategory(categoryEntity);
                },
                child: const Text('Add Category'),
              ),
            ),
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            categoryState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: categoryState.categories.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          subtitle: Text(
                            categoryState.categories[index].categoryName,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .read(categoryViewModelProvider.notifier)
                                  .deleteCategory(categoryState
                                      .categories[index].categoryId!);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
