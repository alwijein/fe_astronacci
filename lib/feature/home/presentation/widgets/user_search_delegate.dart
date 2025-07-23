import 'package:fe_astronacci/feature/home/presentation/cubits/home_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/detail_page.dart';
import 'package:fe_astronacci/feature/home/presentation/widgets/contract_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearchDelegate extends SearchDelegate {
  final HomeCubit homeCubit;

  UserSearchDelegate({required this.homeCubit});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          homeCubit.fetchUsers(isInitial: true);

          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    homeCubit.searchUsers(query);
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        homeCubit.fetchUsers(isInitial: true);
        query = '';
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          if (state is HomeSearching) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeSearchResult) {
            if (state.users.isEmpty) {
              return Center(child: Text('No users found'));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final u = state.users[index];
                return ContactCard(
                  name: u.name,
                  email: u.email,
                  image: u.avatar!,
                  isActive: index.isEven,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(user: u),
                      ),
                    );
                  },
                  heroTag: 'avatar-${u.id}-search',
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Start typing to search'));
        },
      ),
    );
  }
}
