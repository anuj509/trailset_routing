import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'
    as polylinePoints;
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/job_model.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/json_uploaded_model.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/open_source_place_response.dart';
import 'package:trailset_route_optimize/mvp/src/home/model/optimized_route_model.dart';
import 'package:trailset_route_optimize/mvp/widgets/widgets.dart';
import 'package:trailset_route_optimize/utils/theme/theme.dart';

class HomeProvider extends ChangeNotifier {
  UniqueKey _uploadedMarkerKey = UniqueKey();
  UniqueKey get uploadedMarkerKey => _uploadedMarkerKey;
  set uploadedMarkerKey(UniqueKey key) {
    _uploadedMarkerKey = key;
    notifyListeners();
  }

  UniqueKey _optimizedMarkerKey = UniqueKey();
  UniqueKey get optimizedMarkerKey => _optimizedMarkerKey;
  set optimizedMarkerKey(UniqueKey key) {
    _optimizedMarkerKey = key;
    notifyListeners();
  }

  TextEditingController latitudeController =
      TextEditingController(text: '19.0441447');

  TextEditingController longitudeController =
      TextEditingController(text: '72.8929133');

  List<String> assignableTypeList = ['Assigned', 'Un-Assigned', 'Total'];

  String _selectedAssignableType = 'Total';
  String get selectedAssignableType => _selectedAssignableType;
  set selectedAssignableType(String val) {
    _selectedAssignableType = val;
    notifyListeners();
  }

  int _colorIndex = 0;
  int get colorIndex => _colorIndex;
  set colorIndex(int val) {
    _colorIndex = val;
    notifyListeners();
  }

  bool _isRoundTripAvailable = true;
  bool get isRoundTripAvailable => _isRoundTripAvailable;
  set isRoundTripAvailable(bool val) {
    _isRoundTripAvailable = val;
    isOptimizedButtonEnabled();
    notifyListeners();
  }

