import 'dart:developer';

import '../../model/list_user_model.dart';
import 'package:dio/dio.dart';

class ListUserService {
  Future<ListUserModel?> getListUser() async {
    try {
      const String url = "https://reqres.in/api/users";
      Dio dio = Dio();

      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return ListUserModel.fromJson(response.data);
      } else {
        throw Exception("Error : ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
