import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api_project/model/repo_model.dart';
import 'package:github_api_project/service/network_service.dart';

class GitApiController extends GetxController {
  var gitRepoList = List<RepoModel>.empty(growable: true).obs;

  Future<void> fetchApiData(String userName) async {
    try {
      var repos = await NetworkSever().fetchRepoData(userName);
      if (repos.isNotEmpty) {
        gitRepoList.value = repos;
      }
    } catch (e) {
      debugPrint("Error from fetchRepo ${e.toString()}");
    }
  }

  Future<bool> isUserExists(String userName) async {
    if (await NetworkSever().isUserExist(userName)) {
      return true;
    }
    return false;
  }
}
