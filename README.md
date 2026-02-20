# Krishna Pharmacy - Flutter + MongoDB Starter

This repository now includes a production-ready starter structure for a medicine ordering and delivery app:

- `flutter_app/` - Flutter mobile client (Android + iOS)
- `backend/` - Node.js + Express + MongoDB API

## Implemented user features

- Authentication UX for **mobile OTP** and **Gmail login**.
- Category-wise medicine listing from `GET https://krishnapharmacy.onrender.com/medicines` with image support.
- GPS-based location detection and nearest shop auto-selection from `/contact`.
- Checkout flow with:
  - Cart
  - Prescription upload
  - Payment options: COD, QR, Google Pay
- Delivery ETA logic = `30 minutes + least traffic time` to nearest shop.
- Order tracking screen for placed orders.

## Implemented admin features

- Admin console placeholders for medicine management, prescription review, and order decisions.
- Backend endpoints for:
  - `GET /medicines`
  - `PUT /medicines/:id`
  - `POST /orders`
  - `PATCH /orders/:id/status`

## MongoDB

The backend uses Mongoose models for medicines and orders. Configure:

```bash
MONGODB_URI=mongodb+srv://<user>:<pass>@cluster.mongodb.net/krishna-pharmacy
```

## Run backend

```bash
cd backend
npm install
npm run dev
```

## Run Flutter app

```bash
cd flutter_app
flutter pub get
flutter run
```

## Play Store & App Store deployment checklist

Detailed release, metadata, and privacy policy checklist is in `docs/release_and_privacy.md`.
