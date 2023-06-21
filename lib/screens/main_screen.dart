import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api_project/colors.dart';
import 'package:github_api_project/constants.dart';
import 'package:github_api_project/controller/git_controller.dart';
import 'package:github_api_project/screens/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GitApiController controller = Get.put(GitApiController());
  final TextEditingController _userNameController = TextEditingController();
  bool isLoading = false;
  var formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  /// check user exists and navigate to home page.
  Future<void> _checkUser() async {
    if (await controller.isUserExists(_userNameController.text)) {
      isLoading = true;
      setState(() {});
      try {
        // fetching user repositories.
        await controller.fetchApiData(_userNameController.text);
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ),
          );
        }
        isLoading = false;
        setState(() {});
      } catch (e) {
        debugPrint(
          "user fetch error from home screen ${e.toString()}",
        );
      }
    } else {
      // showing snack bar if user do not exists.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user Found'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kColorPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.githubIcon,
            height: 100,
          ),
          Image.asset(
            AssetsManager.githubLogo,
            height: 100,
          ),
          isLoading
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * .30,
                  child: const LinearProgressIndicator(),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 34),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Color(0XFFFEFEFD)),
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        fillColor: Color(0XFFFEFEFD),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Github Username",
                        hintStyle: TextStyle(color: Color(0XFFFEFEFD)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await _checkUser();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0XFF45954A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Search",
                          style: TextStyle(
                            color: Color(0XFFFEFEFD),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
