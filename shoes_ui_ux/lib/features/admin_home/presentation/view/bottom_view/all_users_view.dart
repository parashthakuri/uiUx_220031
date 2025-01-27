import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';
import 'package:sneakers_point/features/auth/presentation/view_model/auth_view_model.dart';

class AllUserView extends ConsumerStatefulWidget {
  const AllUserView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllUserViewState();
}

class _AllUserViewState extends ConsumerState<AllUserView> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Customers'),
          elevation: 0, // Remove app bar shadow
          automaticallyImplyLeading: false),
      body: _buildUserList(userState.users),
    );
  }

  Widget _buildUserList(List<AuthEntity>? users) {
    if (users == null || users.isEmpty) {
      return const Center(
        child: Text(
          'No users found.',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          elevation: 2, // Add elevation for card effect
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              user.email,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            // Add more information as needed
            // onTap: () => _handleUserTap(user), // Implement onTap if needed
          ),
        );
      },
    );
  }
}
