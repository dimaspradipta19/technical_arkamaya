import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/view/add_user_screen.dart';
import 'package:technical_arkamaya/view/detail_screen.dart';
import 'package:technical_arkamaya/view/home_screen.dart';
import 'package:technical_arkamaya/viewmodel/providers/detail_user_provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailUserProvider>(context, listen: false).getDetailUser(2);
    });
  }

  int _selectedIndex = 2;

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("About Screen"),
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
      body: SingleChildScrollView(
        child: Consumer<DetailUserProvider>(
          builder: (context, valueDetail, child) {
            if (valueDetail.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (valueDetail.state == ResultState.hasData) {
              return Stack(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue[100]!,
                          Colors.blue,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: CachedNetworkImage(
                              imageUrl: valueDetail.detailUser!.data.avatar),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            height: 130,
                            width: 300,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        valueDetail.detailUser!.data.firstName,
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        valueDetail.detailUser!.data.lastName,
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(valueDetail.detailUser!.data.email)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        /*First Name */
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("First Name"),
                                  Text(
                                    valueDetail.detailUser!.data.firstName,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        /*Last Name */
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Last Name"),
                                  Text(
                                    valueDetail.detailUser!.data.lastName,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        /*Email*/
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Your Email"),
                                  Text(
                                    valueDetail.detailUser!.data.email,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        /*ID */
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Your ID's"),
                                  Text(
                                    valueDetail.detailUser!.data.id.toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        /*Detail Account */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Detail Page"),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DetailScreen(
                                          idUser:
                                              valueDetail.detailUser!.data.id);
                                    },
                                  ));
                                },
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            return const Text("Empty Data");
          },
        ),
      ),
    );
  }
}
