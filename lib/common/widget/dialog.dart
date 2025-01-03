import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionRationaleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('권한 필요'),
        content: Text('이 앱은 정상적으로 작동하려면 저장소 권한이 필요합니다. 계속하려면 권한을 허용해 주세요.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              // 권한을 다시 요청
              Permission.storage.request();
            },
            child: Text('권한 허용'),
          ),
        ],
      );
    },
  );
}

void showPermissionSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('권한 거부'),
        content: Text('저장소 권한을 영구적으로 거부하셨습니다. 앱을 계속 사용하려면 앱 설정에서 권한을 활성화해주세요.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              // 앱 설정으로 이동하여 권한 활성화
              openAppSettings();
            },
            child: Text('설정으로 이동'),
          ),
        ],
      );
    },
  );
}
