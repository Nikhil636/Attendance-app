import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../app/constants/user_type.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed(fromJson: false)
@JsonSerializable(includeIfNull: false)
class UserDTO with _$UserDTO {
  const factory UserDTO({
    String? employeeId,
    @Default(UserType.employee) UserType userType,
    String? uID,
    String? email,
    String? fullName,
    String? birthDate,
    String? address,
    String? profilePicLink,
    @Default(0) double lat,
    @Default(0) double long,
    @Default(false) bool canEdit,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}
