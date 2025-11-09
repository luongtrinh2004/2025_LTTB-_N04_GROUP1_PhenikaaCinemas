# 🎬 PhenikaaCinemas – Ứng dụng đặt vé xem phim

> Prototype ứng dụng di động mô phỏng quy trình **đặt vé xem phim trực tuyến** được phát triển bằng **Flutter** – phục vụ đồ án môn _Lập trình cho thiết bị di động (N04)_, Trường Đại học Phenikaa.

---

## 🧩 Giới thiệu

Trong thời đại số, việc đặt vé xem phim trực tuyến trở thành nhu cầu phổ biến, giúp người xem **tiết kiệm thời gian** và **chủ động chọn chỗ ngồi**.  
Nhóm sinh viên Phenikaa đã phát triển **PhenikaaCinemas** – một ứng dụng Flutter mô phỏng quy trình đặt vé xem phim, tập trung vào **giao diện người dùng (UI)** và **trải nghiệm (UX)**.

Dự án hướng đến **thiết kế nguyên mẫu (prototype)**, chưa kết nối cơ sở dữ liệu hoặc API thật, nhưng có cấu trúc rõ ràng để mở rộng thành sản phẩm hoàn chỉnh trong tương lai.

---

## 🧠 Mục tiêu

- Xây dựng ứng dụng Flutter mô phỏng **toàn bộ quy trình đặt vé xem phim**.
- Thiết kế UI trực quan, hiện đại, hỗ trợ **song ngữ Việt – Anh**.
- Tổ chức mã nguồn khoa học theo mô hình module, dễ bảo trì và mở rộng.
- Rèn luyện kỹ năng làm việc nhóm, quản lý dự án và tư duy thiết kế phần mềm.

---

## ⚙️ Công nghệ sử dụng

| Thành phần        | Công nghệ                 |
| ----------------- | ------------------------- |
| Framework         | Flutter (Material Design) |
| Ngôn ngữ          | Dart                      |
| IDE khuyến nghị   | VS Code / Android Studio  |
| Thư viện phụ trợ  | `cupertino_icons`, `intl` |
| Ảnh và tài nguyên | Thư mục `assets/img/`     |

---

## 🧭 Cấu trúc thư mục

```bash
lib/
├── core/
│   └── colors.dart           # Màu sắc thương hiệu, theme
│
├── widgets/
│   ├── app_shell.dart        # Khung điều hướng chính (VN)
│   ├── app_header.dart       # Thanh tiêu đề chung
│
├── pages/
│   ├── home_page.dart
│   ├── hot_movies_page.dart
│   ├── all_movies_page.dart
│   ├── booking_page.dart
│   ├── tickets_page.dart
│   ├── profile_page.dart
│   ├── login_page.dart
│   │
│   ├── english/              # Phiên bản giao diện tiếng Anh
│   │   └── app_shell_en.dart
│   │
│   └── movies_detail_page/   # Trang chi tiết phim riêng lẻ
│       ├── avatar3_detail_page.dart
│       ├── shin_detail_page.dart
│       ├── roboco_detail_page.dart
│       ├── van_may_detail_page.dart
│       └── ...
│
└── utils/
    └── utils.dart            # Hàm tiện ích định dạng, xử lý chuỗi
```
