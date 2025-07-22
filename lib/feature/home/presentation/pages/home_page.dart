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
        backgroundColor: CommonColors.primaryBlue,
        foregroundColor: CommonColors.white,
        title: const Text('People'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          if (state is HomeInitial) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (_, __) => Shimmer.fromColors(
                baseColor: CommonColors.fieldBackground,
                highlightColor: CommonColors.softBlue,
                child: const ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                      radius: 28, backgroundColor: CommonColors.white),
                  title: SizedBox(
                      height: 16,
                      width: double.infinity,
                      child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: CommonColors.white))),
                  subtitle: SizedBox(
                      height: 14,
                      width: 100,
                      child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: CommonColors.white))),
                ),
              ),
            );
          } else if (state is HomeLoaded) {
            return LazyLoadScrollView(
              onEndOfPage: _loadMore,
              isLoading: !state.hasMore ? false : false,
              child: ListView.separated(
                itemCount: state.users.length + (state.hasMore ? 1 : 0),
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  if (index >= state.users.length) {
                    return const Padding(
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
                    press: () {
                      _navigateToDetailPage(u);
                    },
                    heroTag: 'avatar-${u.id}',
                  );
                },
              ),
            );
          } else if (state is HomeError) {
            return Center(
                child: Text(
              'Error: ${state.message}',
              style: TextStyle(color: CommonColors.black),
            ));
          }
          return const SizedBox.shrink();
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
