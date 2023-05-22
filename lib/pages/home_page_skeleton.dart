import 'package:arrosage_eco/components/animated_color_container.dart';
import 'package:arrosage_eco/components/header.dart';
import 'package:arrosage_eco/pages/base_page.dart';
import 'package:flutter/material.dart';

class HomePageSkeleton extends StatelessWidget {
  const HomePageSkeleton(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.changeIp})
      : super(key: key);
  final String title;
  final String subtitle;
  final Function(String) changeIp;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      header: Header(
        title: title,
        subtitle: subtitle,
        changeIp: changeIp,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 150,
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: AnimatedColorContainer(
                      padding: const EdgeInsets.only(right: 10.0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: AnimatedColorContainer(
                      padding: const EdgeInsets.only(left: 10.0),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 210,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedColorContainer(
                        padding: const EdgeInsets.only(right: 10.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: AnimatedColorContainer(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            Expanded(
                              child: AnimatedColorContainer(
                                padding: const EdgeInsets.only(top: 10.0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 210,
              child: AnimatedColorContainer(
                padding: const EdgeInsets.only(top: 20.0),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
