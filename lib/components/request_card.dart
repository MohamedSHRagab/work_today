import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_today/model/request.dart';
import 'package:work_today/screens/userprofile.dart';
import 'package:work_today/services/firebase_user.dart';

final _firestore = FirebaseFirestore.instance;

class HirerRequestCard extends StatelessWidget {
  final RequestWorker requestWorker;
  final bool isdark;

  const HirerRequestCard({Key key, this.requestWorker, this.isdark})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.only(right: 18.0, top: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: this.isdark ? Colors.grey : Colors.white,
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            title: Text(
              "${requestWorker.workerName}",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Job: ${requestWorker.job}"),
                Text("Location: ${requestWorker.location}"),
                Text("Offered Amount: ${requestWorker.amount}"),
              ],
            ),
            trailing: GestureDetector(
              onTap: requestWorker.isAccepted
                  ? () {}
                  : () async {
                      await _firestore
                          .collection('users')
                          .doc(FirebaseCurrentUser.user.uid)
                          .collection("request")
                          .doc(requestWorker.requestID)
                          .delete();

                      print(
                          "Delete called on ${FirebaseCurrentUser.user.uid} and ${requestWorker.workerID} for ${requestWorker.requestID}");
                      await _firestore
                          .collection('users')
                          .doc(requestWorker.workerID)
                          .collection("request")
                          .doc(requestWorker.requestID)
                          .delete();
                    },
              child: Container(
                child: Center(
                  child: Text(
                    requestWorker.isAccepted ? "Accepted" : "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                height: 37,
                width: 100,
                decoration: BoxDecoration(
                    color: requestWorker.isAccepted
                        ? Colors.lightBlueAccent
                        : Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
              ),
            )),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(
                      isdark: this.isdark,
                      Name: requestWorker.workerName,
                      location: requestWorker.location,
                      amount: requestWorker.amount,
                      job: requestWorker.job,
                      category: false,
                      email: requestWorker.email,
                      phoneNo: requestWorker.phoneNo,
                    )));
      },
    );
  }
}

class WorkerRequestCard extends StatelessWidget {
  final RequestHirer hirerRequest;
  final bool isdark;

  const WorkerRequestCard({Key key, this.hirerRequest, this.isdark})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: this.isdark ? Colors.grey : Colors.white,
        elevation: 2.0,
        margin: EdgeInsets.only(right: 18.0, top: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          title: Text(
            "${hirerRequest.hirerName}",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Job : ${hirerRequest.job}"),
              Text("Location : ${hirerRequest.location}"),
              Text("Offered Amount : ${hirerRequest.amount}"),
            ],
          ),
          trailing: hirerRequest.isAccepted
              ? GestureDetector(
                  onTap: () async {
                    await _firestore
                        .collection('users')
                        .doc(FirebaseCurrentUser.user.uid)
                        .collection("request")
                        .doc(hirerRequest.requestID)
                        .delete();

                    print(
                        "Delete called on ${FirebaseCurrentUser.user.uid} and ${hirerRequest.requestID} for ${hirerRequest.requestID}");
                    await _firestore
                        .collection('users')
                        .doc(hirerRequest.hirerID)
                        .collection("request")
                        .doc(hirerRequest.requestID)
                        .delete();
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Accepted",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 37,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              : Container(
                  width: 210.0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _firestore
                              .collection('users')
                              .doc(FirebaseCurrentUser.user.uid)
                              .collection("request")
                              .doc(hirerRequest.requestID)
                              .update({
                            "isAccepted": true,
                          });

                          print(
                              "Delete called on ${FirebaseCurrentUser.user.uid} and ${hirerRequest.requestID} for ${hirerRequest.requestID}");
                          await _firestore
                              .collection('users')
                              .doc(hirerRequest.hirerID)
                              .collection("request")
                              .doc(hirerRequest.requestID)
                              .update({
                            "isAccepted": true,
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Accept",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          height: 37,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _firestore
                              .collection('users')
                              .doc(FirebaseCurrentUser.user.uid)
                              .collection("request")
                              .doc(hirerRequest.requestID)
                              .delete();

                          print(
                              "Delete called on ${FirebaseCurrentUser.user.uid} and ${hirerRequest.requestID} for ${hirerRequest.requestID}");
                          await _firestore
                              .collection('users')
                              .doc(hirerRequest.hirerID)
                              .collection("request")
                              .doc(hirerRequest.requestID)
                              .delete();
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Decline",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          height: 37,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(
                      isdark: this.isdark,
                      Name: hirerRequest.hirerName,
                      location: hirerRequest.location,
                      amount: hirerRequest.amount,
                      job: hirerRequest.job,
                      category: true,
                      email: hirerRequest.email,
                      phoneNo: hirerRequest.phoneNo,
                    )));
      },
    );
  }
}
