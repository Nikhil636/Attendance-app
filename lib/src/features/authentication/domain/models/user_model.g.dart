// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      employeeId: json['employeeId'] as String?,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      uID: json['uID'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      birthDate: json['birthDate'] as String?,
      address: json['address'] as String?,
      profilePicLink: json['profilePicLink'] as String?,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
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
  val['userType'] = _$UserTypeEnumMap[instance.userType]!;
  writeNotNull('uID', instance.uID);
  writeNotNull('email', instance.email);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('address', instance.address);
  writeNotNull('profilePicLink', instance.profilePicLink);
  val['lat'] = instance.lat;
  val['long'] = instance.long;
  val['canEdit'] = instance.canEdit;
  return val;
}

const _$UserTypeEnumMap = {
  UserType.admin: 'admin',
  UserType.employee: 'employee',
};

Map<String, dynamic> _$$_UserDTOToJson(_$_UserDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employeeId', instance.employeeId);
  val['userType'] = _$UserTypeEnumMap[instance.userType]!;
  writeNotNull('uID', instance.uID);
  writeNotNull('email', instance.email);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('address', instance.address);
  writeNotNull('profilePicLink', instance.profilePicLink);
  val['lat'] = instance.lat;
  val['long'] = instance.long;
  val['canEdit'] = instance.canEdit;
  return val;
}
