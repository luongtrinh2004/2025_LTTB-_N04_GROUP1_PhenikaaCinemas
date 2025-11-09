# PhenikaaCinemas – Ứng dụng đặt vé xem phim

> Ứng dụng di động đặt vé xem phim được phát triển bằng **Flutter**, mô phỏng quy trình đặt vé trực tuyến với giao diện hiện đại, thân thiện và hỗ trợ **song ngữ Việt – Anh**.  
> Đồ án môn học **Lập trình cho thiết bị di động (N04)** – **Trường Đại học Phenikaa**.

## Thành viên nhóm

| MSSV     | Họ tên           | Vai trò                          | Tỉ lệ |
| -------- | ---------------- | -------------------------------- | ----- |
| 22010064 | Trịnh Phúc Lương | Trưởng nhóm, lập trình chính     | 60%   |
| 22010033 | Đặng Thanh Huyền | Thiết kế giao diện, viết báo cáo | 40%   |

## Thông tin lớp học

Môn học: Lập trình cho thiết bị di động (N04)

Giảng viên hướng dẫn: ThS. Nguyễn Xuân Quế

Trường: Đại học Phenikaa

Tên đề tài: Thiết kế ứng dụng đặt vé xem phim – PhenikaaCinemas

## Giới thiệu

**PhenikaaCinemas** là ứng dụng giúp người dùng:

- Xem danh sách phim đang chiếu và sắp chiếu
- Xem chi tiết từng phim: thể loại, thời lượng, điểm đánh giá, nội dung mô tả
- Chọn ngày – giờ chiếu
- Chọn ghế ngồi trực quan trên sơ đồ rạp
- Xem tổng tiền, xác nhận đặt vé
- Quản lý vé và thông tin cá nhân

Ứng dụng được phát triển trên nền tảng **Flutter**, theo triết lý **UI-first**, đảm bảo trải nghiệm người dùng nhất quán và hiện đại theo **Material Design**.  
Màu chủ đạo: **Cam – Trắng – Đen** giúp nhận diện thương hiệu mạnh mẽ, hiện đại và đồng nhất giữa các màn hình.

## Công nghệ sử dụng

| Thành phần             | Công nghệ                            |
| ---------------------- | ------------------------------------ |
| **Framework**          | Flutter                              |
| **Ngôn ngữ**           | Dart                                 |
| **IDE khuyến nghị**    | Visual Studio Code / Android Studio  |
| **Thiết kế giao diện** | Material Design                      |
| **Thư viện chính**     | `flutter`, `cupertino_icons`, `intl` |
| **Tài nguyên**         | `assets/img/` chứa ảnh, poster, logo |

---

## Cấu trúc thư mục

Dự án được tổ chức rõ ràng, phân tách theo chức năng để dễ mở rộng và bảo trì:

```
lib/
├── core/
│   └── colors.dart                  # Định nghĩa màu thương hiệu & theme toàn app
│
├── pages/
│   ├── english/                     # Toàn bộ giao diện tiếng Anh
│   │   ├── all_movies_page_en.dart
│   │   ├── app_shell_en.dart
│   │   ├── booking_page_en.dart
│   │   ├── home_page_en.dart
│   │   ├── hot_movies_page_en.dart
│   │   ├── tickets_page_en.dart
│   │   ├── profile_page_en.dart
│   │   ├── ...
│   │   └── (các trang chi tiết phim *_detail_page_en.dart)
│   │
│   ├── movies_detail_page/          # Chi tiết phim tiếng Việt
│   │   ├── avatar3_detail_page.dart
│   │   ├── shin_detail_page.dart
│   │   ├── roboco_detail_page.dart
│   │   ├── van_may_detail_page.dart
│   │   ├── cuc_vang_cua_ngoai_detail_page.dart
│   │   ├── tay_anh_giu_mot_vi_sao_detail_page.dart
│   │   ├── tee_yod_detail_page.dart
│   │   └── ...
│   │
│   ├── all_movies_page.dart
│   ├── booking_page.dart
│   ├── home_page.dart
│   ├── hot_movies_page.dart
│   ├── login_page.dart
│   ├── profile_page.dart
│   └── tickets_page.dart
│
├── utils/
│   └── utils.dart                   # Hàm tiện ích, format tiền tệ, xử lý chuỗi, v.v.
│
├── widgets/
│   ├── app_header.dart              # Thanh tiêu đề dùng chung (AppBar)
│   ├── app_shell.dart               # NavigationBar chính của ứng dụng
│   └── ...
│
└── main.dart                        # Điểm khởi chạy ứng dụng
```

## Chức năng chính

