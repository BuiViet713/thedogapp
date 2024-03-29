import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/Cofig/assets.dart';
import 'package:thedogapi/Cofig/shared/render_assets.dart';
import 'package:thedogapi/Cofig/shared/search_bar.dart';
import 'package:thedogapi/Cofig/strings.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_palette.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_typography.dart';
import 'package:thedogapi/core/utls/extensions/extensions.dart';
import 'package:thedogapi/core/utls/helper_functions/functions.dart';
import 'package:thedogapi/pages/home/presenter/breeds_list_view.dart';

import '../../../controller/dog_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dogRepository.getAllFavoritesFromFirestore(context);
    final DogTypography? typography =
        context.appTheme.extension<DogTypography>();
    final PawPallete? palette = context.appTheme.extension<PawPallete>();
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        dismissKeyboard();
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Dogs App',
                style: typography?.medium?.copyWith(
                  color: palette?.primaryColor,
                  fontSize: 32, // Kích thước chữ lớn hơn
                  fontWeight: FontWeight.bold, // Đậm
                  fontFamily: 'Roboto', // Sử dụng font chữ Roboto
                ),
              ),
            ).marginOnly(bottom: 20),

            Container(
              width: double.infinity,
              height: 44.0.sp,
              decoration: BoxDecoration(
                border: Border.all(
                  color: palette!.textColor!,
                ),
                color: palette.backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Center(
                  child: Row(
                children: [
                  const DogWidgetsRenderSvg(
                    svgPath: searchIcon,
                  ).marginSymmetric(horizontal: 5),
                  addHorizontalSpacing(5),
                  Expanded(
                    child: Consumer<DogBreedProvider>(
                        builder: (context, provider, _) {
                      return PawWidgetsSearchBar(
                        controller: textEditingController,
                        onChanged: (val) {
                          provider.filterDogBreeds(val);

                        },
                      );
                    }),
                  )
                ],
              )),
            ),

            //
            addVerticalSpacing(40),
            Text(
              "Breeds",
              style: typography?.medium?.copyWith(fontWeight: FontWeight.bold),
            ),
            addVerticalSpacing(30),
            const Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  BreedListView(),
                ],
              ),
            ))
            //
          ],
        ).marginSymmetric(vertical: 20, horizontal: 15),
      ),
    ));
  }
}

