import 'package:flutter/material.dart';
import 'package:mysql_backend/models/user.dart';
import 'package:mysql_backend/viewmodels/edit_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  final User user;

  EditProfilePage(this.user);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.text = user.email;
    _phoneController.text = user.phone;

    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Profile')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 20),
              Consumer<EditProfileViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    children: <Widget>[
                      if (viewModel.isUpdated)
                        Text(
                          'Profile updated successfully',
                          style: TextStyle(color: Colors.green),
                        ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await viewModel.updateProfile(
                            user.id,
                            _emailController.text,
                            _phoneController.text,
                          );
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
