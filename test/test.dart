import 'package:flutter_test/flutter_test.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/job_model.dart';
import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';

DateTime morningDateTime({int hours = 9, int minutes = 0}) {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    hours,
    minutes,
  );
}

DateTime nightDateTime({int hours = 0, int minutes = 0}) {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    hours,
    minutes,
  );
}

void mains() {
  test('value should be incremented', () {
    final sampleJobModel = JobModel(
        endTime: nightDateTime(),
        startTime: morningDateTime(),
        id: 1,
        vehicleId: 1,
        vehicleNo: '',
        isJobActivated: true,
        isDropDownMenuOpen: false,
        vehicleName: 'Chhota hathi',
        stops: 0,
        height: 1500,
        length: 1500,
        payload: 710,
        topSpeed: 60,
        dropLocationNameList: []);
    final homeProvider = HomeProvider();
    homeProvider.vehicleList.add(sampleJobModel);

    // Act: Call increaseItemQty
    homeProvider.increaseItemQty(id: 1);

    // Assert: Check if quantity increased and added to selectedJobList
    expect(homeProvider.vehicleList[0].vehicleQty,
        2); // Assuming it should increase by 1
    expect(homeProvider.selectedJobList, contains(sampleJobModel));
  });
}
