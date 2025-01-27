import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/auth/data/model/auth_api_model.dart';

part 'get_user_by_id_dto.g.dart';

@JsonSerializable()
class GetUserByIdDTO {
  final bool success;
  final String message;
  final AuthAPIModel user;

  GetUserByIdDTO({
    required this.success,
    required this.message,
    required this.user,
  });

  factory GetUserByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserByIdDTOToJson(this);
}
