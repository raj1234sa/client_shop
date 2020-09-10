const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendNotificationOnFcmToken = functions.firestore.document('views/{viewId}').onWrite(async (event) => {
    let title = 'View Added.';
    let content = 'View is added by 1.';
    let doc = await admin.firestore().doc('users/CNxRAuPnih6Q1wjFCiz3').get();
    let fcmTOken = doc.get('fcm');

    var message = {
        notification: {
            title: title,
            body: content,
        },
        token: fcmTOken,
    };
    let response = await admin.messaging().send(message);
    console.log(response);
});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
