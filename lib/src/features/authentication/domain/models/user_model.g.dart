// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      employeeId: json['employeeId'] as String?,
      userRole: $enumDecodeNullable(_$UserRoleEnumMap, json['userRole']),
      uID: json['uID'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      birthDate: json['birthDate'] as String?,
      address: json['address'] as String?,
      profilePicLink: json['profilePicLink'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      canEdit: json['canEdit'] as bool,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employeeId', instance.employeeId);
  writeNotNull('userRole', _$UserRoleEnumMap[instance.userRole]);
  writeNotNull('uID', instance.uID);
  writeNotNull('email', instance.email);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('address', instance.address);
  writeNotNull('profilePicLink', instance.profilePicLink);
  writeNotNull('lat', instance.lat);
  writeNotNull('long', instance.long);
  val['canEdit'] = instance.canEdit;
  return val;
}

const _$UserRoleEnumMap = {
  UserRole.Admin: 'Admin',
  UserRole.Employee: 'Employee',
};

Map<String, dynamic> _$$_UserDTOToJson(_$_UserDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employeeId', instance.employeeId);
  writeNotNull('userRole', _$UserRoleEnumMap[instance.userRole]);
  writeNotNull('uID', instance.uID);
  writeNotNull('email', instance.email);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('address', instance.address);
  writeNotNull('profilePicLink', instance.profilePicLink);
  writeNotNull('lat', instance.lat);
  writeNotNull('long', instance.long);
  val['canEdit'] = instance.canEdit;
  return val;
}
