import 'package:flutter/material.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/mvp/src/home/view/selected_vehicles_with_stops_widget.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class CreateNewVehicleWidget extends StatelessWidget {
  const CreateNewVehicleWidget({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {
          showDialogForUpdate(
              cargoEndTime: '',
              cargoHeight: '',
              cargoId: '',
              cargoLength: '',
              cargoName: '',
              cargoNo: '',
              cargoPayload: '',
              cargoStartTime: '',
              cargoStops: '',
              cargoTopSpeed: '',
              index: 0,
              isUpdate: false,
              context: context,
              homeProvider: homeProvider);
        },
        child: Container(
          width: 150,
          color: Colors.transparent,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Select Vehicles',
              style: FontUtilities.h14(
                  fontColor: VariableUtilities.theme.blackColor,
                  fontWeight: FWT.semiBold),
            ),
            const SizedBox(width: 10),
            Image.asset(AssetUtils.addRoundedIcon, height: 18, width: 18),
          ]),
        ),
      ),
    );
  }
}
