import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/view/about_screen.dart';
import 'package:technical_arkamaya/view/add_user_screen.dart';
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

  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0 || index == 1 || index == 2) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return _widgetOption.elementAt(index);
        },
      ), (route) => false);
    }
  }

  final List<Widget> _widgetOption = [
    const HomeScreen(),
    const AddUserScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List User"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "List User"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: "About"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
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
