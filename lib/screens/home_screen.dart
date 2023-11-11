import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_pet_app/models/doctor_model.dart';
import 'package:healthy_pet_app/models/service_model.dart';

final List<String> services = ServiceModel.all();

final List<DoctorModel> doctors = [
  DoctorModel(
    photo: 'assets/images/doctor1.png',
    name: 'Dr. Stone',
    services: [ServiceModel.vaccine, ServiceModel.surgery],
    area: 10,
  ),
  DoctorModel(
    photo: 'assets/images/doctor2.png',
    name: 'Dr. Vanessa',
    services: [ServiceModel.vaccine, ServiceModel.surgery],
    area: 10,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedService = 0;
  int selectedMenu = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      bottomNavigationBar: _navBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
            child: Column(
              children: [
                _greetings(),
                const SizedBox(
                  height: 20,
                ),
                _hero(),
                const SizedBox(
                  height: 20,
                ),
                _searchBar(),
                const SizedBox(
                  height: 20,
                ),
                _services(),
                const SizedBox(
                  height: 20,
                ),
                _doctors(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final menus = [
    FeatherIcons.home,
    FeatherIcons.heart,
    FeatherIcons.messageCircle,
    FeatherIcons.user,
  ];

  Container _navBar() => Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 10,
          selectedItemColor: const Color(0xFF818AF9),
          unselectedItemColor: const Color(0xFFBFBFBF),
          showSelectedLabels: false,
          items: menus
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(e),
                  label: "",
                ),
              )
              .toList(),
        ),
      );

  ListView _doctors() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _doctor(index),
      separatorBuilder: (context, index) => const SizedBox(height: 11),
      itemCount: doctors.length,
    );
  }

  Container _doctor(int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF35385A).withOpacity(.12),
              blurRadius: 30,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                doctors[index].photo,
                width: 103,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctors[index].name,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Service: ${doctors[index].services.join(", ")}',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        FeatherIcons.mapPin,
                        color: Color(0xFFACA3A3),
                        size: 14,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        '${doctors[index].area.toString()}km',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: const Color(0xFFACA3A3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available for',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF50CC98),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/whh_cat.png',
                            width: 10,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/images/whh_dog.png',
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _services() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              selectedService = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: index == selectedService
                  ? const Color(0xFF818AF9)
                  : const Color(0xFFF6F6F6),
              border: index == selectedService
                  ? Border.all(
                      color: index == selectedService
                          ? const Color(0x38F1E5E5)
                          : const Color(0xFFF6F6F6),
                      width: 2,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                services[index],
                style: GoogleFonts.manrope(
                  color: index == selectedService
                      ? Colors.white
                      : const Color(0x4D3F3E3F),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: services.length,
      ),
    );
  }

  TextFormField _searchBar() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintText: 'Find best vaccinate, treatment...',
        hintStyle: GoogleFonts.manrope(
          color: const Color(0xFFCACACA),
          fontWeight: FontWeight.bold,
          height: 1.5,
        ),
        prefixIcon: const Icon(
          FeatherIcons.search,
          size: 20,
          color: Color(0xFFADACAD),
        ),
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  AspectRatio _hero() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xFF818AF9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Image.asset('assets/images/bengal.png'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Your ",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.white,
                      ),
                      children: const [
                        TextSpan(
                          text: " Catrine ",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(text: "will get\nvaccination "),
                        TextSpan(
                          text: " tomorrow\nat 07.00 am! ",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      border: Border.all(
                        color: Colors.white.withOpacity(.12),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        print('click');
                      },
                      child: Text(
                        "See details",
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _greetings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hello, Hooman!",
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF3F3E3F),
            height: 1.5,
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                FeatherIcons.shoppingBag,
                size: 24,
                color: Color(0xFF818AF9),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF6497),
                  borderRadius: BorderRadius.circular(15 / 2),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: GoogleFonts.mPlus1p(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
