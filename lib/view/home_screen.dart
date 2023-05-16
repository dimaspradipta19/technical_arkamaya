import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/view/detail_screen.dart';
import 'package:technical_arkamaya/viewmodel/providers/detail_user_provider.dart';
import 'package:technical_arkamaya/viewmodel/providers/list_user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ListUserProvider>(context, listen: false).getListUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List User"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Consumer<ListUserProvider>(
          builder: (context, valueListUser, child) {
            if (valueListUser.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (valueListUser.state == ResultState.hasData) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: valueListUser.listUser!.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Provider.of<DetailUserProvider>(context,
                                  listen: false)
                              .getDetailUser(
                                  valueListUser.listUser!.data[index].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailScreen(
                                    idUser:
                                        valueListUser.listUser!.data[index].id);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  BoxDecoration(color: Colors.green[50]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: CachedNetworkImage(
                                        imageUrl: valueListUser
                                            .listUser!.data[index].avatar,
                                        errorWidget: (context, url, error) =>
                                            const CircularProgressIndicator
                                                .adaptive(),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              valueListUser.listUser!
                                                  .data[index].firstName,
                                              style: const TextStyle(
                                                  fontSize: 20.0),
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              valueListUser.listUser!
                                                  .data[index].lastName,
                                              style: const TextStyle(
                                                  fontSize: 20.0),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(valueListUser
                                            .listUser!.data[index].email)
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ))
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