| Mã       | Chức năng             | Mô tả                                                                                                  |
| -------- | --------------------- | ------------------------------------------------------------------------------------------------------ |
| **UC01** | **Đăng nhập**         | Cho phép người dùng nhập thông tin và truy cập AppShell chính                                          |
| **UC02** | **Tìm kiếm phim**     | Xem danh sách phim đang/sắp chiếu, có thể tìm kiếm hoặc lọc theo thể loại                              |
| **UC03** | **Xem chi tiết phim** | Hiển thị thông tin chi tiết phim: poster, thể loại, thời lượng, đánh giá, mô tả, chọn ngày – giờ chiếu |
| **UC04** | **Đặt vé xem phim**   | Chọn ghế ngồi theo sơ đồ rạp (A–H, hàng H là ghế đôi), tính tổng tiền và xác nhận đặt vé               |
| **UC05** | **Vé của tôi**        | Hiển thị danh sách vé đã đặt (thông tin phim, rạp, phòng, ghế, mã vé, mã QR minh họa)                  |
| **UC06** | **Hồ sơ cá nhân**     | Hiển thị thông tin nhóm, cài đặt ngôn ngữ và đăng xuất                                                 |

---

## Luồng điều hướng

```
LoginPage
↓
AppShell
├── HomePage
├── HotMoviesPage
├── TicketsPage
└── ProfilePage
```

- Người dùng chọn phim → vào **MovieDetailPage** → chọn ngày – giờ → sang **BookingPage** → xác nhận vé.
- Trang **ProfilePage** cho phép chuyển đổi ngôn ngữ Việt ↔ Anh bằng **Navigator.pushReplacement()**.

## Giao diện chính

| Màn hình            | Chức năng                                                          | File                        |
| ------------------- | ------------------------------------------------------------------ | --------------------------- |
| **Trang đăng nhập** | Nhập thông tin người dùng và truy cập hệ thống                     | `login_page.dart`           |
| **Trang chủ**       | Hiển thị phim đang chiếu, sắp chiếu, tìm kiếm, lọc thể loại        | `home_page.dart`            |
| **Phim hot**        | Danh sách phim nổi bật, sắp xếp theo lượt xem, yêu thích, đánh giá | `hot_movies_page.dart`      |
| **Tất cả phim**     | Hiển thị danh sách toàn bộ phim theo thể loại                      | `all_movies_page.dart`      |
| **Chi tiết phim**   | Thông tin chi tiết, chọn ngày – giờ chiếu                          | `movies_detail_page/*.dart` |
| **Đặt vé**          | Chọn ghế, hiển thị tổng tiền, xác nhận đặt vé                      | `booking_page.dart`         |
| **Vé của tôi**      | Hiển thị danh sách vé mẫu, thông tin phim và mã QR                 | `tickets_page.dart`         |
| **Hồ sơ cá nhân**   | Hiển thị thông tin nhóm, cài đặt ngôn ngữ, đăng xuất               | `profile_page.dart`         |

---

## Kiến trúc và Dòng chảy dữ liệu

Ứng dụng được chia thành **3 lớp chính**:

1. **UI / Presentation Layer**

   - Gồm các màn hình và widget giao diện (`pages/`, `widgets/`).
   - Quản lý hiển thị, tương tác, xử lý logic cục bộ bằng `setState()`.

2. **Core / Shared Components**

   - Chứa các thành phần dùng chung như `colors.dart`, theme, AppShell, AppHeader.
   - Giúp thống nhất phong cách và màu sắc toàn bộ ứng dụng.

3. **Mock Data Layer**
   - Dữ liệu phim, ghế, vé được khai báo trực tiếp trong code (`List<Map>`).
   - Dễ thay thế bằng dữ liệu thật (API / Database) trong giai đoạn mở rộng.

🔹 Dữ liệu truyền **một chiều**: từ logic sang giao diện.  
🔹 Mỗi màn hình xử lý trạng thái riêng biệt, không phụ thuộc màn khác.  
🔹 Cấu trúc đã sẵn sàng để tích hợp **Provider / Riverpod / Bloc** trong tương lai.

---

## Điều hướng & Routing

Ứng dụng sử dụng hệ thống route cố định:

| Route    | Mô tả                                         |
| -------- | --------------------------------------------- |
| `/login` | Trang đăng nhập (LoginPage)                   |
| `/shell` | Giao diện chính chứa NavigationBar (AppShell) |

- **AppShell** là khung điều hướng tổng, gồm 4 tab chính:  
  `Home`, `Hot Movies`, `Tickets`, `Profile`.
- Các trang chi tiết phim được mở qua callback `onOpenDetail()`.
- Nếu phim chưa có trang chi tiết, ứng dụng hiển thị `SnackBar("Chưa có trang chi tiết")`.

---

## Hỗ trợ đa ngôn ngữ

Ứng dụng hỗ trợ **song ngữ Việt – Anh** với cấu trúc tách biệt:

- `lib/pages/` – giao diện tiếng Việt
- `lib/pages/english/` – giao diện tiếng Anh

Người dùng có thể chuyển đổi ngôn ngữ trong `ProfilePage`.  
Khi thay đổi, ứng dụng sử dụng `Navigator.pushReplacement()` để load `AppShellEn`.

---

## Cài đặt & chạy ứng dụng

```bash
# 1. Clone repository
git clone https://github.com/<your-username>/PhenikaaCinemas.git

# 2. Cài đặt package
flutter pub get

# 3. Chạy ứng dụng
flutter run

```
