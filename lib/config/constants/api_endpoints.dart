class ApiEndpoints {
  ApiEndpoints._();
  static const limitPage = 8;
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Windows
  // static const String baseUrl = "http://10.0.2.2:5500/api/";
  // For MAC
  // static const String baseUrl = "http://localhost:5500/api/";
  static const String baseUrl = "http://172.20.10.4:5500/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String updateUser = "user/editProfile";
  static const String changePassword = "user//editPassword/";
  static const String uploadProfilePicture = "user/uploadImage";
  static const String requestOTP = 'user/send-otp';
  static const String resetPassword = 'user/reset-password';
  static const String getUserById = 'user/getUserById/';
  // ====================== Nanny Routes ======================
  static const String getAllNannies = "aama/get";

  // ====================== Favourites Routes ======================
  static const String createFavourite = "favourite/create";
  static const String getAllFavourites = "favourite/all";

  // ====================== Booking Routes ======================
  static const String createBooking = "booking/create";
  static const String getAllBooking = "booking/all";
  
  // ====================== Contact Routes ======================
  static const String createContact = "contact/create";
}
