class AppConstants {
  AppConstants._();

  // receiveTimeout
  static const int receiveTimeout = 300000;

  // connectTimeout
  static const int connectionTimeout = 300000;

  static const String server_error = 'Some Error Occured';
  static const String no_data_error = 'No Record Found';

  static const appname = 'Recipe book';
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const categories = 'categories.php';
  static const meals = 'search.php';
}
