import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/cart/data/model/cart_api_model.dart';

part 'get_cart_by_user_dto.g.dart';

@JsonSerializable()
class GetCartByUserDTO {
  final bool success;
  final String message;
  final CartAPIModel cart;

  GetCartByUserDTO({
    required this.success,
    required this.message,
    required this.cart,
  });

  factory GetCartByUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetCartByUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetCartByUserDTOToJson(this);
}
