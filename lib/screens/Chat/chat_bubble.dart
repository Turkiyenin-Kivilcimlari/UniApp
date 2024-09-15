import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_model.dart';



Future<bool> validateImageUrl(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    return await canLaunchUrl(uri);
  } catch (e) {
    return false;
  }
}
class ChatBubble extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String time;
  final String message;
  final String selectedUser;
  final bool isMe;
  const ChatBubble(
      {Key? key, required this.profileUrl,
        required this.name,
        required this.message,
        required this.time,
        required this.isMe,
        required this.selectedUser}) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _isValidUrl = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkImageUrl();
  }

  void _checkImageUrl() async {
    bool isValid = await validateImageUrl(widget.profileUrl);
    setState(() {
      _isValidUrl = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isMe) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PmScreen(
                    profileUrl: widget.profileUrl,
                    name: widget.name,
                    selectedUser: widget.selectedUser,
                  ),
                ),
              );
            });
          },
          child: Container(
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 32,
                        backgroundImage:CachedNetworkImageProvider(widget.profileUrl),
                        // Yedek resim
                        child: _isValidUrl
                            ? null
                            : Icon(Icons.person,
                            size: 32, color: Colors.white), // Yedek ikon
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Metropolis'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                'Tap to start messaging..',
                                style: TextStyle(
                                    fontSize: 10, fontFamily: 'Metropolis'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.comment),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

