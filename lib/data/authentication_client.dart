

import 'dart:async';
import 'dart:convert';

import 'package:flutter_rest_api/api/authentication_api.dart';
import 'package:flutter_rest_api/models/authentication_response.dart';
import 'package:flutter_rest_api/models/sesion.dart';
import 'package:flutter_rest_api/utils/logs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationClient{

  final FlutterSecureStorage _secureStorage;
  final AuthenticationAPI _authenticationAPI;

  Completer?   _completer;

  AuthenticationClient(this._authenticationAPI, {required FlutterSecureStorage secureStorage}) : _secureStorage = secureStorage;

  void _complete(){
    if(_completer != null && !_completer!.isCompleted){
      _completer!.complete();
    }
  }


  Future<String?> get accessToken async{
    if(_completer != null){
     await  _completer!.future;
    }

    _completer = Completer();
    
   final data = await  _secureStorage.read(key: 'SESSION');
   if(data != null){
    final sesion = Sesion.fromJson(jsonDecode(data));

  final DateTime currentDate = DateTime.now();
  final DateTime createdAt = sesion.createdAt;
  final int expiresIn = sesion.expiresIn;
  final int diff = currentDate.difference(createdAt).inSeconds;

//Este es para saber si cumple la condicion si no se refescara el token
  if(expiresIn-diff >= 60){
    _complete();
   return sesion.token;
  }
  final response = await _authenticationAPI.refreshToken(sesion.token);
  if(response.data != null){
   await saveSession(response.data!);
   _complete();
   return response.data!.token;//retorna el nuevo token
  }
    _complete();
    return null;

   }
   _complete();
   return null;
  }

  Future<void> saveSession(AuthenticationResponse authenticationResponse) async{
    final Sesion sesion = Sesion(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createdAt: DateTime.now(),
      );

    final data = jsonEncode(sesion.toJson());
   await  _secureStorage.write(key: 'SESSION', value: data);
  }

    Future<void> signOut() async{
    await  _secureStorage.deleteAll();

  }
}