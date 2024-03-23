import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/Cofig/shared/image_view.dart';
import 'package:thedogapi/Cofig/shared/loader.dart';
import 'package:thedogapi/core/navigation/routes.dart';
import 'package:thedogapi/core/utls/extensions/extensions.dart';
import 'package:thedogapi/core/utls/helper_functions/functions.dart';
import 'package:thedogapi/controller/dog_controller.dart';
import 'package:thedogapi/pages/home/presenter/sub_breed_view.dart';

class BreedListView extends StatelessWidget {
  const BreedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DogBreedProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<void>(
          future: provider.getAllBreedsList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const PawsWidgetLoader().center.marginOnly(top: 10);
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpacing(40),
                  const PawsWidgetErrorWidget(),
                  addVerticalSpacing(25),
                ],
              ).center.marginOnly(top: 5.5);
            } else {
              return Column(
                children: [
                  for (int i = 0; i < provider.dogBreedsNames.length; i++) ...[
                    _BreedListItem(
                      breedName: provider.dogBreedsNames[i],
                      isFavorite: provider.favoriteBreeds.contains(provider.dogBreedsNames[i]),
                      onTapFavorite: () async {
                        final breedName = provider.dogBreedsNames[i];
                        if (provider.favoriteBreeds.contains(breedName)) {
                          await removeFromFavoritesOnFirestore(breedName, context);
                        } else {
                          await addToFavoritesOnFirestore(breedName, context);
                        }
                      },
                    ),
                    addVerticalSpacing(20),
                  ],
                  if (provider.dogBreedsNames.isEmpty)
                    const Text("No dog found ").center
                ],
              );
            }
          },
        );
      },
    );
  }
}

class _BreedListItem extends StatelessWidget {
  final String breedName;
  final bool isFavorite;
  final VoidCallback onTapFavorite;

  const _BreedListItem({
    Key? key,
    required this.breedName,
    required this.isFavorite,
    required this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hình ảnh và tiêu đề của con chó
        ImageViewAndTitle(
          ontap: () {
            appRouter.pushNamed(
              AppRoute.subBreedView,
              arguments: SubBreedArgument(
                subBreed: Provider.of<DogBreedProvider>(context, listen: false).allBreedData!.breeds[breedName],
                breed: breedName,
              ),
            );
          },
          title: breedName,
        ),
        // Nút trái tim yêu thích
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
              size: 30,
            ),
            onPressed: onTapFavorite,
          ),
        ),
      ],
    );
  }
}

Future<void> addToFavoritesOnFirestore(String breedName, BuildContext context) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('Favorite').add({
        'User': userId,
        'breed': breedName,
      });
      await getAllFavoritesFromFirestore(context);
    } else {
      print('Error: User is not logged in.');
    }
  } catch (e) {
    print('Error adding $breedName to Firestore: $e');
  }
}

Future<void> removeFromFavoritesOnFirestore(String breedName, BuildContext context) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favorite')
          .where('User', isEqualTo: userId)
          .where('breed', isEqualTo: breedName)
          .get();
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      await getAllFavoritesFromFirestore(context);
    } else {
      print('Error: User is not logged in.');
    }
  } catch (e) {
    print('Error removing $breedName from Firestore: $e');
  }
}

Future<void> getAllFavoritesFromFirestore(BuildContext context) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favorite')
          .where('User', isEqualTo: userId)
          .get();
      final favoriteBreeds = querySnapshot.docs.map((doc) => doc['breed'] as String).toList();
      Provider.of<DogBreedProvider>(context, listen: false).setFavoriteBreeds(favoriteBreeds);
    } else {
      print('Error: User is not logged in.');
    }
  } catch (e) {
    print('Error getting favorites from Firestore: $e');
  }
}
