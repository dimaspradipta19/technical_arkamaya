import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/view/about_screen.dart';
import 'package:technical_arkamaya/view/add_user_screen.dart';
import 'package:technical_arkamaya/view/home_screen.dart';
import 'package:technical_arkamaya/viewmodel/providers/detail_user_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.idUser});

  final int idUser;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ), (route) => false);
        break;
      case 1:
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const AddUserScreen();
          },
        ), (route) => false);
        break;
      case 2:
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const AboutScreen();
          },
        ), (route) => false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single User"),
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
      body: Consumer<DetailUserProvider>(
        builder: (context, valueDetailUser, child) {
          if (valueDetailUser.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (valueDetailUser.state == ResultState.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: CachedNetworkImage(
                          imageUrl: valueDetailUser.detailUser!.data.avatar,
                          errorWidget: (context, url, error) =>
                              const CircularProgressIndicator.adaptive(),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                valueDetailUser.detailUser!.data.firstName,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                              const SizedBox(width: 5),
                              Text(valueDetailUser.detailUser!.data.lastName,
                                  style: const TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          Text(valueDetailUser.detailUser!.data.email)
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Support",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Text(valueDetailUser.detailUser!.support.text)
                ],
              ),
            );
          }
          return const Text("No Data");
        },
      ),
    );
  }
}
