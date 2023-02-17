import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@JsonSerializable()
class User with _$User {
  const factory User({
    String? employeeId,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? id,
    String? address,
    String? profilePicLink,
    @Default(0) double lat,
    @Default(0) double long,
    @Default(false) bool canEdit,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
