library mainApp;

import 'dart:io';
part 'staticFileHandler.dart';

main() {
  List<String> args = (new Options()).arguments;
  String host = getHost(args);
  host = (host == null) ? "0.0.0.0" : host;
  var port = Platform.environment['PORT'];
  port = (port == null) ? 8080 : int.parse(Platform.environment['PORT']);

  var script = new File(new Options().script);
  var directory = script.directorySync();

  HttpServer server = new HttpServer();
  String clientPath = '${directory.path}/client';
  server.defaultRequestHandler = new StaticFileHandler(clientPath).onRequest;

  server.listen(host, port);
  print('Server running at http://$host:$port/');
}

String getHost(List<String> argv) {
  for (int i = 0; i < argv.length; i++) {
    String a = argv[i];
    if (a == "--host") return argv[i + 1];
  }
}