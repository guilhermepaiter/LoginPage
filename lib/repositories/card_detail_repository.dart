import 'package:trilhaapp/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> get() async {
    await Future.delayed(const Duration(seconds: 3));
    return CardDetail(
      1,
      "MyCard",
      "https://hermes.digitalinnovation.one/assets/diome/logo.png",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus hendrerit leo at vehicula. Sed vel eros ligula. Sed dui felis, elementum nec scelerisque eu, vulputate sed nisl. Morbi dictum arcu sit amet leo iaculis cursus. Nulla a mi id eros commodo pulvinar. Phasellus sodales consectetur suscipit. In hac habitasse platea dictumst.",
    );
  }
}
