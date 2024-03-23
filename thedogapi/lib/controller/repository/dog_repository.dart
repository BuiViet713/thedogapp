
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:thedogapi/core/network/api_response_model.dart';
import 'package:thedogapi/core/network/app_urls.dart';
import 'package:thedogapi/core/network/network_service.dart';
import 'package:thedogapi/data/get_all_breeds_model.dart';

import '../dog_controller.dart';

abstract class AbstractDogRepository {
  Future<GetAllDogModel> getAllBreeds();
  Future<String> getRandomImageByBreed(String breedName);
  Future<String> getRandomImageBySubBreed(String breedName, String subBreed);
  Future<Map<String, dynamic>> imageListByBreed(String breedName);
  Future<Map<String, dynamic>> imageListBySubBreed(
      String breedName, String subBreedName);
}

class DogRepository implements AbstractDogRepository {
  final PawNetworkService _networkService;
  DogRepository(this._networkService);

// Get all breeds
  @override
  Future<GetAllDogModel> getAllBreeds() async {
    final getAllBreedsRequest =
        await _networkService.getRequest(AppUrls.allBreedsUrl);

    ApiResponse response = ApiResponse.fromJson(getAllBreedsRequest);

    GetAllDogModel getAllDogsModel = GetAllDogModel.fromJson(response.message);

    return getAllDogsModel;
  }

  @override
  Future<String> getRandomImageByBreed(String breedName) async {
    final getImageByBreedRequest = await _networkService.getRequest(
        "${AppUrls.breedService}/$breedName${AppUrls.getRandomImageByBreedUrl}");

    ApiResponse response = ApiResponse.fromJson(getImageByBreedRequest);
    return response.message;
  }

  @override
  Future<Map<String, dynamic>> imageListByBreed(String breedName) async {
    final getAllBreedsRequest = await _networkService.getRequest(
        "${AppUrls.breedService}/$breedName${AppUrls.imageListByBreed}");

    return getAllBreedsRequest;
  }
  @override
  Future<void> getAllFavoritesFromFirestore(BuildContext context) async {
    try {
      // Lấy UID của người dùng hiện tại
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      // Kiểm tra xem người dùng đã đăng nhập chưa
      if (userId != null) {
        // Truy vấn Firestore để lấy danh sách giống cún yêu thích của người dùng hiện tại
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Favorite')
            .where('User', isEqualTo: userId)
            .get();

        // Tạo danh sách yêu thích từ kết quả truy vấn
        List<String> favoriteBreeds = querySnapshot.docs.map((doc) => doc['breed'] as String).toList();

        // Cập nhật danh sách yêu thích trong DogBreedProvider
        Provider.of<DogBreedProvider>(context, listen: false).setFavoriteBreeds(favoriteBreeds);
      } else {
        print('Error: User is not logged in.');
      }
    } catch (e) {
      print('Error getting favorites from Firestore: $e');
    }
  }

  @override
  Future<String> getRandomImageBySubBreed(
      String breedName, String subBreed) async {
    final getSubBreedRandomImage = await _networkService.getRequest(
        "${AppUrls.breedService}/$breedName/$subBreed${AppUrls.getRandomImageByBreedUrl}");
    ApiResponse response = ApiResponse.fromJson(getSubBreedRandomImage);
    return response.message;
  }

  @override
  Future<Map<String, dynamic>> imageListBySubBreed(
      String breedName, String subBreedName) async {
    final getAllBreedsRequest = await _networkService.getRequest(
        "${AppUrls.breedService}/$breedName/$subBreedName/${AppUrls.imageListByBreed}");

    return getAllBreedsRequest;
  }
}
