# Release Metadata and Privacy Policy Checklist

## Brand and UI palette

- Green `#2E7D32`
- White `#FFFFFF`
- Orange `#F57C00`
- Dark Gray `#333333`

## Store metadata

### Google Play
- App name: Krishna Pharmacy
- Short description: "Order medicines with fast delivery and prescription support."
- Full description with OTP/Gmail auth, live order tracking, and payment options.
- Feature graphic, icon, phone screenshots, privacy policy URL.
- Data safety form covering location, contact info, and payment intent metadata.

### Apple App Store
- App name: Krishna Pharmacy
- Subtitle: "Medicine delivery in minutes"
- Keywords: pharmacy, medicine, delivery, prescription
- Screenshots for iPhone sizes and optional iPad.
- App Privacy labels matching collected data usage.

## Privacy policy must disclose

- Authentication data handling (OTP phone and Gmail identity)
- GPS location use to assign nearest pharmacy
- Prescription image processing and retention policy
- Payment option routing (COD / QR / GPay handoff)
- Support contact and deletion request method

## Suggested production improvements before submission

- Replace mocked OTP check with Firebase Auth verification.
- Add role-based access tokens for admin APIs.
- Add upload storage (S3/GCS) for prescription files.
- Add audit trail for admin approvals/rejections and call outcomes.
- Configure Crashlytics / Sentry and legal Terms of Service.
