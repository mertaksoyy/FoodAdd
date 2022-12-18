import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodadd/main.dart';


class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {

  @override
  Widget build(BuildContext context) {
  
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: PostCard(
              title: posts[index]["title"],
              image: posts[index]["image"],
              author: posts[index]["author"],
              rating: posts[index]["rating"],
            )
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key, 
    required this.title, 
    required this.image,
    required this.author,
    required this.rating,
  });

  final String title;
  final String image;
  final String author;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),

      child: Card(
        /*decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Theme.of(context).primaryColor, 
        ),*/
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                ),

                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  
                  children: [
                    const Icon(Icons.person, size: 40),

                    const SizedBox(width: 10,),

                    Text(
                      author,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20,),
  
              Image.asset(
                  image,
                  width: 150,
                  height: 150,
                ),

              Divider(
                color: Theme.of(context).dividerColor,
                height: 40,
                thickness: 2,
                indent: 10,
                endIndent: 20,
              ),

              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium, 
              ),
              
              const SizedBox(height: 20,),

              RatingBarIndicator(
                rating: rating,
                itemCount: 5,

                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).indicatorColor,
                  size: 40,
                ),
              ),

              const SizedBox(height: 20,),
            
            ],
          ),
        ),
      )
    );
  }
}
