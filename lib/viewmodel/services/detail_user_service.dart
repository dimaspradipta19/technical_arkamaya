import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:technical_arkamaya/model/detail_user_model.dart';

class DetailUserService {
  Future<DetailUserModel?> getDetailUser(int idUser) async {
    try {
      final String url = "https://reqres.in/api/users/$idUser";
      Dio dio = Dio();

      var response = await dio.get(url);
      if (response.statusCode == 200) {
        return DetailUserModel.fromJson(response.data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
