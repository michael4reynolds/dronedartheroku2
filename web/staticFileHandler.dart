part of mainApp;

class StaticFileHandler {
  final String basePath;

  StaticFileHandler(this.basePath);

  _send404(HttpResponse response) {
    response.statusCode = HttpStatus.NOT_FOUND;
    response.outputStream.close();
  }

// TODO: etags, last-modified-since support
  onRequest(HttpRequest request, HttpResponse response) {
    final String path = request.path == '/' ? '/clock.html' : request.path;
    final File file = new File('${basePath}${path}');
    print('${basePath}${path}');
    file.exists().then((found) {
      if (found) {
        file.fullPath().then((String fullPath) {
          if (fullPath.startsWith(basePath) || fullPath.contains('/pub.dartlang.org/')) {
            file.openInputStream().pipe(response.outputStream);
          } else { _send404(response); }
        });
      } else { _send404(response); }
    });
  }
}
