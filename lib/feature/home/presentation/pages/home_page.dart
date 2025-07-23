import 'package:fe_astronacci/feature/home/presentation/widgets/user_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/home_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/detail_page.dart';
import 'package:fe_astronacci/feature/home/presentation/widgets/contract_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchUsers();
  }

  Future<void> _loadMore() async {
    final currentState = context.read<HomeCubit>().state;
    if (currentState is HomeLoaded && !currentState.isLoadingMore) {
      await context.read<HomeCubit>().fetchUsers(isInitial: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.primaryRed,
        foregroundColor: CommonColors.white,
        title: const Text('People'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    UserSearchDelegate(homeCubit: context.read<HomeCubit>()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          if (state is HomeInitial) {
            return _buildShimmerLoading();
          } else if (state is HomeLoading) {
            return _buildShimmerLoading();
          } else if (state is HomeSearching) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeSearchResult) {
            return _buildSearchResults(state.users);
          } else if (state is HomeLoaded) {
            return _buildUserList(state);
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: CommonColors.fieldBackground,
        highlightColor: CommonColors.softRed,
        child: const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading:
              CircleAvatar(radius: 28, backgroundColor: CommonColors.white),
          title: SizedBox(
            height: 16,
            width: double.infinity,
            child: DecoratedBox(
                decoration: BoxDecoration(color: CommonColors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<UserEntity> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final u = users[index];
        return ContactCard(
          name: u.name,
          email: u.email,
          image: u.avatar!,
          isActive: index.isEven,
          press: () => _navigateToDetailPage(u),
          heroTag: 'avatar-${u.id}-search',
        );
      },
    );
  }

  Widget _buildUserList(HomeLoaded state) {
    return LazyLoadScrollView(
      onEndOfPage: _loadMore,
      isLoading: !state.hasMore ? false : false,
      child: ListView.separated(
        itemCount: state.users.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, __) => Divider(height: 0),
        itemBuilder: (context, index) {
          if (index >= state.users.length) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final u = state.users[index];
          return ContactCard(
            name: u.name,
            email: u.email,
            image: u.avatar!,
            isActive: index.isEven,
            press: () => _navigateToDetailPage(u),
            heroTag: 'avatar-${u.id}',
          );
        },
      ),
    );
  }

  void _navigateToDetailPage(UserEntity user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(user: user),
      ),
    );
  }
}
