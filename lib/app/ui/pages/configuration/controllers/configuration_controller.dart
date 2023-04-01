import 'package:get/get.dart';
import 'package:mercurium_app/app/domain/usecases/user/sign_out_usecase.dart';

class ConfigurationController extends GetxController {
  final SignOutUsecase signOutUsecase;

  ConfigurationController({required this.signOutUsecase});

  Future<void> signOut() async {
    var result = await signOutUsecase.call();
    if (result) {
      Get.offAndToNamed("/auth");
    }
  }
}
