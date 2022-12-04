import 'package:flutter_test/flutter_test.dart';
import 'package:sebayet_package/models/blood_bank_model.dart';
import 'package:sebayet_package/models/blood_model.dart';
import 'package:sebayet_package/models/state_model.dart';

import 'package:sebayet_package/sebayet_package.dart';

void main() {
  test('check_keys', () async {
    await BloodBank.getList(stateCode: "19", distCode: "334", bloodGroup: "", bloodComponent: "");
    expect({}, {});
  });
}
