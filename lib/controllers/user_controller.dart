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
  RxList<List<String>> combination = <List<String>>[].obs;

    List<List<String>> generateAllCombinations(
      List<String> shirts, List<String> pants, List<String> shoes, List<String> accessories) {
    List<List<String>> allCombinations = [];

    for (String shirt in shirts) {
      for (String pant in pants) {
        for (String shoe in shoes) {
          for (String accessory in accessories) {
            allCombinations.add([shirt, pant, shoe, accessory]);
          }
        }
      }
    }

    return allCombinations;
  }


    void updateCombination() {
    combination.clear();

    List<List<String>> allCombinations = generateAllCombinations(
        shirts.toList(), pants.toList(), shoes.toList(), accessories.toList());

    for (List<String> currentCombination in allCombinations) {
      combination.add(currentCombination);
    }
  }

  int getMaxListLength(RxList<String> list1, RxList<String> list2,
      RxList<String> list3, RxList<String> list4) {
    int maxLength = 0;

    if (list1.length > maxLength) maxLength = list1.length;
    if (list2.length > maxLength) maxLength = list2.length;
    if (list3.length > maxLength) maxLength = list3.length;
    if (list4.length > maxLength) maxLength = list4.length;

    return maxLength;
  }

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
    updateCombination();
  }

  void appendShirt(String newShirt) {
    print("Appending new shirts" + newShirt);
    shirts.add(newShirt);
    updateCombination();
  }

  void updatePants(List<String> newPants) {
    pants.assignAll(newPants);
    updateCombination();
  }

  void appendPants(String item) {
    pants.add(item);
    updateCombination();
  }

  void appendShoes(String item) {
    shoes.add(item);
    updateCombination();
  }

  void appendAccessories(String item) {
    accessories.add(item);
    updateCombination();
  }

  void updateShoes(List<String> newShoes) {
    shoes.assignAll(newShoes);
    updateCombination();
  }

  void updateAccessories(List<String> newAccessories) {
    accessories.assignAll(newAccessories);
    updateCombination();
  }

  void resetAllStates() {
    uid.value = '';
    name.value = '';
    email.value = '';
    imageurl.value = '';
    shirts.clear();
    pants.clear();
    shoes.clear();
    accessories.clear();
    combination.clear();
  }
}
