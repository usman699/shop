import 'dart:convert';
import 'package:flutter_complete_guide/model/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class Auth with ChangeNotifier  {

  // String _token;
  // String expiryDate;
  // String _UserId;
  Future<void> SignUp (String email, String password) async{
    print(email);
    print(password);
    const url=   'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAj3EMceJXUQJTgnr84Hda_x9qXKyqSYaE';
    var response=  await  http.post(Uri.parse(url),body: json.encode(
           {
           'email':email,
           'password':password,
           'returnSecureToken':true
           }
       ));
    print(json.decode(response.body));
  }



Future<void> login (String email, String password) async{

  const url=   'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAj3EMceJXUQJTgnr84Hda_x9qXKyqSYaE';
try{
  var response=  await  http.post(Uri.parse(url),body: json.encode(
      {
        'email':email,
        'password':password,
        'returnSecureToken':true
      }
  ));
  var responseData =json.decode(response.body);
  if(responseData['error'] !=null){
    throw HttpException(responseData['error']['message']);
  }
  }
  catch(eror){
  throw(eror);
  }

}
}
