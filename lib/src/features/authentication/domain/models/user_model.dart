import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../app/constants/user_role.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@JsonSerializable()
class UserDTO with _$UserDTO {
  const factory UserDTO({
    String? employeeId,
    UserRole? userRole,
    String? uID,
    String? email,
    String? fullName,
    String? birthDate,
    String? address,
    String? profilePicLink,
    double? lat,
    double? long,
    @Default(false) bool canEdit,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
