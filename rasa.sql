-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 18, 2022 lúc 04:08 PM
-- Phiên bản máy phục vụ: 10.4.11-MariaDB
-- Phiên bản PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `rasa`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dacdiem`
--

CREATE TABLE `dacdiem` (
  `sPK_Ma_DD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sTen_DD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `dacdiem`
--

INSERT INTO `dacdiem` (`sPK_Ma_DD`, `sTen_DD`) VALUES
('author', 'Tác giả'),
('brand', 'Hãng'),
('color', 'Màu sắc'),
('guarantee', 'Bảo hành'),
('material', 'Chất liệu'),
('origin', 'Xuất xứ'),
('publishing', 'Nhà xuất bản'),
('size', 'Kích Thước'),
('subject', 'Đối tượng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc`
--

CREATE TABLE `danhmuc` (
  `sPK_Ma_DMSP` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sTen_DMSP` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danhmuc`
--

INSERT INTO `danhmuc` (`sPK_Ma_DMSP`, `sTen_DMSP`) VALUES
('danhmuc_but', 'Bút'),
('danhmuc_vo', 'Vở');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc_dacdiem`
--

CREATE TABLE `danhmuc_dacdiem` (
  `sPK_Ma_DM_DD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_Ma_DMSP` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sFK_Ma_DD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danhmuc_dacdiem`
--

INSERT INTO `danhmuc_dacdiem` (`sPK_Ma_DM_DD`, `sFK_Ma_DMSP`, `sFK_Ma_DD`) VALUES
('dm_but_dd1', 'danhmuc_but', 'color'),
('dm_but_dd2', 'danhmuc_but', 'size'),
('dm_vo_dd1', 'danhmuc_vo', 'color');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `PK_Ma_Donhang` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_TenTK` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_Ma_PLSP` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `iSoluong` int(11) NOT NULL,
  `iTrangthai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phanloai_sanpham`
--

CREATE TABLE `phanloai_sanpham` (
  `sPK_Ma_PLSP` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_Ma_SP` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_Ma_DD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sTenPL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `iSoLuong` int(11) NOT NULL,
  `iGia` int(11) NOT NULL,
  `sPimage` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phanloai_sanpham`
--

INSERT INTO `phanloai_sanpham` (`sPK_Ma_PLSP`, `sFK_Ma_SP`, `sFK_Ma_DD`, `sTenPL`, `iSoLuong`, `iGia`, `sPimage`) VALUES
('BUT1_PL1', 'but_thienlong', 'color', 'Đỏ', 60, 10000, 'but1.webp'),
('BUT1_PL2', 'but_thienlong', 'color', 'Đen', 1, 10000, 'but1.webp'),
('BUT2_PL1', 'butmay', 'color', 'Xanh', 10, 0, 'but1.webp'),
('BUT2_PL2', 'butmay', 'color', 'Đen', 0, 0, 'but1.webp'),
('VO1_PL1', 'sachlaptrinh', 'size', 'A3', 10, 0, ''),
('VO1_PL2', 'sachlaptrinh', 'size', 'A4', 0, 0, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `sPK_Ma_SP` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sTen_SP` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sPimage` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `sGiaSP` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sMota` text COLLATE utf8_unicode_ci NOT NULL,
  `dNgaytao` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`sPK_Ma_SP`, `sTen_SP`, `sPimage`, `sGiaSP`, `sMota`, `dNgaytao`) VALUES
('but_thienlong', 'Bút bi', 'but1.webp', '20000', 'Bút bi Thiên Long là một trong những sản phẩm gắn liền với nhiều thế hệ học sinh Việt Nam và giới văn phòng. Với những ưu điểm vượt trội về chất lượng và giá thành, đến nay bút bi vẫn là lựa chọn hàng đầu của nhiều người. Bút bi Thiên Long có nét nhỏ, mực ra đều và trơn, không lem. Đặc biệt, bạn có thể thay ruột bút bi Thiên Long để tiết kiệm chi phí mà không cần phải mua nguyên một cây bút mới. Thiên Long liên tục thay đổi công nghệ để mang lại dòng mực chất lượng nhất cho người dùng. Hãy chọn cho mình những món đồ mà bạn yêu thích tại PENCIL STORE nhé!', '2022-07-15'),
('butmay', 'Bút Máy', 'but1.webp', '10000', 'Là đối tác lý tưởng với tiềm năng vô hạn, sở hữu thiết kế hiện đại, Parker IM khơi nguồn cảm hứng sáng tạo cho những người đang tìm kiếm ý tưởng mới trên con đường khởi nghiệp. Với ngòi thép không gỉ và hoàn thiện theo di sản Parker, mỗi chi tiết được tinh chế để đem đến trải nghiệm viết đáng tin cậy.', '2022-07-13'),
('sachlaptrinh', 'Vở viết', 'anh_chinh.jpg', '17000', 'Công ty CP Văn phòng phẩm Hồng Hà được thành lập vào ngày 1/10/1959, trải qua 62 năm trưởng thành và phát triển, thương hiệu Văn phòng phẩm Hồng Hà đã để lại dấu ấn sâu đậm trong tâm trí nhiều thế hệ người tiêu dùng Việt Nam với những sản phẩm như bút Trường Sơn, Hoàn Kiếm, Hồng Hà…', '2022-07-15'),
('thienlong', 'Bút bi nhựa', 'anh_chinh.jpg', '30000', 'Bút bi Thiên Long là một trong những sản phẩm gắn liền với nhiều thế hệ học sinh Việt Nam và giới văn phòng. Với những ưu điểm vượt trội về chất lượng và giá thành, đến nay bút bi vẫn là lựa chọn hàng đầu của nhiều người. Bút bi Thiên Long có nét nhỏ, mực ra đều và trơn, không lem. Đặc biệt, bạn có thể thay ruột bút bi Thiên Long để tiết kiệm chi phí mà không cần phải mua nguyên một cây bút mới. Thiên Long liên tục thay đổi công nghệ để mang lại dòng mực chất lượng nhất cho người dùng. Hãy chọn cho mình những món đồ mà bạn yêu thích tại PENCIL STORE nhé!', '2022-07-15');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham_dacdiem`
--

CREATE TABLE `sanpham_dacdiem` (
  `sPK_Ma_Sp_DD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_Ma_DM_DD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sFK_Ma_SP` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sMota` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham_dacdiem`
--

INSERT INTO `sanpham_dacdiem` (`sPK_Ma_Sp_DD`, `sFK_Ma_DM_DD`, `sFK_Ma_SP`, `sMota`) VALUES
('SPDD_BUT1', 'dm_but_dd1', 'but_thienlong', 'Đỏ, Đen'),
('SPDD_BUT2', 'dm_but_dd1', 'butmay', 'Đỏ, Đen'),
('SPDD_VO1', 'dm_vo_dd1', 'sachlaptrinh', 'A3, A4, A5');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `taikhoan`
--

CREATE TABLE `taikhoan` (
  `sPK_TenTK` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sMatkhau` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `dacdiem`
--
ALTER TABLE `dacdiem`
  ADD PRIMARY KEY (`sPK_Ma_DD`);

--
-- Chỉ mục cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`sPK_Ma_DMSP`);

--
-- Chỉ mục cho bảng `danhmuc_dacdiem`
--
ALTER TABLE `danhmuc_dacdiem`
  ADD PRIMARY KEY (`sPK_Ma_DM_DD`),
  ADD KEY `danhmuc_dacdiem_sfk_ma_dmsp_index` (`sFK_Ma_DMSP`),
  ADD KEY `danhmuc_dacdiem_sfk_ma_dd_index` (`sFK_Ma_DD`) USING BTREE;

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`PK_Ma_Donhang`),
  ADD KEY `sFK_Ma_PLSP` (`sFK_Ma_PLSP`),
  ADD KEY `sFK_TenTK` (`sFK_TenTK`);

--
-- Chỉ mục cho bảng `phanloai_sanpham`
--
ALTER TABLE `phanloai_sanpham`
  ADD PRIMARY KEY (`sPK_Ma_PLSP`),
  ADD KEY `phanloai_sanpham_sfk_ma_sp_index` (`sFK_Ma_SP`),
  ADD KEY `phanloai_sanpham_sfk_ma_dd_index` (`sTenPL`),
  ADD KEY `sFK_Ma_DD` (`sFK_Ma_DD`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`sPK_Ma_SP`);

--
-- Chỉ mục cho bảng `sanpham_dacdiem`
--
ALTER TABLE `sanpham_dacdiem`
  ADD PRIMARY KEY (`sPK_Ma_Sp_DD`),
  ADD KEY `sanpham_dacdiem_sfk_ma_dd_index` (`sFK_Ma_DM_DD`),
  ADD KEY `sanpham_dacdiem_sfk_ma_sp_index` (`sFK_Ma_SP`);

--
-- Chỉ mục cho bảng `taikhoan`
--
ALTER TABLE `taikhoan`
  ADD PRIMARY KEY (`sPK_TenTK`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `danhmuc_dacdiem`
--
ALTER TABLE `danhmuc_dacdiem`
  ADD CONSTRAINT `danhmuc_dacdiem_ibfk_1` FOREIGN KEY (`sFK_Ma_DMSP`) REFERENCES `danhmuc` (`sPK_Ma_DMSP`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `danhmuc_dacdiem_ibfk_2` FOREIGN KEY (`sFK_Ma_DD`) REFERENCES `dacdiem` (`sPK_Ma_DD`) ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`sFK_Ma_PLSP`) REFERENCES `phanloai_sanpham` (`sPK_Ma_PLSP`) ON UPDATE CASCADE,
  ADD CONSTRAINT `giohang_ibfk_2` FOREIGN KEY (`sFK_TenTK`) REFERENCES `taikhoan` (`sPK_TenTK`) ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `phanloai_sanpham`
--
ALTER TABLE `phanloai_sanpham`
  ADD CONSTRAINT `phanloai_sanpham_ibfk_1` FOREIGN KEY (`sFK_Ma_SP`) REFERENCES `sanpham` (`sPK_Ma_SP`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phanloai_sanpham_ibfk_2` FOREIGN KEY (`sFK_Ma_DD`) REFERENCES `dacdiem` (`sPK_Ma_DD`);

--
-- Các ràng buộc cho bảng `sanpham_dacdiem`
--
ALTER TABLE `sanpham_dacdiem`
  ADD CONSTRAINT `sanpham_dacdiem_ibfk_2` FOREIGN KEY (`sFK_Ma_SP`) REFERENCES `sanpham` (`sPK_Ma_SP`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sanpham_dacdiem_ibfk_3` FOREIGN KEY (`sFK_Ma_DM_DD`) REFERENCES `danhmuc_dacdiem` (`sPK_Ma_DM_DD`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
