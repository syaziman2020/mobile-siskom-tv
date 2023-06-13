import 'package:flutter/material.dart';
import 'package:siskom_tv_dosen/cubit/manage_cubit.dart';
import 'package:siskom_tv_dosen/pages/login_page.dart';
import 'package:siskom_tv_dosen/theme.dart';
import 'package:siskom_tv_dosen/widgets/custom_form.dart';
import 'package:siskom_tv_dosen/widgets/identity_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> list = <String>['ADA', 'TIDAK ADA', 'LIBUR', 'TUGAS BELAJAR'];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ManageCubit>().getProfile();

    super.initState();
  }

  TextEditingController nameC = TextEditingController();

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ManageCubit>().getProfile();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 67,
                            height: 67,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xffEAEAF0)),
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: BlocBuilder<ManageCubit, ManageState>(
                                  builder: (context, state) {
                                    if (state is ProfileSucccess) {
                                      return FadeInImage(
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: const AssetImage(
                                          'assets/logo-untan.png',
                                        ),
                                        image: NetworkImage(
                                          '${state.profileModel?.data?.image}',
                                        ),
                                      );
                                    }
                                    return Image.asset('assets/logo-untan.png');
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlocBuilder<ManageCubit, ManageState>(
                                builder: (context, state) {
                                  if (state is ProfileSucccess) {
                                    return Flexible(
                                      child: Container(
                                        width: size.width * 0.52,
                                        child: Text(
                                          '${state.profileModel?.data?.name ?? 'loading...'}',
                                          overflow: TextOverflow.ellipsis,
                                          style: blackTextStyle.copyWith(
                                              fontWeight: semiBold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    );
                                  }
                                  return Text(
                                    'loading...',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: semiBold, fontSize: 16),
                                  );
                                },
                              ),
                              BlocBuilder<ManageCubit, ManageState>(
                                builder: (context, state) {
                                  if (state is ProfileSucccess) {
                                    return Text(
                                      '${state.profileModel?.data?.user?.email ?? 'loading...'}',
                                      style:
                                          greyTextStyleB.copyWith(fontSize: 14),
                                    );
                                  }
                                  return Text(
                                    'loading...',
                                    style:
                                        greyTextStyleB.copyWith(fontSize: 14),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  'Edit Nama',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: semiBold, fontSize: 15),
                                ),
                              ),
                              content: CustomTextFormField(
                                labelText: 'Nama',
                                hintText: 'Masukkan nama kamu',
                                keyboardType: TextInputType.emailAddress,
                                controller: nameC,
                                action: TextInputAction.done,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              actionsPadding:
                                  EdgeInsets.fromLTRB(20, 0, 20, 10),
                              actions: [
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Batal',
                                            style: whiteTextStyle.copyWith(
                                                fontWeight: semiBold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7))),
                                          onPressed: () {
                                            context
                                                .read<ManageCubit>()
                                                .changeName(nameC.text);
                                          },
                                          child: BlocBuilder<ManageCubit,
                                              ManageState>(
                                            builder: (context, state) {
                                              if (state is UpdateLoading) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 14,
                                                    height: 14,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: whiteC,
                                                    ),
                                                  ),
                                                );
                                              } else if (state
                                                  is UpdateSuccess) {
                                                Navigator.pop(context);
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  nameC.clear();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text(
                                                          'Nama berhasil diperbarui'),
                                                    ),
                                                  );
                                                });
                                                context
                                                    .read<ManageCubit>()
                                                    .getProfile();
                                              }
                                              return Text(
                                                'Submit',
                                                style: whiteTextStyle.copyWith(
                                                    fontWeight: semiBold,
                                                    fontSize: 13),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: greyTextC,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Identitas',
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
                  ),
                  BlocBuilder<ManageCubit, ManageState>(
                    builder: (context, state) {
                      if (state is ProfileSucccess) {
                        return IdentityTile(
                          name:
                              '${state.profileModel?.data?.position ?? 'loading...'}',
                          title: 'Jabatan',
                          icon: Icons.account_circle_outlined,
                        );
                      }
                      return IdentityTile(
                        name: 'loading...',
                        title: 'Jabatan',
                        icon: Icons.account_circle_outlined,
                      );
                    },
                  ),
                  BlocBuilder<ManageCubit, ManageState>(
                    builder: (context, state) {
                      if (state is ProfileSucccess) {
                        return IdentityTile(
                          name:
                              '${state.profileModel?.data?.nip ?? 'loading...'}',
                          title: 'NIP',
                          icon: Icons.account_circle_outlined,
                        );
                      }
                      return IdentityTile(
                        name: 'loading...',
                        title: 'NIP',
                        icon: Icons.account_circle_outlined,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_box_outlined,
                            size: 32,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
                                style: blackTextStyle.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              BlocBuilder<ManageCubit, ManageState>(
                                builder: (context, state) {
                                  if (state is ProfileSucccess) {
                                    return Text(
                                      '${state.profileModel?.data?.status ?? 'loading...'}',
                                      style: greyTextStyleB,
                                    );
                                  }
                                  return Text(
                                    'loading...',
                                    style: greyTextStyleB,
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            'Edit Status',
                                            style: blackTextStyle.copyWith(
                                                fontWeight: semiBold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        content: DropdownButton<String>(
                                          value: dropdownValue,
                                          hint: BlocBuilder<ManageCubit,
                                              ManageState>(
                                            builder: (context, state) {
                                              if (state is ProfileSucccess) {
                                                return Text(
                                                  '${state.profileModel?.data?.status ?? 'loading...'}',
                                                  style: greyTextStyleB,
                                                );
                                              }
                                              return Text(
                                                'loading...',
                                                style: greyTextStyleB,
                                              );
                                            },
                                          ),
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                          },
                                          items: list
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: blackTextStyle,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                        actionsPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 0, 20, 10),
                                        actions: [
                                          Row(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Batal',
                                                      style: whiteTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<ManageCubit>()
                                                          .changeStatus(
                                                              dropdownValue);
                                                      print(dropdownValue);
                                                    },
                                                    child: BlocBuilder<
                                                        ManageCubit,
                                                        ManageState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is ChangeLoading) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 14,
                                                              height: 14,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: whiteC,
                                                              ),
                                                            ),
                                                          );
                                                        } else if (state
                                                            is ChangeSuccess) {
                                                          Navigator.pop(
                                                              context);
                                                          WidgetsBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                content: Text(
                                                                    'Status berhasil diperbarui'),
                                                              ),
                                                            );
                                                          });
                                                          context
                                                              .read<
                                                                  ManageCubit>()
                                                              .getProfile();
                                                        }
                                                        return Text(
                                                          'Submit',
                                                          style: whiteTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 13),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }));
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: greyTextC,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<ManageCubit, ManageState>(
                    listener: (context, state) {
                      if (state is LogoutFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.message),
                          ),
                        );
                      } else if (state is LogoutSuccess) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      }
                    },
                    builder: (context, state) {
                      if (state is LogoutLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          context.read<ManageCubit>().logout();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.logout,
                                  size: 32,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Logout',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Version 1.0.0',
                              style: greyTextStyleB.copyWith(fontSize: 10),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
