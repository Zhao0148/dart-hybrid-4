import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

main(List<String> arguments) async {
  var data = await fetchUsers(size: 10);
  loopThroughUsers(data);
}

Future<List<dynamic>> fetchUsers({size}) async {
  try {
    var url = Uri.parse('https://randomuser.me/api/?page=3&results=$size&inc=name,id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body)['results'] as List<dynamic>;
      return jsonResponse;
    } else {
      return [];
    }
  } catch (e) {
    print("Error!: $e");
    return [];
  }
}

void loopThroughUsers(List<dynamic> people) {
  for (var person in people) {
    print("First Name: ${person['name']['first']} | Last Name: ${person['name']['last']} | ID: ${person['id']['value']}");
  }
}
