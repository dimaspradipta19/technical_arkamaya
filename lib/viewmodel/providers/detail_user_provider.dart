import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:technical_arkamaya/model/detail_user_model.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/viewmodel/services/detail_user_service.dart';

class DetailUserProvider with ChangeNotifier {
  DetailUserService service = DetailUserService();
  DetailUserModel? detailUser;
  ResultState state = ResultState.noData;

  Future<void> getDetailUser(int idUser) async {
    try {
      state = ResultState.loading;
      notifyListeners();
      detailUser = await service.getDetailUser(idUser);

      if (detailUser == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
