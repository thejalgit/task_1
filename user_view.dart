import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/user_controller.dart';
import 'package:task_1/user_provider.dart';
import 'dart:convert';

import 'user_model.dart';
import 'user_provider.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _getCurrentLocation();
  }

  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<UserModel> users = data.map((json) => UserModel.fromJson(json)).toList();

      Provider.of<UserProvider>(context, listen: false).setUsers(users);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition();
    print('Current Location: $position');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User View'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final users = userProvider.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index].name),
                subtitle: Text(users[index].email),
              );
            },
          );
        },
      ),
    );
  }
}
