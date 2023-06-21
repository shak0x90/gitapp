import 'package:flutter/material.dart';

import '../colors.dart';

class SingleRepository extends StatelessWidget {
  const SingleRepository({
    super.key,
    required this.repositoryName,
    required this.isPrivate,
    required this.language,
    required this.createdAt,
  });

  final String repositoryName;
  final bool isPrivate;
  final String language;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 80,
      decoration: BoxDecoration(
        color: kColorPrimary2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  repositoryName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kColorSecondary2,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: kColorSecondary)),
                child: Text(
                  isPrivate ? "Private" : "Public",
                  style: const TextStyle(
                    color: kColorSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            language,
            style: const TextStyle(
              color: kColorSecondary,
            ),
          ),
          Row(
            children: [
              const Text(
                "Created :",
                style: TextStyle(
                  color: kColorSecondary,
                ),
              ),
              Flexible(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  createdAt,
                  style: const TextStyle(
                    color: kColorSecondary,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}