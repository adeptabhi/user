import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/module/user/model/user_mdl.dart';
import 'package:user/module/user/provider/user_provider.dart';
import 'package:user/module/user/widget/user_card.dart';
import 'package:user/routes/routes_name.dart';
import 'package:user/util/widget/custom_textfield.dart';
import 'package:user/util/widget/data_state_widget.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider.refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: CustomTextField(
              controller: userProvider.searchCon,
              hintText: 'Search',
              onChanged: userProvider.onSearch,
              prefixIcon: Icon(Icons.search),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              key: userProvider.refreshKey,
              onRefresh: userProvider.getData,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double height = constraints.maxHeight;
                  return Selector<UserProvider, List<UserMdl>>(
                    selector: (context, p) => p.usersFilter,
                    builder: (context, users, _) {
                      return users.isEmpty
                          ? DataStateWidget(
                              userProvider.isLoading
                                  ? "Loading..."
                                  : "No Users Found",
                              height: height,
                            )
                          : ListView.builder(
                              controller: userProvider.scrollController,
                              itemCount: users.length + 1,
                              itemBuilder: (context, index) {
                                return index == users.length
                                    ? Selector<UserProvider, bool>(
                                        builder: (context, isLoading, w) {
                                          return isLoading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : SizedBox.shrink();
                                        },
                                        selector: (s, p) => p.isLoading,
                                      )
                                    : UserCard(
                                        user: users[index],
                                        key: ValueKey(users[index].id),
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          RoutesName.userDetail,
                                          arguments: users[index],
                                        ),
                                      );
                              },
                            );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
