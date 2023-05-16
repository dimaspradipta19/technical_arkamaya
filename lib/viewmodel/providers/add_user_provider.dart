import 'package:flutter/material.dart';
import 'package:technical_arkamaya/model/add_user_model.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/viewmodel/services/add_user_service.dart';

class AddUserProvider with ChangeNotifier {
  AddUserService service = AddUserService();
  AddUserModel? addUserModel;
  ResultState state = ResultState.noData;

  Future<void> postAddUser(String name, String job) async {
    state = ResultState.loading;
    notifyListeners();

    addUserModel = await service.addUserModel(name, job);
    if (addUserModel == null) {
      state = ResultState.noData;
      notifyListeners();
    } else {
      state = ResultState.hasData;
      notifyListeners();
    }
    notifyListeners();
  }
}
