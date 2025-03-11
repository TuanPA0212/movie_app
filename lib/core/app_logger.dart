import 'package:logger/logger.dart';

class AppLogger {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Hiển thị 2 dòng stack trace
      errorMethodCount: 5, // Hiển thị 5 dòng stack trace khi có lỗi
      lineLength: 120, // Độ dài dòng log
      colors: true, // Bật màu sắc
      printEmojis: true, // Hiển thị emoji
      printTime: true, // Hiển thị thời gian log
    ),
  );
}
