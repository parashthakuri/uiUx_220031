import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/features/auth/presentation/view_model/auth_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers here
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(authViewModelProvider);
    final user = profileState.user;

    // Set the controller texts after the build method is called
    _emailController.text = user?.email ?? '';
    _firstNameController.text = user?.firstName ?? '';
    _lastNameController.text = user?.lastName ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              readOnly: true,
              controller: _emailController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
              controller: _firstNameController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
              controller: _lastNameController,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Call method to update profile in AuthViewModel
                ref.read(authViewModelProvider.notifier).updateProfile(
                      context,
                      _emailController.text,
                      _firstNameController.text,
                      _lastNameController.text,
                      user?.userId ?? '',
                    );
              },
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
