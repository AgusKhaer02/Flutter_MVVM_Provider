import 'package:flutter/material.dart';
import 'package:try_mvvm_provider/users_list/models/UserError.dart';
import 'package:try_mvvm_provider/users_list/models/users_list_model.dart';
import 'package:try_mvvm_provider/users_list/repo/api_status.dart';
import 'package:try_mvvm_provider/users_list/repo/user_service.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userListModel = [];
  UserError? _userError;

  bool get loading => _loading;

  List<UserModel> get userListModel => _userListModel;

  UserError? get userError => _userError;

  UserViewModel(){
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsers();
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    } else if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );

      setUserError(userError);
    }
    setLoading(false);
  }
}
