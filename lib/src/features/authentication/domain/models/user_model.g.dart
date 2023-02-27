// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      employeeId: json['employeeId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: json['birthDate'] as String?,
      id: json['id'] as String?,
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
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('id', instance.id);
  writeNotNull('address', instance.address);
  writeNotNull('profilePicLink', instance.profilePicLink);
  val['lat'] = instance.lat;
  val['long'] = instance.long;
  val['canEdit'] = instance.canEdit;
  return val;
}

Map<String, dynamic> _$$_UserDTOToJson(_$_UserDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('employeeId', instance.employeeId);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('id', instance.id);
  writeNotNull('address', instance.address);
  writeNotNull('profilePicLink', instance.profilePicLink);
  val['lat'] = instance.lat;
  val['long'] = instance.long;
  val['canEdit'] = instance.canEdit;
  return val;
}
