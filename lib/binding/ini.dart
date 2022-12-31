import 'package:get/get.dart';
import '../controller/controller.dart';

class IniBin implements Bindings{
  @override
  dependencies() async{
    Get.put(SwController());
  }
}