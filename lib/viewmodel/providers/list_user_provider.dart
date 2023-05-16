import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:technical_arkamaya/model/list_user_model.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/viewmodel/services/list_user_service.dart';

class ListUserProvider with ChangeNotifier {
  ListUserService service = ListUserService();
  ListUserModel? listUser;
  ResultState state = ResultState.noData;

  Future<void> getListUser() async {
    try {
      state = ResultState.loading;
      notifyListeners();

      listUser = await service.getListUser();
      if (listUser == null) {
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
