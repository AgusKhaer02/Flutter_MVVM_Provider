import 'package:flutter/material.dart';
import 'package:try_mvvm_provider/components/app_loading.dart';
import 'package:try_mvvm_provider/components/app_title.dart';
import 'package:try_mvvm_provider/users_list/models/users_list_model.dart';
import 'package:try_mvvm_provider/users_list/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel usersViewModel = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text("try MVVM with Provider"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _ui(usersViewModel),
          ],
        ),
      ),
    );
  }

  _ui(UserViewModel usersViewModel) {
    if (usersViewModel.loading) {
      return AppLoading();
    }
    if (usersViewModel.userError != null) {
      return Container(
        child: Text("Error!"),
      );
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = usersViewModel.userListModel[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppTitle(
                  text: userModel.name!,
                ),
                Text(userModel.email!),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }
}
