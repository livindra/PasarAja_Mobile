import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pasaraja_mobile/core/constants/constants.dart';
import 'package:pasaraja_mobile/core/sources/data_state.dart';
import 'package:pasaraja_mobile/module/auth/models/user_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class SignInController {
  final Dio _dio = Dio();
  final String _signInRoute = '${PasarAjaConstant.baseUrl}/auth/signin';

  /// login dengan google
  Future<DataState> signInGoogle({
    required String email,
  }) async {
    try {
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            // All http request & responses enabled for console logging
            printResponseData: false,
            printRequestData: false,
            // Request & Reposnse logs including http - headers
            printResponseHeaders: false,
            printRequestHeaders: false,
            // Request logs with response message
            printResponseMessage: false,
          ),
        ),
      );
      // send request
      final response = await _dio.post(
        "$_signInRoute/google",
        data: {
          "email": email,
        },
        options: Options(
          // accepted status
          validateStatus: (status) {
            return status == HttpStatus.ok || status == HttpStatus.badRequest;
          },
        ),
      );

      // get payload
      final Map<String, dynamic> payload = response.data;

      if (response.statusCode == HttpStatus.ok) {
        // jika success maka akan mengembalikan data dari reponse
        return DataSuccess(UserModel.fromJson(payload['data']));
      } else {
        // jika gagal maka akan mengembalikan pesan error
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: payload['message'],
          ),
        );
      }
    } on DioException catch (error) {
      return DataFailed(error);
    }
  }

  /// login dengan email
  Future<DataState<UserModel>> signInEmail({
    required String email,
    required String password,
  }) async {
    try {
      // send request
      final response = await _dio.post(
        "$_signInRoute/email",
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          validateStatus: (status) {
            return status == HttpStatus.ok || status == HttpStatus.badRequest;
          },
        ),
      );

      // get payload
      final Map<String, dynamic> payload = response.data;

      if (response.statusCode == HttpStatus.ok) {
        // jika login berhasil
        return DataSuccess(UserModel.fromJson(payload['data']));
      } else {
        // jika login gagal
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: payload['message'],
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }

  /// login dengan nomor hp
  Future<DataState<UserModel>> signInPhone({
    required String phone,
    required String pin,
  }) async {
    try {
      // send request
      final response = await _dio.post(
        "$_signInRoute/phone",
        data: {
          "phone_number": phone,
          "pin": pin,
        },
        options: Options(
          validateStatus: (status) {
            return status == HttpStatus.ok || status == HttpStatus.badRequest;
          },
        ),
      );

      // get payload
      final Map<String, dynamic> payload = response.data;

      if (response.statusCode == HttpStatus.ok) {
        // jika login berhasil
        return DataSuccess(UserModel.fromJson(payload['data']));
      } else {
        // jika login gagal
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: payload['message'],
          ),
        );
      }
    } on DioException catch (ex) {
      return DataFailed(ex);
    }
  }
}

void main(List<String> args) async {
  DataState dataState =
      await SignInController().signInGoogle(email: 'hakiahmad756@gmail.comsd');

  if (dataState is DataSuccess) {
    //
    print('login berhasil');
  }

  if (dataState is DataFailed) {
    print(dataState.error!.error);
  }
}