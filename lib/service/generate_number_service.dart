import 'dart:math';

class GenerateRandomNumberService {
  static int generateRandomNumber(int maxNumber) {
    Random randomNumber = Random();
    return randomNumber.nextInt(maxNumber);
  }
}
