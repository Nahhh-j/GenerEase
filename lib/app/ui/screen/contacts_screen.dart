import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:generease/app/ui/widget/button.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contactsList = [];

  Future<void> requestContactsPermission() async {
    print('in requestContactsPermission()');
    print(await Permission.contacts.status);
    if (await Permission.contacts.isDenied &&
        !await Permission.contacts.isPermanentlyDenied) {
      await Permission.contacts.request();
    }
  }

  Future<void> getContacts() async {
    if (await Permission.contacts.isGranted) {
      var contacts = await ContactsService.getContacts();
      setState(() {
        contactsList = contacts;
      });
    } else {
      requestContactsPermission();
    }
  }

  @override
  void initState() {
    super.initState();

    requestContactsPermission();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '비상 연락망',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              contactsList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: contactsList.length,
                        itemBuilder: (context, index) {
                          String name =
                              contactsList[index].displayName.toString();
                          String phoneNumber = "";

                          if (contactsList[index].phones!.isNotEmpty) {
                            phoneNumber =
                                contactsList[index].phones![0].value.toString();
                          }
                          return name != "null" && phoneNumber != ""
                              ? Container(
                                  height: 110,
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 0,
                                        spreadRadius: 0.1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      contactsList[index].avatar != null
                                          ? Container(
                                              width: 55,
                                              height: 55,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.memory(
                                                  contactsList[index].avatar!,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 55,
                                              height: 55,
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff2F4EFF),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Image.asset(
                                                'assets/icons/person_white.png',
                                                width: 20,
                                              ),
                                            ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            phoneNumber,
                                            style: const TextStyle(
                                              color: Color(0xff727272),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              blurRadius: 10,
                                              spreadRadius: 0,
                                              offset: const Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: const Color(0xff34BC42),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: InkWell(
                                            onTap: () {
                                              print('전화걸기');
                                              launchUrl(Uri.parse(
                                                  'tel:$phoneNumber'));
                                            },
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Container(
                                              width: 58,
                                              height: 58,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Image.asset(
                                                  'assets/icons/call_end.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    )
                  : Text('연락처 정보 없음'),
            ],
          ),
        ),
      ),
    );
  }
}
