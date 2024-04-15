import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;class ChildInfoPage extends StatefulWidget {
  const ChildInfoPage({Key? key}) : super(key: key);
  @override
  _ChildInfoPageState createState() => _ChildInfoPageState();
}
class _ChildInfoPageState extends State<ChildInfoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _avatarSizeAnimation;
  bool _isExpanded = false;
  bool _isLoading = false;
  List<UserInfo> userInfoList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _avatarSizeAnimation = Tween<double>(begin: 50, end: 150).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    fetchData();
  }
  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Set _isLoading to true when data fetching starts
    });
    final url = Uri.parse(
        'https://staging.smartschoolplus.co.in/webservice/sspmobileservice.asmx/UserRegister?SchoolCode=TESTLAKE&sUsername=PAY2&sPassword=PAY2');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['UserInfo'] != null) {
        List<dynamic> userInfo = jsonData['UserInfo'];
        setState(() {
          userInfoList = userInfo.map((item) {
            return UserInfo(
              admissionNo: item['AdmissionNo'] ?? '',
              className: item['Class'] ?? '',
              rollNo: item['RollNo'] ?? '',
              fatherName: item['FatherName'] ?? '',
              motherName: item['MotherName'] ?? '',
              dateOfBirth: item['DOB'] ?? '',
              gender: item['Gender'] ?? '',
              bloodGroup: item['BLOODGROUP'] ?? '',
              address: item['Address'] ?? '',
              userImage: item['UserImage'] ?? '',
            );
          }).toList();
          _isLoading = false; // Set _isLoading to false after data fetching completes
        });
      } else {
        setState(() {
          userInfoList = []; // Empty the list
          _isLoading = false; // Set _isLoading to false
        });
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onRefreshPressed: fetchData, // Refresh functionality
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWebContent();
          } else {
            return _buildMobileContent();
          }
        },
      ),
    );
  }
  Widget _buildMobileContent() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00008B),
                Color.fromRGBO(255, 45, 85, 1),
                Color.fromRGBO(175, 82, 222, 1),
                Color.fromRGBO(88, 86, 214, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: _isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userInfoList
                  .map((userInfo) => UserInfoWidget(
                userInfo: userInfo,
                isExpanded: _isExpanded,
                avatarSizeAnimation: _avatarSizeAnimation,
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
  Widget _buildWebContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00008B),
                  Color.fromRGBO(255, 45, 85, 1),
                  Color.fromRGBO(175, 82, 222, 1),
                  Color.fromRGBO(88, 86, 214, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userInfoList
                    .map((userInfo) => UserInfoWidget(
                  userInfo: userInfo,
                  isExpanded: _isExpanded,
                  avatarSizeAnimation: _avatarSizeAnimation,
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ))
                    .toList(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey[200],
            child: const Center(child: Text('Additional content goes here')),
          ),
        ),
      ],
    );
  }
}
class UserInfoWidget extends StatelessWidget {
  final UserInfo userInfo;
  final bool isExpanded;
  final Animation<double> avatarSizeAnimation;
  final VoidCallback onTap;

  const UserInfoWidget({
    Key? key,
    required this.userInfo,
    required this.isExpanded,
    required this.avatarSizeAnimation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'avatar_image_${userInfo.admissionNo}',
          child: CircleAvatar(
            radius: avatarSizeAnimation.value,
            backgroundImage: NetworkImage(userInfo.userImage),
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoField('Admission No:', userInfo.admissionNo, Icons.info),
        _buildInfoField('Class:               ', userInfo.className, Icons.class_),
        _buildInfoField('Roll No:           ', userInfo.rollNo, Icons.format_list_numbered),
        _buildInfoField('Father Name: ', userInfo.fatherName, Icons.person),
        _buildInfoField('Mother Name:', userInfo.motherName, Icons.person_outline),
        _buildInfoField('Date of Birth: ', userInfo.dateOfBirth, Icons.calendar_today),
        _buildInfoField('Gender:          ', userInfo.gender, Icons.wc),
        _buildInfoField('Blood Group: ', userInfo.bloodGroup, Icons.bloodtype),
        _buildInfoField('Address:        ', userInfo.address, Icons.location_on),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16),
              height: isExpanded ? 200 : 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'More Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isExpanded)
                    Text(
                      '#228 \n, RADIENT LAKEVIEW 3, BLOCK-4,\n,'
                          'KARNASHREE LAYOUT, VIRGO NAGAR POST,  \n',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildInfoField(String label, String value, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: avatarSizeAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: avatarSizeAnimation.value * 2 * 3.14,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00008B),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 145, // Adjust width as needed
            height: 40, // Adjust height as needed
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00008B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefreshPressed;

  const CustomAppBar({Key? key, required this.onRefreshPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'CHILD INFO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor:const Color(0xFF00008B),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.yellowAccent,
          size: 24,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.yellowAccent,
            size: 24,
          ),
          onPressed: onRefreshPressed, // Use the provided onPressed callback
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class UserInfo {
  final String admissionNo;
  final String className;
  final String rollNo;
  final String fatherName;
  final String motherName;
  final String dateOfBirth;
  final String gender;
  final String bloodGroup;
  final String address;
  final String userImage;

  UserInfo({
    required this.admissionNo,
    required this.className,
    required this.rollNo,
    required this.fatherName,
    required this.motherName,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.address,
    required this.userImage,
  });
}

void main() {
  runApp(const MaterialApp(
    home: ChildInfoPage(),
  ));
}
