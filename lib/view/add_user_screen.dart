import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:technical_arkamaya/utils/result_state.dart';
import 'package:technical_arkamaya/view/about_screen.dart';
import 'package:technical_arkamaya/view/home_screen.dart';
import 'package:technical_arkamaya/viewmodel/providers/add_user_provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _jobController.dispose();
  }

  int _selectedIndex = 1;

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
        title: const Text("Create"),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Name",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      focusNode: FocusNode(),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                      validator: (valueName) {
                        if (valueName!.isEmpty) {
                          return "Empty Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Job",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    TextFormField(
                      controller: _jobController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Job"),
                      validator: (valueName) {
                        if (valueName!.isEmpty) {
                          return "Empty Job";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<AddUserProvider>(context, listen: false)
                          .postAddUser(
                              _nameController.text, _jobController.text);
                      _nameController.clear();
                      _jobController.clear();

                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(height: 20.0),
              Consumer<AddUserProvider>(
                builder: (context, valueAdd, child) {
                  if (valueAdd.state == ResultState.loading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[500]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.green[100]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Data not been created"),
                            Text("ID: - "),
                            Text("Created At - "),
                          ],
                        ),
                      ),
                    );
                  }

                  if (valueAdd.state == ResultState.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.green[100]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Data has been created"),
                          Text("ID: ${valueAdd.addUserModel!.id.toString()}"),
                          Text(
                              "Created At ${valueAdd.addUserModel!.createdAt}"),
                        ],
                      ),
                    );
                  }

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.green[100]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Data not been created"),
                        Text("ID: - "),
                        Text("Created At - "),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
