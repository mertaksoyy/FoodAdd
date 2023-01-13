import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final String name;
  final String email;

  const AccountPage({
    super.key, 
    this.name = "",
    this.email = "",
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              forceElevated: true,
              shadowColor: Colors.black,
              elevation: 2,

              expandedHeight: 100,

              pinned: true,
              snap: true,
              floating: true,
              backgroundColor: Colors.white,

              leading: IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.arrow_back_ios_new, 
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ), 

              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Account", 
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
          ),

          SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60,),

                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 30, 
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 30,),

                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 30, 
                      color: Colors.black,
                    ),
                  ),

                ],
              )
            )
          ),
        ]
      )
    );
  }
}