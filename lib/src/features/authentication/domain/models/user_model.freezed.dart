// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) {
  return _UserDTO.fromJson(json);
}

/// @nodoc
mixin _$UserDTO {
  String? get employeeId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get birthDate => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get profilePicLink => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get long => throw _privateConstructorUsedError;
  bool get canEdit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDTOCopyWith<UserDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDTOCopyWith<$Res> {
  factory $UserDTOCopyWith(UserDTO value, $Res Function(UserDTO) then) =
      _$UserDTOCopyWithImpl<$Res, UserDTO>;
  @useResult
  $Res call(
      {String? employeeId,
      String? firstName,
      String? lastName,
      String? birthDate,
      String? id,
      String? address,
      String? profilePicLink,
      double lat,
      double long,
      bool canEdit});
}

/// @nodoc
class _$UserDTOCopyWithImpl<$Res, $Val extends UserDTO>
    implements $UserDTOCopyWith<$Res> {
  _$UserDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? birthDate = freezed,
    Object? id = freezed,
    Object? address = freezed,
    Object? profilePicLink = freezed,
    Object? lat = null,
    Object? long = null,
    Object? canEdit = null,
  }) {
    return _then(_value.copyWith(
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicLink: freezed == profilePicLink
          ? _value.profilePicLink
          : profilePicLink // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDTOCopyWith<$Res> implements $UserDTOCopyWith<$Res> {
  factory _$$_UserDTOCopyWith(
          _$_UserDTO value, $Res Function(_$_UserDTO) then) =
      __$$_UserDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? employeeId,
      String? firstName,
      String? lastName,
      String? birthDate,
      String? id,
      String? address,
      String? profilePicLink,
      double lat,
      double long,
      bool canEdit});
}

/// @nodoc
class __$$_UserDTOCopyWithImpl<$Res>
    extends _$UserDTOCopyWithImpl<$Res, _$_UserDTO>
    implements _$$_UserDTOCopyWith<$Res> {
  __$$_UserDTOCopyWithImpl(_$_UserDTO _value, $Res Function(_$_UserDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? birthDate = freezed,
    Object? id = freezed,
    Object? address = freezed,
    Object? profilePicLink = freezed,
    Object? lat = null,
    Object? long = null,
    Object? canEdit = null,
  }) {
    return _then(_$_UserDTO(
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicLink: freezed == profilePicLink
          ? _value.profilePicLink
          : profilePicLink // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double,
      canEdit: null == canEdit
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDTO implements _UserDTO {
  const _$_UserDTO(
      {this.employeeId,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.id,
      this.address,
      this.profilePicLink,
      this.lat = 0,
      this.long = 0,
      this.canEdit = false});

  factory _$_UserDTO.fromJson(Map<String, dynamic> json) =>
      _$$_UserDTOFromJson(json);

  @override
  final String? employeeId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? birthDate;
  @override
  final String? id;
  @override
  final String? address;
  @override
  final String? profilePicLink;
  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double long;
  @override
  @JsonKey()
  final bool canEdit;

  @override
  String toString() {
    return 'UserDTO(employeeId: $employeeId, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, id: $id, address: $address, profilePicLink: $profilePicLink, lat: $lat, long: $long, canEdit: $canEdit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDTO &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.profilePicLink, profilePicLink) ||
                other.profilePicLink == profilePicLink) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.long, long) || other.long == long) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, employeeId, firstName, lastName,
      birthDate, id, address, profilePicLink, lat, long, canEdit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDTOCopyWith<_$_UserDTO> get copyWith =>
      __$$_UserDTOCopyWithImpl<_$_UserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDTOToJson(
      this,
    );
  }
}

abstract class _UserDTO implements UserDTO {
  const factory _UserDTO(
      {final String? employeeId,
      final String? firstName,
      final String? lastName,
      final String? birthDate,
      final String? id,
      final String? address,
      final String? profilePicLink,
      final double lat,
      final double long,
      final bool canEdit}) = _$_UserDTO;

  factory _UserDTO.fromJson(Map<String, dynamic> json) = _$_UserDTO.fromJson;

  @override
  String? get employeeId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get birthDate;
  @override
  String? get id;
  @override
  String? get address;
  @override
  String? get profilePicLink;
  @override
  double get lat;
  @override
  double get long;
  @override
  bool get canEdit;
  @override
  @JsonKey(ignore: true)
  _$$_UserDTOCopyWith<_$_UserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
