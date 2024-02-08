import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class JobDetailContainer extends StatelessWidget {
  final String imageUrl;
  final String containerName;
  final String suffixTitle;
  final int? count;
  final double height;
  final double width;
  final bool isPng;
  const JobDetailContainer(
      {super.key,
      this.isPng = false,
      required this.imageUrl,
      required this.containerName,
      required this.suffixTitle,
      this.count,
      this.height = 15,
      this.width = 15});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        isPng
            ? Image.asset(imageUrl, height: height, width: width)
            : SvgPicture.asset(
                imageUrl,
                height: height,
                width: width,
              ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              containerName,
              style: FontUtilities.h14(
                  fontColor: VariableUtilities.theme.color737B85),
            ),
            Text(
              '${count ?? ''}$suffixTitle',
              style: FontUtilities.h16(
                  fontColor: VariableUtilities.theme.color333333,
                  fontWeight: FWT.semiBold),
            ),
          ],
        )
      ]),
    );
  }
}
