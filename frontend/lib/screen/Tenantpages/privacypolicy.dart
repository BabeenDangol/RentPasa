import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          shadowColor: Colors.purple.shade50,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                  "Welcome to RentPasa. This Privacy Policy outlines how we collect, use, disclose, and safeguard your personal information when you use our App. We are committed to protecting your privacy and ensuring that your personal data is handled securely and responsibly."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Information We Collect",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Personal Information",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "We may collect personal information when you register an account on the App, such as your name, email address, phone number, and profile picture. Additionally, during the use of the App, we may collect information related to your rental preferences, search queries, and interactions with the App's features."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Location Information",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                  "With your consent, we may collect and process location information to provide location-based services and enhance your experience on the App. You can manage location permissions through your device settings."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Usage Data",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                  "We may collect usage data, including IP addresses, device information, browser type, access times, and app usage statistics. This data is used to analyze trends, administer the App, and track user engagement to improve our services."),
              Text(
                "How We Use Your Information",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Providing Services",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "We use your personal information to operate, maintain, and enhance the App's functionality, including facilitating rental searches, managing user accounts, and responding to your inquiries and feedback."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Communication",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                  "We may use your contact information to send you important updates, announcements, marketing materials, and information related to your account and the App's services. You can opt-out of promotional communications at any time."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Personalization",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                  "We may use your information to customize your experience on the App, such as showing you relevant rental listings based on your preferences and behavior."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Analytics and Improvements",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                  "We analyze usage data to improve the App's performance, optimize user experience, and develop new features and services to better serve our users."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Data Security",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                  "We implement reasonable security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no method of data transmission over the internet or electronic storage is completely secure, and we cannot guarantee absolute security."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Children's Privacy",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                  "The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children. If you believe that a child has provided us with personal information, please contact us, and we will take appropriate steps to remove the information."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Changes to Privacy Policy",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                  "We may update this Privacy Policy from time to time. The updated version will be effective immediately upon posting. We encourage you to review this policy periodically."),
              SizedBox(
                height: 30,
              ),
              Text(
                "Contact Us",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6B4C85),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at rentpasa@gmail.com."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "By using the Rent Management Application, you agree to the terms of this Privacy Policy. Thank you for trusting us with your personal information."),
            ],
          ),
        ),
      ),
    );
  }
}
