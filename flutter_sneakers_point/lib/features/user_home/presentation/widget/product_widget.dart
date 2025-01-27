import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';

class ProductWidget extends StatelessWidget {
  final WidgetRef ref;
  final List<ProductEntity> productList;

  const ProductWidget({
    Key? key,
    required this.ref,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            ref.read(productViewModelProvider.notifier).getProductById(
                  context,
                  productList[index].productId!,
                );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    // Wrap Image.network with FractionallySizedBox
                    widthFactor: 1.0, // Set widthFactor to 1.0
                    child: Image.network(
                      productList[index].productImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    productList[index].productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '\$${productList[index].productPrice}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
