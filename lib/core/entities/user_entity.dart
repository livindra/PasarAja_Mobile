import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? idUser;
  final String? phoneNumber;
  final String? email;
  final String? fullName;
  final String? password;
  final String? pin;
  final String? level;
  final bool? isVerified;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;

  const UserEntity({
    this.idUser,
    this.phoneNumber,
    this.email,
    this.fullName,
    this.password,
    this.pin,
    this.level,
    this.isVerified,
    this.photo,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      idUser,
      phoneNumber,
      email,
      fullName,
      password,
      level,
      isVerified,
      photo,
      createdAt,
      updatedAt,
    ];
  }
}