  static DateTime morningDateTime({int hours = 9, int minutes = 0}) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hours,
      minutes,
    );
  }

  bool _isFileUploaded = false;
  bool get isFileUploaded => _isFileUploaded;
  set isFileUploaded(bool val) {
    _isFileUploaded = val;
    notifyListeners();
  }

  static DateTime nightDateTime({int hours = 0, int minutes = 0}) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hours,
      minutes,
    );
  }

  OptimizedRouteModel _optimizedRouteModel =
      OptimizedRouteModel(code: 1, routes: [], unassigned: []);
  OptimizedRouteModel get optimizedRouteModel => _optimizedRouteModel;
  set optimizedRouteModel(OptimizedRouteModel model) {
    _optimizedRouteModel = model;
    notifyListeners();
  }

  LatLng _depoLocation = const LatLng(19.0441447, 72.8929133);
  LatLng get depoLocation => _depoLocation;
  set depoLocation(LatLng val) {
    _depoLocation = val;
    isOptimizedButtonEnabled();
    notifyListeners();
  }

  LatLng _lastDepoLocation = const LatLng(0.0, 0.0);
  LatLng get lastDepoLocation => _lastDepoLocation;
  set lastDepoLocation(LatLng val) {
    _lastDepoLocation = val;
    notifyListeners();
  }

  bool _isRouteOptimizedActivated = false;
  bool get isRouteOptimizedActivated => _isRouteOptimizedActivated;
  set isRouteOptimizedActivated(bool val) {
    _isRouteOptimizedActivated = val;
    notifyListeners();
  }

  bool _isFileSelectPressed = false;
  bool get isFileSelectPressed => _isFileSelectPressed;
  set isFileSelectPressed(bool val) {
    _isFileSelectPressed = val;
    notifyListeners();
  }

  bool _isOptimizeButtonEnabled = false;
  bool get isOptimizeButtonEnabled => _isOptimizeButtonEnabled;
  set isOptimizeButtonEnabled(bool val) {
    _isOptimizeButtonEnabled = val;
    notifyListeners();
  }

  MapController? mapController = MapController();
  File _selectedJsonFile = File('');
  File get selectedJsonFile => _selectedJsonFile;
  set selectedJsonFile(File file) {
    _selectedJsonFile = file;
    notifyListeners();
  }

  bool _isCustomTruckDialogOpen = false;
  bool get isCustomTruckDialogOpen => _isCustomTruckDialogOpen;
  set isCustomTruckDialogOpen(bool val) {
    _isCustomTruckDialogOpen = val;
    notifyListeners();
  }

  bool _isSelectVehicleDialogOpen = false;
  bool get isSelectVehicleDialogOpen => _isSelectVehicleDialogOpen;
  set isSelectVehicleDialogOpen(bool val) {
    _isSelectVehicleDialogOpen = val;
    notifyListeners();
  }

  bool _isSelectVehicleDropDownOpen = false;
  bool get isSelectVehicleDropDownOpen => _isSelectVehicleDropDownOpen;
  set isSelectVehicleDropDownOpen(bool val) {
    _isSelectVehicleDropDownOpen = val;
    notifyListeners();
  }

  List<UploadedExcelModel> _uploadedExcelToOptimizeMarkerList = [];
  List<UploadedExcelModel> get uploadedExcelToOptimizeMarkerList =>
      _uploadedExcelToOptimizeMarkerList;
  set uploadedExcelToOptimizeMarkerList(List<UploadedExcelModel> val) {
    _uploadedExcelToOptimizeMarkerList = val;
    notifyListeners();
  }

  List<UploadedExcelModel> _checkUploadedExcelToOptimizeMarkerListIsSame = [];
  List<UploadedExcelModel> get checkUploadedExcelToOptimizeMarkerListIsSame =>
      _checkUploadedExcelToOptimizeMarkerListIsSame;
  set checkUploadedExcelToOptimizeMarkerListIsSame(
      List<UploadedExcelModel> val) {
    _checkUploadedExcelToOptimizeMarkerListIsSame = val;
    notifyListeners();
  }

  List<UploadedExcelModel> _checkExcelModelIsSameList = [];
  List<UploadedExcelModel> get checkExcelModelIsSameList =>
      _checkExcelModelIsSameList;
  set checkExcelModelIsSameList(List<UploadedExcelModel> val) {
    _checkExcelModelIsSameList = val;
    notifyListeners();
  }

  List<UploadedExcelModel> _uploadedExcelModelList = [];
  List<UploadedExcelModel> get uploadedExcelModelList =>
      _uploadedExcelModelList;
  set uploadedExcelModelList(List<UploadedExcelModel> val) {
    _uploadedExcelModelList = val;
    notifyListeners();
  }

  List<UploadedExcelModel> _assignedExcelModelList = [];
  List<UploadedExcelModel> get assignedExcelModelList =>
      _assignedExcelModelList;
  set assignedExcelModelList(List<UploadedExcelModel> val) {
    _assignedExcelModelList = val;
    notifyListeners();
  }

  updateExcelModelListOnTap(
      LatLng latLng, OpenStreetPlaceResponse openStreetPaceResponse) {
    DateTime startDateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 10, 0, 0);
    DateTime endDateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 18, 0, 0);

    UploadedExcelModel uploadedExcelModel = UploadedExcelModel(
      endTime: endDateTime,
      globalKey: GlobalKey(),
      id: uploadedExcelToOptimizeMarkerList.length + 1,
      lat: latLng.latitude,
      lng: latLng.longitude,
      name: openStreetPaceResponse.displayName,
      priority: 1,
      serviceTime: 10,
      startTime: startDateTime,
    );
    uploadedExcelModelList.add(uploadedExcelModel);
    uploadedExcelToOptimizeMarkerList.add(uploadedExcelModel);
    checkExcelModelIsSameList.add(uploadedExcelModel);
    isOptimizedButtonEnabled();
    notifyListeners();
  }

  updateExcelModelListManual(OpenStreetPlaceResponse openStreetPaceResponse) {
    UploadedExcelModel uploadedExcelModel = UploadedExcelModel(
      endTime: DateTime.now(),
      globalKey: GlobalKey(),
      id: uploadedExcelToOptimizeMarkerList.length + 1,
      lat: double.parse(openStreetPaceResponse.lat),
      lng: double.parse(openStreetPaceResponse.lon),
      name: openStreetPaceResponse.displayName,
      priority: 0,
      serviceTime: 10,
      startTime: DateTime.now(),
    );
    uploadedExcelModelList.add(uploadedExcelModel);
    uploadedExcelToOptimizeMarkerList.add(uploadedExcelModel);
    checkExcelModelIsSameList.add(uploadedExcelModel);

    notifyListeners();
  }

  List<JobModel> _vehicleList = [
    JobModel(
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
        dropLocationNameList: []),
    JobModel(
        endTime: nightDateTime(),
        startTime: morningDateTime(),
        id: 2,
        vehicleId: 1,
        vehicleNo: '',
        isJobActivated: true,
        isDropDownMenuOpen: false,
        vehicleName: 'Mahindra Pickup',
        stops: 0,
        height: 1500,
        length: 3800,
        payload: 710,
        topSpeed: 60,
        dropLocationNameList: []),
    JobModel(
        endTime: nightDateTime(),
        startTime: morningDateTime(),
        id: 3,
        vehicleId: 1,
        vehicleNo: '',
        isJobActivated: true,
        isDropDownMenuOpen: false,
        vehicleName: 'Volvo truck',
        stops: 0,
        height: 1500,
        length: 3800,
        payload: 710,
        topSpeed: 60,
        dropLocationNameList: []),
    JobModel(
        endTime: nightDateTime(),
        startTime: morningDateTime(),
        id: 4,
        vehicleId: 1,
        vehicleNo: '',
        isJobActivated: true,
        isDropDownMenuOpen: false,
        vehicleName: 'Mahindras Pickup',
        stops: 0,
        height: 1500,
        length: 3800,
        payload: 710,
        topSpeed: 60,
        dropLocationNameList: []),
    JobModel(
        endTime: nightDateTime(),
        startTime: morningDateTime(),
        id: 5,
        vehicleId: 1,
        vehicleNo: '',
        isJobActivated: true,
        isDropDownMenuOpen: false,
        vehicleName: 'Chhotas hathi',
        stops: 0,
        height: 1500,
        length: 3800,
        payload: 710,
        topSpeed: 60,
        dropLocationNameList: []),
    JobModel(
        endTime: nightDateTime(),
        startTime: morningDateTime(),
        id: 6,
        vehicleId: 1,
        vehicleNo: '',
        isJobActivated: true,
        isDropDownMenuOpen: false,
        vehicleName: 'Volvos truck',
        stops: 0,
        height: 1500,
        length: 3800,
        payload: 710,
        topSpeed: 60,
        dropLocationNameList: []),
  ];

  List<JobModel> get vehicleList => _vehicleList;
  set vehicleList(List<JobModel> val) {
    _vehicleList = val;
    notifyListeners();
  }

  List<JobModel> _selectedVehicleList = [];
  List<JobModel> get selectedVehicleList => _selectedVehicleList;
  set selectedVehicleList(List<JobModel> val) {
    _selectedVehicleList = val;
    notifyListeners();
  }

  List<JobModel> _selectedJobList = [];
  List<JobModel> get selectedJobList => _selectedJobList;
  set selectedJobList(List<JobModel> val) {
    _selectedJobList = val;
    notifyListeners();
  }

  List<JobModel> _selectedJobListAfterOptimized = [];
  List<JobModel> get selectedJobListAfterOptimized =>
      _selectedJobListAfterOptimized;
  set selectedJobListAfterOptimized(List<JobModel> val) {
    _selectedJobListAfterOptimized = val;
    notifyListeners();
  }

  void increaseItemQty({required int id}) {
    for (int i = 0; i < vehicleList.length; i++) {
      if (vehicleList[i].id == id) {
        vehicleList[i].vehicleQty++;
        notifyListeners();
        if (vehicleList[i].isItemSelected) {
          print("vehicleList[i]--> ${vehicleList[i].endTime.runtimeType}");
          print("vehicleList[i]--> ${vehicleList[i].startTime.runtimeType}");
          JobModel jobModel = JobModel.fromJson((vehicleList[i].toJson()));
          jobModel.vehicleId = vehicleList[i].vehicleQty;
          jobModel.dropLocationNameList = [];
          jobModel.stops = 0;
          addVehicleToSelectedJobList(jobModel: jobModel);
        }
        break;
      }
    }
  }

  void addVehicleToSelectedJobList({required JobModel jobModel}) {
    print("addVehicleToSelectedJobList JobModel --> ${jobModel.toJson()}");
    // jobModel.id = selectedJobList.length + 1;
    if (colorIndex < 99) {
      Color color = StaticColors.colorsList[colorIndex];
      jobModel.color = color;
    } else {
      jobModel.color = _generateNewColor();
    }
    colorIndex = colorIndex + 1;
    jobModel.globalKey = GlobalKey();

    selectedJobList.add(jobModel);
    isOptimizedButtonEnabled();
    notifyListeners();
  }

  void decreaseItemQty({required int id}) {
    for (int i = 0; i < vehicleList.length; i++) {
      if (vehicleList[i].id == id) {
        print("decreaseItemQty JobModel --> ${vehicleList[i].toJson()}");

        if (vehicleList[i].vehicleQty > 0) {
          removeVehicleFromSelectedJobList(jobModel: vehicleList[i]);
          vehicleList[i].vehicleQty--;
        }
        if (vehicleList[i].vehicleQty == 0) {
          vehicleList[i].isItemSelected = false;
          vehicleList[i].isJobActivated = true;
          removeVehicleFromSelectedJobList(jobModel: vehicleList[i]);
        }
        notifyListeners();
        break;
      }
    }
  }

  void removeVehicleFromSelectedJobList(
      {required JobModel jobModel, bool isFromOnCheckBoxClick = false}) {
    print("removeVehicleFromSelectedJobList --> ${jobModel.vehicleQty}");
    print("removeVehicleFromSelectedJobList --> ${jobModel.vehicleId}");
    print("removeVehicleFromSelectedJobList --> ${jobModel.id}");
    optimizedRouteModel.routes.removeWhere((e) {
      return (e.vehicleId == jobModel.vehicleQty) && (e.id == jobModel.id);
    });

    for (int i = 0; i < selectedJobList.length; i++) {
      print("selectedJobList[i].vehicleId --> ${selectedJobList[i].vehicleId}");
      if ((selectedJobList[i].id == jobModel.id) &&
          (selectedJobList[i].vehicleId == jobModel.vehicleQty)) {
        for (int j = 0;
            j < selectedJobList[i].dropLocationNameList.length;
            j++) {
          RouteStep routeStep = selectedJobList[i].dropLocationNameList[j];
          if (routeStep.id != null) {
            UploadedExcelModel uploadedExcelModel = UploadedExcelModel(
                endTime: routeStep.endTime,
                globalKey: GlobalKey(),
                id: routeStep.id ?? 0,
                lat: routeStep.location[1],
                lng: routeStep.location[0],
                name: routeStep.description ?? '',
                priority: routeStep.priority,
                serviceTime: routeStep.serviceTime,
                startTime: routeStep.startTime);
            assignedExcelModelList
                .removeWhere((element) => element.id == uploadedExcelModel.id);
            uploadedExcelModelList.add(uploadedExcelModel);
            checkExcelModelIsSameList.add(uploadedExcelModel);
          }
        }
      }
    }

    selectedVehicleList.removeWhere((element) {
      print(
          "selectedVehicleList Removed--> ${(element.id == jobModel.id && element.vehicleId == jobModel.vehicleQty)}");

      return (element.id == jobModel.id &&
          element.vehicleId == jobModel.vehicleQty);
    });

    selectedJobList.removeWhere((element) {
      print(
          "selectedJobList Removed--> ${(element.id == jobModel.id && element.vehicleId == jobModel.vehicleQty)}");
      return (element.id == jobModel.id &&
          element.vehicleId == jobModel.vehicleQty);
    });

    isOptimizedButtonEnabled();
    notifyListeners();
  }

  void onCheckBoxSelectFromVehicleSelection({required JobModel jobModel}) {
    // selectedJobList.removeWhere((element) => (element.id == jobModel.id));
    removeVehicleFromSelectedJobList(
        jobModel: jobModel, isFromOnCheckBoxClick: true);
    if (jobModel.isItemSelected) {
      for (int i = 0; i < jobModel.vehicleQty; i++) {
        JobModel jobModels = JobModel.fromJson(jobModel.toJson());
        jobModels.dropLocationNameList = [];
        jobModels.vehicleId = i + 1;
        if (colorIndex < 99) {
          Color color = StaticColors.colorsList[colorIndex];
          jobModels.color = color;
        } else {
          jobModels.color = _generateNewColor();
        }
        colorIndex = colorIndex + 1;
        jobModel.globalKey = GlobalKey();

        selectedJobList.add(jobModels);
      }
    }
    isOptimizedButtonEnabled();
    notifyListeners();
  }

  Future addItemToVehicleList({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    required String cargoName,
    required String cargoNo,
    required String cargoLength,
    required String cargoHeight,
    required String cargoPayload,
    required String cargoTopSpeed,
  }) async {
    JobModel jobModel = JobModel(
        vehicleId: 1,
        endTime: endTime == null
            ? nightDateTime()
            : nightDateTime(hours: endTime.hour, minutes: endTime.minute),
        startTime: startTime == null
            ? morningDateTime()
            : morningDateTime(hours: startTime.hour, minutes: startTime.minute),
        id: vehicleList.length + 1,
        vehicleNo: cargoNo,
        isItemSelected: true,
        dropLocationNameList: [],
        height: int.parse(cargoHeight),
        length: int.parse(cargoLength),
        payload: int.parse(cargoPayload),
        stops: 0,
        topSpeed: int.parse(cargoTopSpeed),
        vehicleName: cargoName,
        isJobActivated: true);

    JobModel jobModels = JobModel.fromJson(jobModel.toJson());

    vehicleList.add(jobModels);
    selectedVehicleList.add(jobModels);
    if (colorIndex < 99) {
      Color color = StaticColors.colorsList[colorIndex];
      jobModels.color = color;
    } else {
      jobModels.color = _generateNewColor();
    }
    colorIndex = colorIndex + 1;
    jobModel.globalKey = GlobalKey();
    selectedJobList.add(jobModels);
    isOptimizedButtonEnabled();

    notifyListeners();
  }

  Future updateItemToVehicleList({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    required String id,
    required int vehicleId,
    required String cargoName,
    required String cargoNo,
    required String cargoLength,
    required String cargoHeight,
    required String cargoPayload,
    required String cargoTopSpeed,
    required String cargoStops,
    required int index,
  }) async {
    int ids = int.parse(id);

    JobModel jobModel = JobModel(
        vehicleId: vehicleId,
        color: selectedJobList[index].color,
        isDropDownMenuOpen: selectedJobList[index].isDropDownMenuOpen,
        endTime: endTime == null
            ? nightDateTime()
            : nightDateTime(hours: endTime.hour, minutes: endTime.minute),
        startTime: startTime == null
            ? morningDateTime()
            : morningDateTime(hours: startTime.hour, minutes: startTime.minute),
        id: ids,
        vehicleNo: cargoNo,
        isItemSelected: true,
        dropLocationNameList: selectedJobList[index].dropLocationNameList,
        height: int.parse(cargoHeight),
        length: int.parse(cargoLength),
        payload: int.parse(cargoPayload),
        stops: int.parse(cargoStops),
        topSpeed: int.parse(cargoTopSpeed),
        vehicleName: cargoName,
        isJobActivated: true);

    JobModel jobModels = JobModel.fromJson(jobModel.toJson());
    jobModels.color = selectedJobList[index].color;

    // for (int i = 0; i < selectedVehicleList.length; i++) {
    //   if (selectedVehicleList[i].id == ids &&
    //       selectedVehicleList[i].vehicleId == vehicleId) {
    //     selectedVehicleList[i] = jobModels;
    //     break;
    //   }
    // }
    for (int i = 0; i < selectedJobList.length; i++) {
      if (selectedJobList[i].id == ids &&
          selectedJobList[i].vehicleId == vehicleId) {
        selectedJobList[i] = jobModels;
        break;
      }
    }

    // selectedVehicleList.add(jobModels);
    // selectedJobList.add(jobModels);
    // isOptimizedButtonEnabled();

    notifyListeners();
  }

  Future removeItemFromSelectedVehicleList(
      {bool clearAll = false, required int id, required int vehicleId}) async {
    for (int i = 0; i < vehicleList.length; i++) {
      if (vehicleList[i].id == id) {
        vehicleList[i].isItemSelected = false;
        break;
      }
    }
    selectedVehicleList.removeWhere((element) {
      return (element.id == id);
    });
    for (int i = 0; i < selectedJobList.length; i++) {
      if (selectedJobList[i].id == id) {
        for (int j = 0;
            j < selectedJobList[i].dropLocationNameList.length;
            j++) {
          RouteStep routeStep = selectedJobList[i].dropLocationNameList[j];
          if (routeStep.id != null) {
            UploadedExcelModel uploadedExcelModel = UploadedExcelModel(
                endTime: routeStep.endTime,
                globalKey: GlobalKey(),
                id: routeStep.id ?? 0,
                lat: routeStep.location[1],
                lng: routeStep.location[0],
                name: routeStep.description ?? '',
                priority: routeStep.priority,
                serviceTime: routeStep.serviceTime,
                startTime: routeStep.startTime);
            assignedExcelModelList
                .removeWhere((element) => element.id == uploadedExcelModel.id);
            uploadedExcelModelList.add(uploadedExcelModel);
            checkExcelModelIsSameList.add(uploadedExcelModel);
          }
        }
      }
    }
    optimizedRouteModel.routes.removeWhere((e) => e.id == id);

    selectedJobList.removeWhere((element) => (element.id == id));
    isOptimizedButtonEnabled();

    notifyListeners();
  }

  Future makeDropDownMenuOpenOrCloseInJobList({required int index}) async {
    for (int i = 0; i < selectedJobList.length; i++) {
      if (index == i) {
        if (selectedJobList[i].isDropDownMenuOpen) {
          selectedJobList[i].isDropDownMenuOpen = false;
          notifyListeners();
        } else {
          selectedJobList[i].isDropDownMenuOpen = true;
          notifyListeners();
        }
        break;
      }
    }
  }

  Future makeItemSelectUnSelectInVehicleList({required int id}) async {
    for (int i = 0; i < vehicleList.length; i++) {
      if (vehicleList[i].id == id) {
        vehicleList[i].isItemSelected = !vehicleList[i].isItemSelected;
        bool isVehicleExists = await checkIsVehicleIsAlreadySelectedOrNot(
            id: vehicleList[i].id, vehicleId: vehicleList[i].vehicleId);

        if (!isVehicleExists) {
          if (vehicleList[i].vehicleQty == 0) {
            // vehicleList[i].vehicleQty = 1;
            increaseItemQty(id: vehicleList[i].id);
          }
          vehicleList[i].vehicleId = vehicleList[i].vehicleQty;

          vehicleList[i].dropLocationNameList = [];
          vehicleList[i].stops = 0;
          selectedVehicleList.add(vehicleList[i]);
        } else {
          removeItemFromSelectedVehicleList(
              id: vehicleList[i].id, vehicleId: vehicleList[i].vehicleId);
        }
        break;
      }
    }
    isOptimizedButtonEnabled();
    notifyListeners();
  }

  Future<bool> checkIsVehicleIsAlreadySelectedOrNot(
      {required int id, required int vehicleId}) async {
    for (int j = 0; j < selectedVehicleList.length; j++) {
      if (selectedVehicleList[j].id == id &&
          selectedVehicleList[j].vehicleId == vehicleId) {
        return true;
      }
    }
    return false;
  }

  Future makeSwitchOnOrOff({required int index}) async {
    if (selectedJobList[index].isJobActivated) {
      selectedJobList[index].isJobActivated = false;
      if (optimizedRouteModel.routes.isNotEmpty) {
        if (index < optimizedRouteModel.routes.length) {
          optimizedRouteModel.routes[index].isVisible = false;
        }
      }
    } else {
      selectedJobList[index].isJobActivated = true;
      if (optimizedRouteModel.routes.isNotEmpty) {
        if (index < optimizedRouteModel.routes.length) {
          optimizedRouteModel.routes[index].isVisible = true;
        }
      }
    }

    isOptimizedButtonEnabled();
    notifyListeners();
  }

  Future selectExcelFile() async {
    isFileUploaded = false;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowCompression: true,
        allowedExtensions: ['xlsx', 'xls'],
      );
      isFileSelectPressed = true;

      if (result == null) {
        showToast(title: 'Please select valid file!');
        isFileSelectPressed = false;
        isFileUploaded = false;

        return;
      }
      selectedJsonFile = File('${result.files.first.bytes!}');

      /// Parse the JSON content
      Uint8List bytes = result.files.single.bytes!;

      var excel = Excel.decodeBytes(bytes);
      int uploadedItemCount = 1;
      if (kDebugMode) {
        print('excel.tables.keys.length --> ${excel.tables.keys.length}');
      }
      for (var table in excel.tables.keys) {
        if (kDebugMode) {
          print(
              'excel.tables.keys.length -->$table ${excel.tables.keys.length} excel.tables[table]!.rows --> ${excel.tables[table]!.rows.length}');
        }
        for (var row in excel.tables[table]!.rows.skip(1)) {
          if (uploadedItemCount > 200) {
            uploadedExcelToOptimizeMarkerList = [];
            uploadedExcelModelList = [];
            showToast(
                title: "Your Job is more than 200!", timeInSecForIosWeb: 5);
            break;
          }
          UploadedExcelModel uploadedExcelModel = UploadedExcelModel(
              globalKey: GlobalKey(),
              id: int.parse('${uploadedExcelToOptimizeMarkerList.length + 1}'),
              name: '${row[1]!.value}',
              lng: double.parse('${row[2]!.value}'),
              lat: double.parse('${row[3]!.value}'),
              priority: int.parse('${row[4]!.value}'),
              startTime:
                  currentTime(dateTime: DateTime.parse('${row[5]!.value}')),
              endTime: currentTime(
                  dateTime: DateTime.parse('${row[6]!.value}'),
                  nextDayDate: true),
              serviceTime: int.parse('${row[7]!.value}'));

          uploadedExcelToOptimizeMarkerList.add(uploadedExcelModel);

          uploadedExcelModelList.add(uploadedExcelModel);
          uploadedItemCount = uploadedItemCount + 1;
        }
      }
      if (uploadedExcelModelList.isNotEmpty) {
        checkExcelModelIsSameList = List.from(uploadedExcelModelList);

        // uploadedExcelToOptimizeMarkerList =
        //     List.from(checkExcelModelIsSameList);
        List<LatLng> latLngList = [];
        for (int i = 0; i < uploadedExcelModelList.length; i++) {
          latLngList.add(LatLng(
              uploadedExcelModelList[i].lat, uploadedExcelModelList[i].lng));
        }
        LatLng latLng = findCenterLatLng(latLngList);
        mapController!.move(latLng, 11);
        isOptimizedButtonEnabled();
      }
      isFileSelectPressed = false;
      isFileUploaded = true;
    } catch (e) {
      isFileUploaded = false;
      isFileSelectPressed = false;
    }
    // addMarkersToMap();
  }

  void increaseJobPriority(int id) {
    int priority = 0;
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        if (uploadedExcelModelList[i].priority < 100) {
          priority = uploadedExcelModelList[i].priority;
          priority = priority + 1;
          uploadedExcelModelList[i].priority = priority;
          isOptimizedButtonEnabled();
          notifyListeners();
        }
        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        if (uploadedExcelToOptimizeMarkerList[i].priority < 100) {
          uploadedExcelToOptimizeMarkerList[i].priority = priority;
        }
        break;
      }
    }
  }

  void increaseJobPriorityForOptimizedMarker(int id) {
    for (int i = 0; i < selectedJobList.length; i++) {
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (selectedJobList[i].dropLocationNameList[j].id == id) {
          if (selectedJobList[i].dropLocationNameList[j].priority < 100) {
            selectedJobList[i].dropLocationNameList[j].priority++;
            isOptimizedButtonEnabled(isJobList: true);
            notifyListeners();
          }
          break;
        }
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        if (uploadedExcelToOptimizeMarkerList[i].priority < 100) {
          uploadedExcelToOptimizeMarkerList[i].priority++;
        }
        break;
      }
    }
  }

  void decreaseJobPriority(int id) {
    int priority = 0;
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        priority = uploadedExcelModelList[i].priority;
        if (uploadedExcelModelList[i].priority > 0) {
          priority = priority - 1;
          uploadedExcelModelList[i].priority = priority;

          notifyListeners();
        }
        isOptimizedButtonEnabled();

        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        if (uploadedExcelToOptimizeMarkerList[i].priority > 0) {
          uploadedExcelToOptimizeMarkerList[i].priority = priority;
          notifyListeners();
        }
        break;
      }
    }
  }

  void decreaseJobPriorityForOptimizedMarker(int id) {
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        if (uploadedExcelModelList[i].priority > 0) {
          uploadedExcelModelList[i].priority--;

          notifyListeners();
        }
        isOptimizedButtonEnabled(isJobList: true);

        break;
      }
    }
    for (int i = 0; i < selectedJobList.length; i++) {
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (selectedJobList[i].dropLocationNameList[j].id == id) {
          if (selectedJobList[i].dropLocationNameList[j].priority > 0) {
            selectedJobList[i].dropLocationNameList[j].priority--;
            notifyListeners();
          }
          isOptimizedButtonEnabled();
          notifyListeners();
          break;
        }
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        if (uploadedExcelToOptimizeMarkerList[i].priority > 0) {
          uploadedExcelToOptimizeMarkerList[i].priority--;
          notifyListeners();
        }
        break;
      }
    }
  }

  void updateStartTime(int id, DateTime startTime) {
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        uploadedExcelModelList[i].startTime = startTime;

        isOptimizedButtonEnabled();
        notifyListeners();
        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        uploadedExcelToOptimizeMarkerList[i].startTime = startTime;
        notifyListeners();
        break;
      }
    }
  }

  void updateStartTimeForOptimizedMarker(int id, DateTime startTime) {
    for (int i = 0; i < selectedJobList.length; i++) {
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (selectedJobList[i].dropLocationNameList[j].id == id) {
          selectedJobList[i].dropLocationNameList[j].startTime = startTime;
          isOptimizedButtonEnabled(isJobList: true);
          notifyListeners();
          break;
        }
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        uploadedExcelToOptimizeMarkerList[i].startTime = startTime;
        notifyListeners();
        break;
      }
    }
  }

  void updateEndTime(int id, DateTime endTime) {
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        uploadedExcelModelList[i].endTime = endTime;

        notifyListeners();
        isOptimizedButtonEnabled();

        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        uploadedExcelToOptimizeMarkerList[i].endTime = endTime;

        break;
      }
    }
  }

  void updateEndTimeForOptimizedMarker(int id, DateTime endTime) {
    for (int i = 0; i < selectedJobList.length; i++) {
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (selectedJobList[i].dropLocationNameList[j].id == id) {
          selectedJobList[i].dropLocationNameList[j].endTime = endTime;
          isOptimizedButtonEnabled(isJobList: true);
          notifyListeners();
          break;
        }
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        uploadedExcelToOptimizeMarkerList[i].endTime = endTime;

        break;
      }
    }
  }

  void increaseServiceTime(int id) {
    int service = 0;
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        service = uploadedExcelModelList[i].serviceTime;
        service = service + 1;
        uploadedExcelModelList[i].serviceTime = service;
        notifyListeners();

        isOptimizedButtonEnabled();
        break;
      }
    }
    for (int k = 0; k < uploadedExcelToOptimizeMarkerList.length; k++) {
      if (uploadedExcelToOptimizeMarkerList[k].id == id) {
        uploadedExcelToOptimizeMarkerList[k].serviceTime = service;
        notifyListeners();
        break;
      }
    }
  }

  void increaseServiceTimeByType(
      {required int id, required int service, required int index}) {
    uploadedExcelModelList[index].serviceTime = service;
    isOptimizedButtonEnabled();
    notifyListeners();

    for (int k = 0; k < uploadedExcelToOptimizeMarkerList.length; k++) {
      if (uploadedExcelToOptimizeMarkerList[k].id == id) {
        uploadedExcelToOptimizeMarkerList[k].serviceTime = service;
        notifyListeners();
        break;
      }
    }
  }

  void increasePriorityByType(
      {required int id, required int priority, required int index}) {
    uploadedExcelModelList[index].priority = priority;
    isOptimizedButtonEnabled();
    notifyListeners();

    for (int k = 0; k < uploadedExcelToOptimizeMarkerList.length; k++) {
      if (uploadedExcelToOptimizeMarkerList[k].id == id) {
        uploadedExcelToOptimizeMarkerList[k].priority = priority;
        notifyListeners();
        break;
      }
    }
  }

  void increaseServiceTimeByTypeForOptimizedMarker({
    required int id,
    required int service,
    required int dropLocationIndex,
    required int selectedJobIndex,
  }) {
    selectedJobList[selectedJobIndex]
        .dropLocationNameList[dropLocationIndex]
        .serviceTime = service;
    isOptimizedButtonEnabled(isJobList: true);

    notifyListeners();

    for (int k = 0; k < uploadedExcelToOptimizeMarkerList.length; k++) {
      if (uploadedExcelToOptimizeMarkerList[k].id == id) {
        uploadedExcelToOptimizeMarkerList[k].serviceTime = service;
        notifyListeners();
        break;
      }
    }
  }

  void increasePriorityByTypeForOptimizedMarker({
    required int id,
    required int priority,
    required int dropLocationIndex,
    required int selectedJobIndex,
  }) {
    selectedJobList[selectedJobIndex]
        .dropLocationNameList[dropLocationIndex]
        .priority = priority;
    isOptimizedButtonEnabled(isJobList: true);

    notifyListeners();

    for (int k = 0; k < uploadedExcelToOptimizeMarkerList.length; k++) {
      if (uploadedExcelToOptimizeMarkerList[k].id == id) {
        uploadedExcelToOptimizeMarkerList[k].priority = priority;
        notifyListeners();
        break;
      }
    }
  }

  void increaseServiceTimeForOptimizedMarker(int id) {
    for (int i = 0; i < selectedJobList.length; i++) {
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (selectedJobList[i].dropLocationNameList[j].id == id) {
          selectedJobList[i].dropLocationNameList[j].serviceTime++;
          isOptimizedButtonEnabled(isJobList: true);
          notifyListeners();
          break;
        }
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        uploadedExcelToOptimizeMarkerList[i].serviceTime++;
        notifyListeners();
        break;
      }
    }
  }

  void decreaseServiceTime(int id) {
    int service = 0;
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModelList[i].id == id) {
        service = uploadedExcelModelList[i].serviceTime;
        if (service > 0) {
          service = service - 1;
          uploadedExcelModelList[i].serviceTime = service;
          isOptimizedButtonEnabled();
          notifyListeners();
        }
        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        if (uploadedExcelToOptimizeMarkerList[i].serviceTime > 0) {
          uploadedExcelToOptimizeMarkerList[i].serviceTime = service;
          notifyListeners();
        }
        break;
      }
    }
  }

  void decreaseServiceTimeForOptimizedMarker(int id) {
    for (int i = 0; i < selectedJobList.length; i++) {
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (selectedJobList[i].dropLocationNameList[j].id == id) {
          if (selectedJobList[i].dropLocationNameList[j].serviceTime > 0) {
            selectedJobList[i].dropLocationNameList[j].serviceTime--;
          }
          isOptimizedButtonEnabled(isJobList: true);
          notifyListeners();
          break;
        }
      }
    }

    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelToOptimizeMarkerList[i].id == id) {
        if (uploadedExcelToOptimizeMarkerList[i].serviceTime > 0) {
          uploadedExcelToOptimizeMarkerList[i].serviceTime--;
          notifyListeners();
        }
        break;
      }
    }
  }

  void isOptimizedButtonEnabled({bool isJobList = false}) {
    if (isJobList) {
      bool areJobListsAreSame =
          areJobModelListsEqual(selectedJobList, selectedJobListAfterOptimized);
      isOptimizeButtonEnabled = areJobListsAreSame;
      return;
    }

    if (uploadedExcelToOptimizeMarkerList.isNotEmpty &&
        uploadedExcelModelList.isEmpty &&
        selectedVehicleList.isNotEmpty &&
        checkIsJobActivated() &&
        checkIsItemSelected()) {
      isOptimizeButtonEnabled = true;
      return;
    }

    // print(
    //     "uploadedExcelModelList.isEmpty --> ${uploadedExcelModelList.isEmpty}");
    if (uploadedExcelModelList.isEmpty) {
      isOptimizeButtonEnabled = false;
      return;
    }
    // print("selectedVehicleList.isEmpty --> ${selectedVehicleList.isEmpty}");
    if (selectedVehicleList.isEmpty) {
      isOptimizeButtonEnabled = false;
      return;
    }

    bool isBothListIsEqual = areUploadedExcelModelListsEqual(
        uploadedExcelModelList, checkExcelModelIsSameList);

    bool isItemSelected = checkIsItemSelected();

    bool isJobActivated = checkIsJobActivated();
    // print(
    //     "selectedVehicleList.isEmpty -->isBothListIsEqual $isBothListIsEqual isItemSelected $isItemSelected isJobActivated $isJobActivated");

    if (isBothListIsEqual && isItemSelected && isJobActivated) {
      isOptimizeButtonEnabled = true;
    } else {
      isOptimizeButtonEnabled = false;
    }
  }

  bool areUploadedExcelModelListsEqual(
      List<UploadedExcelModel> list1, List<UploadedExcelModel> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].priority != list2[i].priority ||
          list1[i].serviceTime != list2[i].serviceTime ||
          list1[i].startTime != list2[i].startTime ||
          list1[i].endTime != list2[i].endTime) {
        return false;
      }
    }

    return true;
  }

  bool checkIsJobActivated() {
    for (int i = 0; i < selectedJobList.length; i++) {
      if (selectedJobList[i].isJobActivated == true) {
        return true;
      }
    }
    return false;
  }

  bool checkIsItemSelected() {
    for (int i = 0; i < selectedJobList.length; i++) {
      if (selectedJobList[i].isItemSelected == true) {
        return true;
      }
    }
    return false;
  }

  Future<void> callOptimizeApi() async {
    isRouteOptimizedActivated = true;

    List<Job> jobs = [];
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      jobs.add(Job(
          priority: uploadedExcelToOptimizeMarkerList[i].priority,
          service: uploadedExcelToOptimizeMarkerList[i].serviceTime,
          timeWindows: [
            [
              uploadedExcelToOptimizeMarkerList[i]
                      .startTime
                      .millisecondsSinceEpoch ~/
                  1000,
              uploadedExcelToOptimizeMarkerList[i]
                      .endTime
                      .millisecondsSinceEpoch ~/
                  1000,
            ]
          ],
          delivery: [1],
          description: uploadedExcelToOptimizeMarkerList[i].name,
          location: [
            uploadedExcelToOptimizeMarkerList[i].lng,
            uploadedExcelToOptimizeMarkerList[i].lat,
          ],
          id: uploadedExcelToOptimizeMarkerList[i].id));
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {}
    List<Vehicles> vehiclesList = [];
    List<Map<String, dynamic>> vehiclesWithoutRoundTripList = [];

    for (int i = 0; i < selectedJobList.length; i++) {
      if (selectedJobList[i].isJobActivated) {
        Vehicles vehicles = Vehicles(
            capacity: [28],
            end: [depoLocation.longitude, depoLocation.latitude],
            endDescription: isRoundTripAvailable ? "TJUK" : "",
            id: selectedJobList[i].id,
            profile: "truck",
            speedFactor: 0.6,
            start: [depoLocation.longitude, depoLocation.latitude],
            startDescription: "TJUK");
        if (isRoundTripAvailable) {
          vehiclesList.add(vehicles);
        } else {
          vehiclesWithoutRoundTripList.add({
            'capacity': [28],
            'id': selectedJobList[i].id,
            'profile': "truck",
            'speedFactor': 0.6,
            'start': [depoLocation.longitude, depoLocation.latitude],
            'startDescription': "TJUK"
          });
        }
      }
    }

    //

    String body = jsonEncode({
      "jobs": jobs.map((e) => e.toJson()).toList(),
      "options": {"g": true},
      "vehicles": isRoundTripAvailable
          ? vehiclesList.map((e) => e.toJson()).toList()
          : vehiclesWithoutRoundTripList,
    });

    try {
      var res = await http.post(
        Uri.parse('http://139.5.189.244:3000/'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        lastDepoLocation = depoLocation;
        assignedExcelModelList = [];
        isSelectVehicleDropDownOpen = false;
        OptimizedRouteModel optimizedRouteServerResponse =
            OptimizedRouteModel.fromJson(jsonDecode(res.body));
        if (optimizedRouteServerResponse.code == 0) {
          isOptimizeButtonEnabled = false;

          optimizedRouteModel = optimizedRouteServerResponse;
          for (int i = 0; i < optimizedRouteModel.routes.length; i++) {
            optimizedRouteModel.routes[i].polylines =
                polylinePoints.PolylinePoints()
                    .decodePolyline(optimizedRouteModel.routes[i].geometry!);
          }
          List<UploadedExcelModel> unassignedJobList =
              List.from(uploadedExcelToOptimizeMarkerList);

          uploadedExcelModelList = [];
          for (int i = 0; i < optimizedRouteModel.unassigned.length; i++) {
            for (int j = 0; j < unassignedJobList.length; j++) {
              if (optimizedRouteModel.unassigned[i].id ==
                  unassignedJobList[j].id) {
                uploadedExcelModelList.add(unassignedJobList[j]);
                break;
              }
            }
          }
          checkExcelModelIsSameList = List.from(uploadedExcelModelList);

          int routesIndex = 0;
          for (int i = 0; i < selectedJobList.length; i++) {
            if (routesIndex == optimizedRouteModel.routes.length) {
              break;
            }
            if (optimizedRouteModel.routes[routesIndex].steps != null) {
              if (selectedJobList[i].isJobActivated) {
                optimizedRouteModel.routes[routesIndex].color =
                    selectedJobList[i].color;
                selectedJobList[i].stops =
                    optimizedRouteModel.routes[routesIndex].steps!.length - 2;
                selectedJobList[i].dropLocationNameList =
                    optimizedRouteModel.routes[routesIndex].steps ?? [];
                optimizedRouteModel.routes[routesIndex].id =
                    selectedJobList[i].id;
                optimizedRouteModel.routes[routesIndex].vehicleId =
                    selectedJobList[i].vehicleId;
                // selectedJobList[i].dropLocationNameList[routesIndex].globalKey =
                //     GlobalKey();
                routesIndex = routesIndex + 1;
              }
            }
          }
          for (int i = 0; i < selectedJobList.length; i++) {
            if (selectedJobList[i].isJobActivated) {
              selectedJobList[i].isDropDownMenuOpen = true;
              break;
            }
          }
          for (int i = 0; i < selectedJobList.length; i++) {
            int duration = 0;
            for (int j = 0;
                j < selectedJobList[i].dropLocationNameList.length;
                j++) {
              for (int k = 0;
                  k < uploadedExcelToOptimizeMarkerList.length;
                  k++) {
                if (uploadedExcelToOptimizeMarkerList[k].id ==
                    selectedJobList[i].dropLocationNameList[j].id) {
                  // selectedJobList[i].dropLocationNameList[j].duration =
                  //     duration;
                  assignedExcelModelList
                      .add(uploadedExcelToOptimizeMarkerList[k]);

                  selectedJobList[i].dropLocationNameList[j].priority =
                      uploadedExcelToOptimizeMarkerList[k].priority;
                  selectedJobList[i].dropLocationNameList[j].serviceTime =
                      uploadedExcelToOptimizeMarkerList[k].serviceTime;
                  selectedJobList[i].dropLocationNameList[j].startTime =
                      uploadedExcelToOptimizeMarkerList[k].startTime;
                  selectedJobList[i].dropLocationNameList[j].endTime =
                      uploadedExcelToOptimizeMarkerList[k].endTime;
                  selectedJobList[i].dropLocationNameList[j].globalKey =
                      GlobalKey();

                  break;
                }
              }
              duration = (duration +
                      selectedJobList[i].dropLocationNameList[j].duration) +
                  (selectedJobList[i].dropLocationNameList[j].serviceTime * 60);
              selectedJobList[i].dropLocationNameList[j].totalTravelDuration =
                  duration;
            }
          }
          notifyListeners();
        }
        List<LatLng> latLngList = [];
        for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
          latLngList.add(LatLng(uploadedExcelToOptimizeMarkerList[i].lat,
              uploadedExcelToOptimizeMarkerList[i].lng));
        }
        LatLng latLng = findCenterLatLng(latLngList);
        mapController!.move(latLng, 11);

        selectedJobListAfterOptimized = List.from(selectedJobList);
        isRouteOptimizedActivated = false;
        selectedAssignableType = "Assigned";
        checkUploadedExcelToOptimizeMarkerListIsSame =
            List.from(uploadedExcelToOptimizeMarkerList);
      } else {
        showToast(title: jsonDecode(res.body)['error']);
      }
    } catch (e) {
      lastDepoLocation = const LatLng(0, 0);

      showToast(title: "Failed to draw your route!");

      isRouteOptimizedActivated = false;
    }
    isRouteOptimizedActivated = false;
  }

  bool areDropLocationListsEqual(List<RouteStep> list1, List<RouteStep> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }

  bool areJobModelListsEqual(List<JobModel> list1, List<JobModel> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (!areDropLocationListsEqual(
          list1[i].dropLocationNameList, list2[i].dropLocationNameList)) {
        return false;
      }
    }

    return true;
  }

  LatLng findCenterLatLng(List<LatLng> coordinates) {
    double totalLatitude = 0.0;
    double totalLongitude = 0.0;

    for (LatLng coord in coordinates) {
      totalLatitude += coord.latitude;
      totalLongitude += coord.longitude;
    }

    double centerLatitude = totalLatitude / coordinates.length;
    double centerLongitude = totalLongitude / coordinates.length;

    return LatLng(centerLatitude, centerLongitude);
  }

  Color _generateNewColor() {
    // final random = Random();
    // Color color;

    // Define a threshold to avoid generating white or very light colors
    // const threshold = 500;

    // do {
    //   color = Color.fromARGB(
    //     255, // Alpha channel (fully opaque)
    //     random.nextInt(256), // Red channel (0-255)
    //     random.nextInt(256), // Green channel (0-255)
    //     random.nextInt(256), // Blue channel (0-255)
    //   );
    // } while (color.red + color.green + color.blue < threshold);
    final Random random = Random();
    // Generate random RGB values between 0 and 128 for a dark color
    final int red = random.nextInt(128);
    final int green = random.nextInt(128);
    final int blue = random.nextInt(128);
    return Color.fromRGBO(red, green, blue, 1.0);

    // return color;
  }

  DateTime currentTime({required DateTime dateTime, bool nextDayDate = false}) {
    return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        nextDayDate
            ? DateTime.now().add(const Duration(days: 1)).day
            : DateTime.now().day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second);
  }

  Future<bool> isCargoNoExists(
      {required String cargoNo, int? index, bool isUpdate = false}) async {
    for (int i = 0; i < selectedJobList.length; i++) {
      if (selectedJobList[i].vehicleNo == cargoNo) {
        if (isUpdate && i == index) {
          return false;
        }
        return true;
      }
    }
    return false;
  }

  bool _isOptionsAvailable = false;
  bool get isOptionsAvailable => _isOptionsAvailable;
  set isOptionsAvailable(bool val) {
    _isOptionsAvailable = val;
    notifyListeners();
  }

  bool _isLocationSearching = false;
  bool get isLocationSearching => _isLocationSearching;
  set isLocationSearching(bool val) {
    _isLocationSearching = val;
    notifyListeners();
  }

  bool _isSelectValidAddress = false;
  bool get isSelectValidAddress => _isSelectValidAddress;
  set isSelectValidAddress(bool val) {
    _isSelectValidAddress = val;
    notifyListeners();
  }

  bool _isLatSearching = false;
  bool get isLatSearching => _isLatSearching;
  set isLatSearching(bool val) {
    _isLatSearching = val;
    notifyListeners();
  }

  bool _isLongSearching = false;
  bool get isLongSearching => _isLongSearching;
  set isLongSearching(bool val) {
    _isLongSearching = val;
    notifyListeners();
  }

  List<OpenStreetPlaceResponse> _searchOpenStreetPlaceResponseList = [];
  List<OpenStreetPlaceResponse> get searchOpenStreetPlaceResponseList =>
      _searchOpenStreetPlaceResponseList;
  set searchOpenStreetPlaceResponseList(List<OpenStreetPlaceResponse> val) {
    _searchOpenStreetPlaceResponseList = val;
    notifyListeners();
  }

  late OpenStreetPlaceResponse _openStreetPlaceResponseList;
  OpenStreetPlaceResponse get openStreetPlaceResponseList =>
      _openStreetPlaceResponseList;
  set openStreetPlaceResponseList(OpenStreetPlaceResponse val) {
    _openStreetPlaceResponseList = val;
    notifyListeners();
  }

  Future<List<OpenStreetPlaceResponse>> searchOnChanged(
      {required String searchText}) async {
    searchOpenStreetPlaceResponseList = [];

    var response = await http.get(Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$searchText&limit=5&format=json&addressdetails=1&countrycodes=IN"));

    if (response.statusCode == 200) {
      try {
        List apiDataList = jsonDecode(response.body);
        searchOpenStreetPlaceResponseList = apiDataList.map((jsonObject) {
          return OpenStreetPlaceResponse.fromJson(jsonObject);
        }).toList();
      } catch (e) {
        searchOpenStreetPlaceResponseList = [];
      }
    }

    notifyListeners();
    return searchOpenStreetPlaceResponseList;
  }

  void updateUploadExcelItemList(UploadedExcelModel uploadedExcelModel) {
    uploadedExcelModelList.add(uploadedExcelModel);
    uploadedExcelToOptimizeMarkerList.add(uploadedExcelModel);
    checkExcelModelIsSameList.add(uploadedExcelModel);
    isOptimizedButtonEnabled();

    notifyListeners();
  }

  void updateUploadExcelItemListByIndex(
      UploadedExcelModel uploadedExcelModel, int index) {
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (uploadedExcelModel.id == _uploadedExcelModelList[i].id) {
        uploadedExcelModelList[i] = uploadedExcelModel;
        mapController?.move(
            LatLng(uploadedExcelModel.lat, uploadedExcelModel.lng),
            mapController?.zoom ?? 18);

        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (uploadedExcelModel.id == uploadedExcelToOptimizeMarkerList[i].id) {
        uploadedExcelToOptimizeMarkerList[i] = uploadedExcelModel;
        break;
      }
    }

    for (int i = 0; i < checkExcelModelIsSameList.length; i++) {
      if (checkExcelModelIsSameList[i].id == uploadedExcelModel.id) {
        checkExcelModelIsSameList[i] = uploadedExcelModel;
        break;
      }
    }

    notifyListeners();
  }

  void updateOptimizedPointsListByIndex(
      {required RouteStep routeStep,
      required UploadedExcelModel uploadedExcelModel,
      required int id}) {
    // uploadedExcelModelList.add(uploadedExcelModel);
    // int id = uploadedExcelToOptimizeMarkerList[index].id;

    // uploadedExcelToOptimizeMarkerList.;
    bool isIdMatched = false;
    for (int i = 0; i < selectedJobList.length; i++) {
      if (isIdMatched) {
        break;
      }
      for (int j = 0; j < selectedJobList[i].dropLocationNameList.length; j++) {
        if (id == selectedJobList[i].dropLocationNameList[j].id) {
          isIdMatched = true;
          selectedJobList[i].dropLocationNameList[j] = routeStep;
          mapController?.move(
              LatLng(routeStep.location[1], routeStep.location[0]),
              mapController?.zoom ?? 21);

          notifyListeners();
          break;
        }
      }
    }

    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {
      if (id == uploadedExcelToOptimizeMarkerList[i].id) {
        uploadedExcelToOptimizeMarkerList[i] = uploadedExcelModel;

        break;
      }
    }
    for (int i = 0; i < uploadedExcelToOptimizeMarkerList.length; i++) {}
    for (int i = 0; i < uploadedExcelModelList.length; i++) {
      if (id == uploadedExcelModel.id) {
        uploadedExcelModelList[i] = uploadedExcelModel;

        break;
      }
    }

    for (int i = 0; i < checkExcelModelIsSameList.length; i++) {
      if (id == uploadedExcelModel.id) {
        checkExcelModelIsSameList[i] = uploadedExcelModel;

        break;
      }
    }
    isOptimizedButtonEnabled(isJobList: true);

    notifyListeners();
  }

  Future<OpenStreetPlaceResponse?> fetchLocationNameFromLatLong(
      LatLng latLng) async {
    OpenStreetPlaceResponse? openStreetPaceResponse;
    var res = await http.get(Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?lat=${latLng.latitude}&lon=${latLng.longitude}&format=json"));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      if (map.containsKey('error')) {
        showToast(title: map['error']);
        return null;
      } else {
        openStreetPaceResponse =
            OpenStreetPlaceResponse.fromJson(jsonDecode(res.body));
        return openStreetPaceResponse;
      }
    } else {
      return null;
    }
  }
}
