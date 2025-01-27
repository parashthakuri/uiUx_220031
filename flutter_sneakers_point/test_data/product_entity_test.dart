import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

Future<List<ProductEntity>> getAllProductTest() async {
  final response =
      await rootBundle.loadString('test_data/product_test_data.json');
  final jsonList = await json.decode(response);
  final List<ProductEntity> productList = jsonList
      .map<ProductEntity>(
        (json) => ProductEntity.fromJson(json),
      )
      .toList();

  return Future.value(productList);
}
