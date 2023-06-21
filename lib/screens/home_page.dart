import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api_project/utils/utils.dart';

import '../controller/git_controller.dart';
import '../widgets/single_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListView = true;
  @override
  Widget build(BuildContext context) {
    final GitApiController controller = Get.put(GitApiController());

    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                isListView = !isListView;
                setState(() {});
              },
              icon: const Icon(Icons.settings),
            ),
            Expanded(
              child: Obx(
                () {
                  return isListView
                      ? ListView.builder(
                          itemCount: controller.gitRepoList.length,
                          itemBuilder: (context, index) {
                            var model = controller.gitRepoList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleRepository(
                                isPrivate: model.private!,
                                language: model.language ?? "Not specified",
                                repositoryName: model.name!,
                                createdAt:
                                    Utils.formatDateTime(model.createdAt),
                              ),
                            );
                          },
                        )
                      : GridView.builder(
                          itemCount: controller.gitRepoList.length,
                          itemBuilder: (context, index) {
                            var model = controller.gitRepoList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleRepository(
                                isPrivate: model.private!,
                                language: model.language ?? "Not specified",
                                repositoryName: model.name!,
                                createdAt:
                                    Utils.formatDateTime(model.createdAt),
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

