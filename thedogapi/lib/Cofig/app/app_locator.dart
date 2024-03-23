
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:thedogapi/core/navigation/navigation.dart';
import 'package:thedogapi/core/network/network_service.dart';
import 'package:thedogapi/controller/dog_controller.dart';
import 'package:thedogapi/controller/repository/dog_repository.dart';

final appRouter = AppRouter();
final networksService = PawNetworkService();
final dogRepository = DogRepository(networksService);

//controllers

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) {
      return DogBreedProvider(dogRepository);
    },
  ),
];
