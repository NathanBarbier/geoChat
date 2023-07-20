import 'package:permission_handler/permission_handler.dart';

class MyPermissionPhoto {
  Future<PermissionStatus>init() async {
    PermissionStatus status = await Permission.photos.status;
    return checkPermission(status);
  }

  Future<PermissionStatus>checkPermission(PermissionStatus status) async {
    switch(status) {
      case PermissionStatus.permanentlyDenied :
        return Future.error("Toujours refusé");
      case PermissionStatus.denied :
        return Permission.photos.request().then((value) => checkPermission(status));
      case PermissionStatus.provisional :
        return Permission.photos.request().then((value) => checkPermission(status));
      case PermissionStatus.limited :
        return Permission.photos.request().then((value) => checkPermission(status));
      case PermissionStatus.restricted :
        return Permission.photos.request().then((value) => checkPermission(status));
      case PermissionStatus.granted :
        return Permission.photos.request().then((value) => checkPermission(status));
    }
  }
}