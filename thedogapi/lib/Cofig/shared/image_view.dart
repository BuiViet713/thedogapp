import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/Cofig/colors.dart';
import 'package:thedogapi/Cofig/shared/loader.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_typography.dart';
import 'package:thedogapi/core/utls/extensions/extensions.dart';

class ImageViewAndTitle extends StatelessWidget {
  final Future<String>? future;
  final String? title;
  final Function()? ontap;
  const ImageViewAndTitle({
    required this.title,
    this.future,
    this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DogTypography? typography =
        context.appTheme.extension<DogTypography>();
    return GestureDetector(
      onTap: () {
        if (ontap != null) ontap!();
      },
      child: Container(
        height: 220.sp,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Stack(
          children: [
            FutureBuilder(
                future:
                    future ?? dogRepository.getRandomImageByBreed(title ?? ""),
                builder: (context, shot) {
                  if (shot.data != null) {
                    return CachedNetworkImage(
                      imageUrl: shot.data ?? "",
                      imageBuilder: (context, imageProvider) => Stack(
                        children: [
                          Container(
                            height: 220.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      placeholder: (context, url) => ImageLoader(
                        height: 220.sp,
                        width: double.infinity,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error).center,
                    );
                  }
                  return ImageLoader(
                    height: 220.sp,
                    width: double.infinity,
                  );
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 45.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: pawBlack.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.sp),
                      bottomRight: Radius.circular(20.sp),
                    ),
                  ),
                  child: Text(
                    title ?? "Helofff Heighend well",
                    style: typography?.medium?.copyWith(
                      color: pawWhite,
                    ),
                  ).center,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
