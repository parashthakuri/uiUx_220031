import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';

class AllProductView extends ConsumerStatefulWidget {
  const AllProductView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllProductViewState();
}

class _AllProductViewState extends ConsumerState<AllProductView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final int _currentIndex = 0;

  List<String> images = [
    "assets/images/carousel1.png",
    "assets/images/carousel2.png",
    "assets/images/carousel3.png",
  ];

  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var dotPosition = 0;
    final productState = ref.watch(productViewModelProvider);
    return NotificationListener(
      onNotification: ((notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(productViewModelProvider.notifier).getAllProduct();
          }
        }
        return true;
      }),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HomeHeader(),
            // Carouselslider(
            //   options: CarouselOptions(
            //     height: screenHeight * 0.2,
            //     initialPage: 0,
            //     aspectRatio: 16 / 9,
            //     viewportFraction: 0.95,
            //     autoPlay: true,
            //     autoPlayInterval: const Duration(seconds: 2),
            //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         _currentIndex = index;
            //         dotPosition = index;
            //       });
            //     },
            //   ),
            //   items: images.map((image) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //           width: screenWidth,
            //           margin: const EdgeInsets.symmetric(horizontal: 5.0),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8.0),
            //             image: DecorationImage(
            //               fit: BoxFit.cover,
            //               image: AssetImage(image),
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // ),
            // SizedBox(
            //   height: screenHeight * 0.02,
            // ),
            // DotsIndicator(Sl
            //   dotsCount: images.isEmpty ? 1 : images.length,
            //   position: dotPosition,
            //   decorator: const DotsDecorator(
            //     activeColor: Color.fromARGB(255, 12, 59, 36),
            //     color: Colors.green,
            //     spacing: EdgeInsets.all(2),
            //     activeSize: Size(8, 8),
            //     size: Size(6, 6),
            //   ),
            // ),
            // SizedBox(
            //   height: screenHeight * 0.03,
            // ),
            // const CategorySection(),
            // const SizedBox(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.03,
                  mainAxisSpacing: screenWidth * 0.03,
                  childAspectRatio: 0.7,
                ),
                itemCount: productState.products.length,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = productState.products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/${index + 1}.png',
                          height: screenWidth * 0.4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Center(
                          child: Text(product.productName,
                              style: Theme.of(context).textTheme.displayMedium),
                        ),
                        SizedBox(height: screenWidth * 0.01),
                        Center(
                          child: Text(
                            product.productPrice.toString(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (productState.isLoading)
              const CircularProgressIndicator(color: Colors.red),
            const SizedBox(
              height: 10,
            )
          ]),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.05,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 224, 223, 223),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const TextField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Search product",
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 24, 66, 25),
                )),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(
                255, 23, 57, 41), // Adjust the color according to your design
          ),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // Add your notification logic here
            },
          ),
        ),
      ]),
    );
  }
}

// class CategorySection extends StatelessWidget {
//   const CategorySection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(screenWidth * 0.03),
//           child: Text(
//             'Categories',
//             style: Theme.of(context).textTheme.displayMedium,
//           ),
//         ),
//         const SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               CategoryCard(
//                   categoryName: 'Hen', imagePath: 'assets/icons/hen.svg'),
//               CategoryCard(
//                   categoryName: 'Buff', imagePath: 'assets/icons/buffalo.svg'),
//               CategoryCard(
//                   categoryName: 'Goat', imagePath: 'assets/icons/goat.svg'),
//               CategoryCard(
//                   categoryName: 'Seafood',
//                   imagePath: 'assets/icons/sausage.svg'),
//               // Add more CategoryCard widgets as needed
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final String productName;
//   final String price;
//   final String imagePath;

//   const ProductCard(
//       {super.key,
//       required this.productName,
//       required this.price,
//       required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//       margin: EdgeInsets.all(screenWidth * 0.03),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             imagePath,
//             height: screenWidth * 0.4,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           SizedBox(height: screenWidth * 0.02),
//           Center(
//             child: Text(productName,
//                 style: Theme.of(context).textTheme.displayMedium),
//           ),
//           SizedBox(height: screenWidth * 0.01),
//           Center(
//             child: Text(
//               '\$$price',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;

  const CategoryCard(
      {super.key, required this.categoryName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: const Color(0xFF7ED957),
      elevation: 0,
      margin: EdgeInsets.all(screenWidth * 0.03),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          children: [
            SvgPicture.asset(
              imagePath,
              height: screenWidth * 0.12,
              width: screenWidth * 0.12,
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              categoryName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
