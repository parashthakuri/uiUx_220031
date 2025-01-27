import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/auth/data/model/auth_api_model.dart';

part 'get_all_user_dto.g.dart';

@JsonSerializable()
class GetAllUserDTO {
  final bool success;
  final List<AuthAPIModel> users;

  GetAllUserDTO({
    required this.success,
    required this.users,
  });

  Map<String, dynamic> toJson() => _$GetAllUserDTOToJson(this);

  factory GetAllUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllUserDTOFromJson(json);
}
