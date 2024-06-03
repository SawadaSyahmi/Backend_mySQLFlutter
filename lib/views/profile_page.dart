// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mysql_backend/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  final int userId;

  ProfilePage(this.userId);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..fetchProfile(userId),
      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text('Username: ${viewModel.user!.username}'),
                  Text('Email: ${viewModel.user!.email}'),
                  Text('Phone: ${viewModel.user!.phone}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(viewModel.user!),
                        ),
                      );
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
