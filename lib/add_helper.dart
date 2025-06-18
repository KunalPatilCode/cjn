import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2937617631180331/3345159075';
    } else if (Platform.isIOS) {
      return '<ca-app-pub-2937617631180331/4314625814 >';
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
}
