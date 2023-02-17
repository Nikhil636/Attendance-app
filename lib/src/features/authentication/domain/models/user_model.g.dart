// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
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

Map<String, dynamic> _$UserToJson(User instance) {
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

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      employeeId: json['employeeId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: json['birthDate'] as String?,
      id: json['id'] as String?,
      address: json['address'] as String?,
      profilePicLink: json['profilePicLink'] as String?,
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      long: (json['long'] as num?)?.toDouble() ?? 0,
      canEdit: json['canEdit'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) {
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
