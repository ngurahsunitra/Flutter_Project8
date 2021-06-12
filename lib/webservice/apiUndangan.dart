import 'dart:convert';
import 'package:undangan/model/Undangan.dart';
import 'package:http/http.dart' as http;

class ApiUndangan {
  final url = "https://debly.cc/api/getListUndangan.php";
  // Get all undangan
  Future<List<Undangan>?> getUndanganAll() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return undanganFromJson(response.body);
    } else {
      print("Error ${response.toString()}");
      return null;
    }
  }

  //Get undangan hadir
  Future<List<Undangan>?> getUndanganHadir() async {
    final response = await http.get(Uri.parse(url+"?hadir=1"));
    if (response.statusCode == 200) {
      return undanganFromJson(response.body);
    } else {
      print("Error ${response.toString()}");
      return null;
    }
  }

  //Get undangan tidak hadir
  Future<List<Undangan>?> getUndanganTidakHadir() async {
    final response = await http.get(Uri.parse(url+"?hadir=0"));
    if (response.statusCode == 200) {
      return undanganFromJson(response.body);
    } else {
      print("Error ${response.toString()}");
      return null;
    }
  }

  // Cek kehadiran undangan
  Future<Undangan?> cekUndangan(String email) async {
    final response = await http
        .get(Uri.parse("https://debly.cc/api/cekUndangan.php?email=$email"));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Undangan.fromJson(result[0]);
    } else {
      print("Error ${response.toString()}");
      return null;
    }
  }

  // Ubah status kehadiran
  Future<bool> updateKehadiran(Undangan undangan) async {
    final response = await http
        .get(Uri.parse("https://debly.cc/api/updateKehadiran.php?undangan_id=${undangan.id}"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Reset status kehadiran
  Future<bool> resetKehadiran() async {
    final response = await http
        .get(Uri.parse("https://debly.cc/api/resetKehadiran.php"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
