import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:technical_arkamaya/model/add_user_model.dart';

class AddUserService {
  Future<AddUserModel?> addUserModel(String name, String job) async {
    Dio dio = Dio();
    final String url = "https://reqres.in/api/users?name=$name&job=$job";
    try {
      var response = await dio.post(url);
      if (response.statusCode == 201) {
        return AddUserModel.fromJson(response.data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
