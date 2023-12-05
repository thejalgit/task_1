import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/view_page/userdetails.dart';
import 'package:tasks/view/userdetailsview.dart';

import '../controller/usercontroller.dart';
import '../user_controller.dart';

class UserViewClass extends StatelessWidget {
  const UserViewClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserController>(context, listen: false);
    userProvider.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UserList View',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Consumer<UserController>(
        builder: (context, userController, child) {
          if (userController?.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.lightGreen,
              ),
            );
          } else {
            return ListView.builder(
                itemCount: userController?.userList.length,
                itemBuilder: (context, index) {
                  final user = userController?.userList[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetailsClass(
                                  user: user,
                                )));
                      },
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
