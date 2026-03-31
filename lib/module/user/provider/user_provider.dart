import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user/api/api_client.dart';
import 'package:user/api/api_sync.dart';
import 'package:user/local_db/db.dart';
import 'package:user/local_db/db_table_name.dart';
import 'package:user/module/user/model/user_mdl.dart';

class UserProvider extends ChangeNotifier {
  final BuildContext context;
  UserProvider({required this.context}) {
    scrollController.addListener(scrollListener);
  }

  List<UserMdl> users = [];
  List<UserMdl> usersFilter = [];
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  TextEditingController searchCon = TextEditingController();
  ScrollController scrollController = ScrollController();
  int perPage = 6;
  int _currentPage = 0;
  bool hasMore = true;
  ApiSync apiSync = ApiSync();
  ApiClient client = ApiClient();
  Timer? _debounce;
  bool isLoading = true;

  Future<void> getData() async {
    await apiSync.users(client);
    _resetPagination();
    getUserData();
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoading &&
        hasMore) {
      getUserData();
    }
  }

  void _resetPagination() {
    _currentPage = 0;
    users = [];
    usersFilter = [];
    hasMore = true;
  }

  void getUserData() async {
    isLoading = true;
    searchCon.clear();
    notifyListeners();
    final data = await DB.inst.select(
      tableName: DBTableName.users,
      page: _currentPage,
      limit: perPage,
    );
    var usersTemp = data.map((e) => UserMdl.fromJson(e)).toList();
    users.addAll(usersTemp);
    usersFilter = [...users];
    _currentPage++;
    if (users.length < perPage) hasMore = false;
    isLoading = false;
    notifyListeners();
  }

  void onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _filterUsers();
    });
  }

  void _filterUsers() {
    String query = searchCon.text;
    if (query.isEmpty) {
      usersFilter = users;
    } else {
      usersFilter = users
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    searchCon.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
