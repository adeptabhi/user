import 'package:adept_log/view/adept_log.dart';
import 'package:user/api/api_client.dart';
import 'package:user/api/api_manager.dart';
import 'package:user/local_db/db.dart';
import 'package:user/local_db/db_table_name.dart';
import 'package:user/module/user/model/user_mdl.dart';
import 'package:user/util/enum/request_type.dart';

class ApiSync {
  Future<bool> users(ApiClient client) async {
    try {
      var response = await client.request(
        endPoint: ApiManager.users,
        type: RequestType.get,
      );
      if (response.isSuccess) {
        var data = (response.data as List<dynamic>)
            .map((e) => UserMdl.fromJson(e))
            .toList();
        await DB.inst.batchInsert(DBTableName.users, data);
        return true;
      }
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
    }
    return false;
  }
}
