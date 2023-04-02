import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_passwordUpdate_dto.g.dart';

@JsonSerializable()
class UserPasswordUpdateDto {
  final dynamic error;
  final dynamic data;
  final dynamic message;

  UserPasswordUpdateDto(
      {this.error,
        this.data,
        this.message});

  factory UserPasswordUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$UserPasswordUpdateDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserPasswordUpdateDtoToJson(this);

  ErrorEntity toErrorEntity() {
    return ErrorEntity(
      message: message.toString(),
      errorMessage: error.toString(),

    );
  }
  UserPasswordUpdateDto toUserPasswordEntity() {
    return UserPasswordUpdateDto(
      message: message.toString(),
      error: error.toString(),
      data: data.toString()

    );
  }
}