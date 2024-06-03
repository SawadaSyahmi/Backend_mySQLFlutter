import 'package:flutter/material.dart';
import 'package:mysql_backend/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: <Widget>[
                    if (viewModel.errorMessage != null)
                      Text(
                        viewModel.errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await viewModel.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        if (viewModel.user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(viewModel.user!.id),
                            ),
                          );
                        }
                      },
                      child: Text('Login'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
