import 'package:http/http.dart';

class CustomClient extends BaseClient {
  final Client _inner = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    // request.headers['user-agent'] = userAgent;

    return _inner.send(request);
  }
}
