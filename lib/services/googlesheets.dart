import 'package:gsheets/gsheets.dart';
import 'package:reway/services/sheetscolums.dart';

class SheetsFlutter {
  static String _sheetId = "16u8KmTluLp_wjwQWPFBcgoHu_pky8sDQ39pFf4sVKlM";
  static const _sheetCredentials = r'''
{
  "type": "service_account",
  "project_id": "reway-4d031",
  "private_key_id": "aae4dfe42589fe595d645f158474fe60e99c610b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4gzC2tumXWVxz\ncMrfZg4AuK+s8E18wkHRDjm02rauuINMqFt8+eyikNB3WfFWQGzB2WqLiai2T5w6\nXq1yMjSwZxwA0KFssNhdsqOZ4/4B9L+AHJ2K/jnuDu4S2sOtsSTw/WNZGWjkz/ox\n7N9kv5zrIZgOIx+T6QB6sGoS6fqpPmuAemalP76fFyNzeymkmLl45XLHM6len1TF\n+afS64fXxpgLyOxhRV85WfPadSOamvfjxPhQdms4+aM4EN+ENstyCi73nTbTdJr5\ne6uP/y4Qgmk0Q72pDciZgf3nsyW+Ckpkirbjo6cE8QBqFqnMowC6LCcYT7d17HKW\nTFEZt+PxAgMBAAECggEAJpImKMvr4NupW+iEQFcRLk1tS/Wf/SiOoakbnxbpgXTI\n3cmD9og4U3N6YLjInoMxOQS+JRVN026o9fq8v1aHdSjYzcLPO+1sDYo+cPkcLESB\nk8JnnJqweXddhUt+BF03n7kYf5O0PcDMSIt/14vGvdBz/OCSxVS76OngArwuzhoG\n8Lo4fC3/Q+pI/clsCZxtaxsgDc7cqRcD2QzHgXTT9/Lmnh6sqqKlfpGT81b1bEyD\nNqrUOWsx2nUoZwh2An7Wk4nhzyXLoslZYfbAkIxnpeyioWvBul64p2i4T4dZh7is\nSqnuLaeI+nS3mjLTk62jAF0nRuWsOw1iD0HnpkCXwQKBgQDyMCfZmRsAIfcSbtt1\nGewkIr8D1nGa5wmZpTZkuaWkyq3S/0B5WgbG4lgj4ISuiJ8ltL2JG8vOwjjVCXCZ\na8kkPl9aXnO4yRIGc8gQwWlWGDsT3GKFPUZPJX38DKJN1TOKnQ+Y8ly9gwU4+Pl5\nspZpBTVSguS1zYffhNVhmwS0hQKBgQDDCP6XF9UAhvZqtcxLK4QD5HQbzp67ILzh\nK/ZzpBE9ej6xJdjlqXP10pO9y9egvCQK7hzVAM36nHFfjoHVU0+pGcwRDCBlcFF1\n481rSFN3gYEZu8TCNc4lGf9g2fNy8nCSuH2RWxVOrKSol7YoIczJE10WbsHgO8JI\niTS7eERzfQKBgCyV4vAzOH5IwnR5RhuDvy5T2zh4pQdwWxsXCDF43967lU6PwS3V\n/gNlLfbE4YhEDJBjerUgEeApb08A4uLLrgbnGKTJWKJ/GbtoWz+Ca8L2yQF6BAUl\nZ6kwbMYXCVYs1sVA7tsoWxxkX3TCmSLnVrtUwyFCiZpSkR38FVBXuoEFAoGBAJ00\nbcmp6wWOw6bFvNLGU5Wzmicjx2v7+mLhRbh2gXL1Sv0NDaQojxCQ2Ic+fCLSI5cv\n0Mub52temD+2pU4m5eneok8HYEGDZBXLNbOIy8Zi+4WbhQAp0Gy1ZNRTOVjos/Z/\ngK8eJLGSlPJTvv7gJ6nX0suXIOy2HmbLOVb2nO4dAoGAaFPLAfhz5cZdh0aYsjaA\n+CcXkIq4d8VmmXcqOC0TWdlS8xEdxHohS8qFuc3n6fKaux9qmJe3wzW4/HOAVmFz\nEH6ENk4KNHJs8jQbQqenNoq7rh1JiMvPTGGb6tYeUwOLe6toCKTh7vtNumhNEKQi\nRBoViroiAtImmogUZaV06qs=\n-----END PRIVATE KEY-----\n",
  "client_email": "reway-fluttersheets@reway-4d031.iam.gserviceaccount.com",
  "client_id": "108594710710154289939",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/reway-fluttersheets%40reway-4d031.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
 static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

      _userSheet = await _getWorkSheet(spreadsheet, title: "Sheet1");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}
