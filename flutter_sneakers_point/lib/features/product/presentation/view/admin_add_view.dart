import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/features/category/presentation/view_model/category_view_model.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class AdminAddProduct extends ConsumerStatefulWidget {
  const AdminAddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductState();
}

class _AdminAddProductState extends ConsumerState<AdminAddProduct> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final gap = const SizedBox(height: 8);

  // Check for the camera permission
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);

        // ref.read(authViewModelProvider.notifier).uploadImage(_img!);
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    final categoryState = ref.watch(categoryViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (productState.showMessage) {
        showSnackBar(message: 'Product Added', context: context);
        ref.read(productViewModelProvider.notifier).resetMessage(false);
      }
      if (productState.showProductDeleteMessage) {
        showSnackBar(message: 'Product deleted', context: context);
        ref.read(productViewModelProvider.notifier).resetMessage(false);
      }
    });

    String? dropDownValue;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add product"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: Column(
          children: [
            // const Text(
            //   'Add Meat Item',
            //   style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black),
            // ),
            gap,
            TextFormField(
              controller: productNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Meat Name',
                  hintStyle: TextStyle(fontSize: 12)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter item name';
                }
                return null;
              },
            ),
            gap,
            TextFormField(
              controller: productDescriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Meat Description',
                  hintStyle: TextStyle(fontSize: 12)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter item Description';
                }
                return null;
              },
            ),
            gap,
            TextFormField(
              controller: productPriceController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Product Price',
                  hintStyle: TextStyle(fontSize: 12)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Product Price';
                }
                return null;
              },
            ),
            gap,
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.grey[300],
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                  ),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _browseImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Gallery'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(right: 8, left: 8),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(3)),
                child: const ListTile(
                  leading: Text(
                    "Product Image",
                    style: TextStyle(
                        // fontSize: 13,
                        ),
                  ),
                  trailing: Card(
                    elevation: 0,
                    child: Icon(Icons.image),
                  ),
                ),
              ),
            ),
            gap,
            DropdownButtonFormField<String>(
              items: categoryState.categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category.categoryName,
                        child: Text(category.categoryName),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle dropdown value change
                dropDownValue = value;
              },
              value: dropDownValue,
              decoration: const InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: TextStyle(fontSize: 12)),
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  ProductEntity productEntity = ProductEntity(
                    productName: productNameController.text.trim(),
                    productPrice: int.parse(productPriceController.text.trim()),
                    productDescription:
                        productDescriptionController.text.trim(),
                    productCategory: dropDownValue!,
                  );
                  ref
                      .read(productViewModelProvider.notifier)
                      .addProduct(productEntity, _img);

                  showSnackBar(message: 'Product Added', context: context);
                },
                child: const Text('Add meat'),
              ),
            ),
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                ' Available Stocks',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            productState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: productState.products.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: CircleAvatar(
                              radius:
                                  10, // Adjust the radius to set the size of the circular image
                              backgroundColor: Colors
                                  .blue, // Set background color of the circle
                              backgroundImage: NetworkImage(productState
                                      .products[index].productImageUrl ??
                                  ""), // Set the image
                            ),
                            title:
                                Text(productState.products[index].productName),
                            subtitle: Text(
                                productState.products[index].productCategory),
                            trailing: IconButton(
                              color: Colors.red.shade900,
                              onPressed: () {
                                ref
                                    .read(productViewModelProvider.notifier)
                                    .deleteProduct(productState
                                        .products[index].productId!);
                              },
                              icon: const Icon(
                                Icons.delete,
                              ),
                            ));
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
// import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
// import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AdminAddProduct extends ConsumerStatefulWidget {
//   const AdminAddProduct({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _AdminAddProductState();
// }

// class _AdminAddProductState extends ConsumerState<AdminAddProduct> {
//   final productNameController = TextEditingController();
//   final productDescriptionController = TextEditingController();
//   final productPriceController = TextEditingController();
//   final gap = const SizedBox(height: 8);

//   // Check for the camera permission
//   checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }

//   File? _img;
//   Future _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         _img = File(image.path);

//         // ref.read(authViewModelProvider.notifier).uploadImage(_img!);
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productState = ref.watch(productViewModelProvider);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (productState.showMessage) {
//         showSnackBar(message: 'Product Added', context: context);
//         ref.read(productViewModelProvider.notifier).resetMessage(false);
//       }
//       if (productState.showProductDeleteMessage) {
//         showSnackBar(message: 'Product deleted', context: context);
//         ref.read(productViewModelProvider.notifier).resetMessage(false);
//       }
//     });

//     List<String> dummyCategories = [
//       'Prok',
//       'Chicken',
//       'Beef',
//       // Add more batches as needed
//     ];

//     String? dropDownValue;
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             gap,
//             const Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'Add Product',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             gap,
//             TextFormField(
//               controller: productNameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Product Name',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter Product name';
//                 }
//                 return null;
//               },
//             ),
//             gap,
//             TextFormField(
//               controller: productDescriptionController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Product Description',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter Product Description';
//                 }
//                 return null;
//               },
//             ),
//             gap,
//             TextFormField(
//               controller: productPriceController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Product Price',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter Product Price';
//                 }
//                 return null;
//               },
//             ),
//             gap,
//             InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                   backgroundColor: Colors.grey[300],
//                   context: context,
//                   isScrollControlled: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(0),
//                     ),
//                   ),
//                   builder: (context) => Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             _browseImage(ImageSource.gallery);
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(Icons.image),
//                           label: const Text('Gallery'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1),
//                     borderRadius: BorderRadius.circular(3)),
//                 child: const ListTile(
//                   leading: Text(
//                     "Product Image",
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   trailing: Card(
//                     elevation: 0,
//                     child: Icon(Icons.image),
//                   ),
//                 ),
//               ),
//             ),
//             gap,
//             DropdownButtonFormField<String>(
//               items: dummyCategories
//                   .map((batchName) => DropdownMenuItem<String>(
//                         value: batchName,
//                         child: Text(batchName),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 dropDownValue = value;
//               },
//               value: dropDownValue,
//               decoration: const InputDecoration(
//                 labelText: 'Select Category',
//               ),
//               validator: ((value) {
//                 if (value == null) {
//                   return 'Please select category';
//                 }
//                 return null;
//               }),
//             ),
//             gap,
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   ProductEntity productEntity = ProductEntity(
//                     productName: productNameController.text.trim(),
//                     productPrice: int.parse(productPriceController.text.trim()),
//                     productDescription:
//                         productDescriptionController.text.trim(),
//                     productCategory: dropDownValue!,
//                   );
//                   ref
//                       .read(productViewModelProvider.notifier)
//                       .addProduct(productEntity, _img);
//                 },
//                 child: const Text('Add Product'),
//               ),
//             ),
//             gap,
//             const Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'List of Products',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             gap,
//             productState.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Expanded(
//                     child: ListView.builder(
//                       itemCount: productState.products.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                             title:
//                                 Text(productState.products[index].productName),
//                             subtitle: Text(productState
//                                 .products[index].productDescription),
//                             trailing: IconButton(
//                               onPressed: () {
//                                 ref
//                                     .read(productViewModelProvider.notifier)
//                                     .deleteProduct(productState
//                                         .products[index].productId!);
//                               },
//                               icon: const Icon(Icons.delete),
//                             ));
//                       },
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
