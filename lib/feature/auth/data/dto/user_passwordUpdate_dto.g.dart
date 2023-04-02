// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_passwordUpdate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPasswordUpdateDto _$UserPasswordUpdateDtoFromJson(
        Map<String, dynamic> json) =>
    UserPasswordUpdateDto(
      error: json['error'],
      data: json['data'],
      message: json['message'],
    );

Map<String, dynamic> _$UserPasswordUpdateDtoToJson(
        UserPasswordUpdateDto instance) =>
    <String, dynamic>{
      'error': instance.error,
      'data': instance.data,
      'message': instance.message,
    };
