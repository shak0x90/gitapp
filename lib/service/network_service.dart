import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/repo_model.dart';

class NetworkSever {
  Dio client = Dio();

  Future<List<RepoModel>> fetchRepoData(String userName) async {
    String repositoryApiEndpoint =
        "https://api.github.com/users/$userName/repos";
    try {
      final response = await client.get(repositoryApiEndpoint);
      List items = response.data;
      List<RepoModel> repos = items.map<RepoModel>((json) {
        return RepoModel.fromJson(json);
      }).toList();
      return repos;
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  /// check if user exists or not
  Future<bool> isUserExist(String userName) async {
    String userApiEndpoint = "https://api.github.com/users/$userName";
    try {
      await client.get(userApiEndpoint);
      return true;
    } catch (e) {
      debugPrint("Exception from isUserExists Function: ${e.toString()}");
    }
    return false;
  }
}
