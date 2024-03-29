import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:client_it/feature/auth/domain/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_entity/user_entity.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

part 'auth_cubit.g.dart';

@Singleton()
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorized());
  final AuthRepository authRepository;

  Future<void> signIn(
      {required String password, required String username}) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity =
          await authRepository.signIn(password: password, username: username);
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> signUp(
      {required String password,
      required String username,
      required String email}) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.signUp(
          password: password, username: username, email: email);
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> refreshToken() async {
    final refreshToken =
        state.whenOrNull(authorized: (userEntity) => userEntity.refreshToken);
    try {
      final UserEntity userEntity =
          await authRepository.refreshToken(refreshToken: refreshToken);
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> getProfile() async {
    try {
      _updateUserStata( const AsyncSnapshot.waiting());
     // await Future.delayed(const Duration(seconds: 1));
      final UserEntity newUserEntity = await authRepository.getProfile();
      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
            email: newUserEntity.email, username: newUserEntity.username)),
      ));
      _updateUserStata(const AsyncSnapshot.withData(ConnectionState.done, 'Успешное получение данных'));
    } catch (error) {
    _updateUserStata(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  void logOut() => emit(AuthState.notAuthorized());
 //метод извлечения состаяния авторизации
  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
        authorized: (userEntity) => AuthState.authorized(userEntity));
  }
  //метод сохранения состояния авторизации
  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
                authorized: (userEntity) => AuthState.authorized(userEntity))
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }

  Future<void> userUpdate({String? username, String? email}) async {
    try {
      _updateUserStata( const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
       final bool isEmptyEmail = email?.trim().isEmpty == true;
       final bool isEmptyUsername = username?.trim().isEmpty == true;
      final UserEntity newUserEntity = await authRepository.userUpdate(
           username: isEmptyUsername ? null : username,
           email: isEmptyEmail ? null : email
         // username: username, email: email
        );
      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
            email: newUserEntity.email, username: newUserEntity.username)),
      ));
      _updateUserStata(const AsyncSnapshot.withData(ConnectionState.done,'Успешное обновления данных'));
    } catch (error) {
      _updateUserStata(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  Future<void> passwordUpdate({required String oldPassword,required String newPassword}) async {
    try {
      _updateUserStata( const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      if(newPassword.trim().isEmpty == true){
        throw ErrorEntity(message: 'Новый пороль пустой');
      }

      final message = await authRepository.passwordUpdate(
          oldPassword: oldPassword,
          newPassword: newPassword);

      _updateUserStata(AsyncSnapshot.withData(ConnectionState.done, message));
    } catch (error) {
      _updateUserStata(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }
  void _updateUserStata(AsyncSnapshot asyncSnapshot){
    emit(state.maybeWhen(orElse: () => state,
      authorized: (userEntity) {
        return AuthState.authorized(userEntity.copyWith(userState: asyncSnapshot));
      },
    ));
  }
}
