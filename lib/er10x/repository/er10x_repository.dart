import '../../my_page/util/er10x_util.dart';
import '../model/er10x_model.dart';

class Er10xRepository {
  Future<List<Er10xModel>> load() => Er10xUtil.load();
  Future<void> save(List<Er10xModel> list) => Er10xUtil.save(list);
}
