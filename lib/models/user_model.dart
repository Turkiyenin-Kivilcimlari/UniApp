class User {
  final String name;
  final String desc;
  final String profileurl;
  final int followers;
  final int following;
  final int posts;

  User({
    required this.desc,
    required this.profileurl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.name,
  });
}
