class ApiKey {
  static const String mainAPI = 'http://192.168.1.8:8000';

  // Update Location
  static const String updateLocation = '$mainAPI/api/update-location';

  // Auth
  static const String login = '$mainAPI/api/login';
  static const String register = '$mainAPI/api/register';
  static const String me = '$mainAPI/api/get-user';
  static const String logout = '$mainAPI/api/logout';

  // Student
  static const String studentGet = '$mainAPI/api/get-student';
  static const String studentCreate = '$mainAPI/api/create-student';
  static const String studentDetail = '$mainAPI/api/detail-student';
  static const String studentUpdate = '$mainAPI/api/update-student';
  static const String studentDelete = '$mainAPI/api/delete-student';

  // Absen
  static const String absenGet = '$mainAPI/api/get-absen';
  static const String absenGetByMonthAndYear =
      '$mainAPI/api/get-absen-bymonthandyear';
  static const String absenCreate = '$mainAPI/api/create-absen';
}
