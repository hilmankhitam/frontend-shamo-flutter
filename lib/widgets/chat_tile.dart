part of 'widgets.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  const ChatTile(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = message.createdAt!.millisecondsSinceEpoch;
    String readTimeStamp(int timeStamp) {
      var now = DateTime.now();
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      var diff = now.difference(date);
      var time = '';

      if (diff.inSeconds > 0 && diff.inSeconds < 60) {
        if (diff.inSeconds == 1) {
          time = diff.inSeconds.toString() + ' second ago';
        } else {
          time = diff.inSeconds.toString() + ' seconds ago';
        }
      } else if (diff.inMinutes > 0 && diff.inMinutes < 60) {
        if (diff.inSeconds == 1) {
          time = diff.inMinutes.toString() + ' minute ago';
        } else {
          time = diff.inMinutes.toString() + ' minutes ago';
        }
      } else if (diff.inHours > 0 && diff.inHours < 24) {
        if (diff.inHours == 1) {
          time = diff.inHours.toString() + ' hour ago';
        } else {
          time = diff.inHours.toString() + ' hours ago';
        }
      } else if (diff.inDays > 0 && diff.inDays < 7) {
        if (diff.inDays == 1) {
          time = diff.inDays.toString() + ' Day ago';
        } else {
          time = diff.inDays.toString() + ' Days ago';
        }
      } else {
        if (diff.inDays == 7) {
          time = (diff.inDays / 7).floor().toString() + ' Week ago';
        } else {
          time = (diff.inDays / 7).floor().toString() + ' Weeks ago';
        }
      }
      return time;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailChatPage(UninitializedProductModel())));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 33),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image_shop_logo.png',
                  width: 54,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoe Store',
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        message.message!,
                        style: secondaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  readTimeStamp(time),
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xFF2B2939),
            ),
          ],
        ),
      ),
    );
  }
}
