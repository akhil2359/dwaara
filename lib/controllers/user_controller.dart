import 'package:get/get.dart';

class UserController extends GetxController {
  RxString uid = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString imageurl = ''.obs;
  RxList<String> shirts = <String>[].obs;
  RxList<String> pants = <String>[].obs;
  RxList<String> shoes = <String>[].obs;
  RxList<String> accessories = <String>[].obs;

  void updateUid(String newUid) {
    uid.value = newUid;
  }

  void updateName(String newName) {
    name.value = newName;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updateImageUrl(String newImageUrl) {
    imageurl.value = newImageUrl;
  }

  void updateShirts(List<String> newShirts) {
    print("updating shirts" + newShirts.toString());
    shirts.assignAll(newShirts);
  }

  void appendShirt(String newShirt) {
    print("Appending new shirts" + newShirt);
    shirts.add(newShirt);
  }

  void updatePants(List<String> newPants) {
    pants.assignAll(newPants);
  }

  void appendPants(String item) {
    pants.add(item);
  }

   void appendShoes(String item) {
    shoes.add(item);
  }

   void appendAccessories(String item) {
    accessories.add(item);
  }

  void updateShoes(List<String> newShoes) {
    shoes.assignAll(newShoes);
  }

  void updateAccessories(List<String> newAccessories) {
    accessories.assignAll(newAccessories);
  }
}
