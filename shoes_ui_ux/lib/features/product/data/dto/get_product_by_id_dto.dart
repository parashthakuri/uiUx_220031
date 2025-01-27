import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/product/data/model/product_api_model.dart';

part 'get_product_by_id_dto.g.dart';

@JsonSerializable()
class GetProductByIdDTO {
  final bool success;
  final String message;
  final ProductAPIModel product;

  GetProductByIdDTO({
    required this.success,
    required this.message,
    required this.product,
  });

  factory GetProductByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetProductByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductByIdDTOToJson(this);
}
