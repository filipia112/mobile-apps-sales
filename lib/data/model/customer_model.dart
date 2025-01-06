import 'package:intl/intl.dart';

class CustomerModel {
  final String nmPelanggan;
  final String noPelanggan;
  final String alamatPelanggan;
  final String noIzinSarana;
  final DateTime? berlakuIzinSarana;
  final String nmAPJ;
  final String noSIPA;
  final DateTime? berlakuSIPA;
  final String noSipnap;
  final bool isVerified;
  final String IdUser;

  CustomerModel({
    required this.nmPelanggan,
    required this.noPelanggan,
    required this.alamatPelanggan,
    required this.noIzinSarana,
    this.berlakuIzinSarana,
    required this.nmAPJ,
    required this.noSIPA,
    this.berlakuSIPA,
    required this.noSipnap,
    required this.isVerified,
    required this.IdUser
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      nmPelanggan: json['nmPelanggan'] ?? '',
      noPelanggan: json['noPelanggan'] ?? '',
      alamatPelanggan: json['alamatPelanggan'] ?? '',
      noIzinSarana: json['noIzinSarana'] ?? '',
      berlakuIzinSarana: _parseDate(json['berlakuIzinSarana']),
      nmAPJ: json['nmAPJ'] ?? '',
      noSIPA: json['noSIPA'] ?? '',
      berlakuSIPA: _parseDate(json['berlakuSIPA']),
      noSipnap: json['noSipnap'] ?? '',
      isVerified: json['isVerified'] is int
          ? json['isVerified'] == 1
          : json['isVerified'] ?? false,
      IdUser: json ['IdUser'] ?? ''
    );
  }

  static DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return null;
    }
    try {
      return DateFormat('yyyy-MM-dd').parse(dateStr);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nmPelanggan': nmPelanggan,
      'noPelanggan': noPelanggan,
      'alamatPelanggan': alamatPelanggan,
      'noIzinSarana': noIzinSarana,
      'berlakuIzinSarana': berlakuIzinSarana != null
          ? DateFormat('yyyy-MM-dd').format(berlakuIzinSarana!)
          : null,
      'nmAPJ': nmAPJ,
      'noSIPA': noSIPA,
      'berlakuSIPA': berlakuSIPA != null
          ? DateFormat('yyyy-MM-dd').format(berlakuSIPA!)
          : null,
      'noSipnap': noSipnap,
      'isVerified': isVerified,
      'IdUser': IdUser
    };
  }
}
