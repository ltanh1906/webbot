-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 29, 2022 lúc 01:08 AM
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
-- Cơ sở dữ liệu: `bot3`
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
('specifications', 'Thông số'),
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
('dm_but_dd3', 'danhmuc_but', 'material'),
('dm_but_dd4', 'danhmuc_but', 'origin'),
('dm_but_dd5', 'danhmuc_but', 'specifications'),
('dm_but_dd6', 'danhmuc_but', 'brand'),
('dm_vo_dd1', 'danhmuc_vo', 'color'),
('dm_vo_dd2', 'danhmuc_vo', 'brand'),
('dm_vo_dd3', 'danhmuc_vo', 'material'),
('dm_vo_dd4', 'danhmuc_vo', 'size'),
('dm_vo_dd5', 'danhmuc_vo', 'specifications');

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
('BUT2_PL2', 'butmay', 'color', 'Đen', 10, 0, 'but1.webp'),
('pl1_but1', 'but1', 'color', 'Đỏ', 10, 0, ''),
('pl1_but2', 'but2', 'color', 'Trắng', 10, 0, ''),
('pl1_but3', 'but3', 'color', 'Trắng', 10, 0, ''),
('pl1_vo1', 'vo1', 'size', 'A2', 100, 0, ''),
('pl1_vo2', 'vo2', 'size', 'A2', 100, 0, ''),
('pl2_but1', 'but1', 'color', 'Xanh', 10, 0, ''),
('pl2_but2', 'but2', 'color', 'Đen', 10, 0, ''),
('pl2_but3', 'but3', 'color', 'Xanh', 0, 0, ''),
('pl2_vo1', 'vo1', 'size', 'A3', 50, 0, ''),
('pl2_vo2', 'vo2', 'size', 'A3', 50, 0, ''),
('pl2_vo3', 'vo3', 'size', 'A3', 50, 0, ''),
('pl3_but1', 'but1', 'color', 'Tím', 10, 0, ''),
('pl3_vo1', 'vo1', 'size', 'A4', 0, 0, ''),
('pl3_vo2', 'vo2', 'size', 'A4', 0, 0, ''),
('pl3_vo3', 'vo3', 'size', 'A4', 0, 0, ''),
('test', 'thienlong', 'color', 'Đen', 50, 10000, ''),
('VO1_PL1', 'sachlaptrinh', 'size', 'A3', 10, 0, ''),
('VO1_PL2', 'sachlaptrinh', 'size', 'A4', 18, 0, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `quyen`
--

CREATE TABLE `quyen` (
  `sPK_Ma_quyen` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sTen_quyen` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `quyen`
--

INSERT INTO `quyen` (`sPK_Ma_quyen`, `sTen_quyen`) VALUES
('admin', 'Quản trị'),
('khachhang', 'Khách hàng'),
('nhanvien', 'Nhân viên');

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
  `dNgaytao` date NOT NULL,
  `sHangSX` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`sPK_Ma_SP`, `sTen_SP`, `sPimage`, `sGiaSP`, `sMota`, `dNgaytao`, `sHangSX`) VALUES
('but_thienlong', 'Bút bi', 'anh_chinh.png', '20000', 'Bút bi Thiên Long là một trong những sản phẩm gắn liền với nhiều thế hệ học sinh Việt Nam và giới văn phòng. Với những ưu điểm vượt trội về chất lượng và giá thành, đến nay bút bi vẫn là lựa chọn hàng đầu của nhiều người. Bút bi Thiên Long có nét nhỏ, mực ra đều và trơn, không lem. Đặc biệt, bạn có thể thay ruột bút bi Thiên Long để tiết kiệm chi phí mà không cần phải mua nguyên một cây bút mới. Thiên Long liên tục thay đổi công nghệ để mang lại dòng mực chất lượng nhất cho người dùng. Hãy chọn cho mình những món đồ mà bạn yêu thích tại PENCIL STORE nhé!', '2022-07-15', 'Thiên Long'),
('but1', 'Bút Máy Luyện Tập Viết Chữ BAOKE PN1001', '330cebcb110b7fdae2380a3c97d6cf83.jfif', '20000', '- Hệ thống dẫn mực giúp mực ra đều, không lem và mau khô.\r\n- Thân bút bằng nhựa, nhỏ gọn có trọng lượng nhẹ, dễ cầm, viết lâu không mỏi tay rất thích hợp với học sinh tiểu học\r\n- Ngòi không mài, đầu ngòi siêu bền, viết trơn, nét nhỏ, rất thích hợp cho học sinh bắt đầu tập viết và khách hàng có nhu cầu viết nhanh.\r\n- Châm mực tái sử dụng được.', '0000-00-00', ''),
('but2', 'Bút Máy KACO EDGE K1034 Vỏ Đen Vân xước Cao Cấp Chính Hãng', '5bf774b2890d23fa4930ee3feb497c43.jfif', '175000', 'Chiếc bút máy KACO EDGE với độ cân bằng chuẩn xác và trọng lượng nhẹ, mang lại cảm giác sang trọng và thoải mái khi sử dụng.\r\nNgòi bút được gia công tỉ mỉ để nâng tầm phong cách chữ ký của bạn.\r\nDòng mực đều và lướt êm trên giấy. Thiết kế thông minh đảm bảo không bị rò rỉ mực và không bị mất nắp, vặn khi sử dụng.\r\nBút máy của KACO được trang bị thiết kế tiện dụng cho cảm giác cầm nắm dễ dàng và chắc chắn.\r\nThích hợp làm quà tặng cho bạn bè, đồng nghiệp, giáo viên,...', '0000-00-00', ''),
('but3', 'Bút Máy Ngòi Lá Tre Tách Đôi Calligraphy 005', '00d8649d3edbae81a8d9cc4e33d01a21.jfif', '30000', 'Bút thanh đậm nghệ thuật ngòi lá tre Calligraph 005 được thiết kế đơn giản mà tinh tế với điểm nhấn là chiếc ngòi lá tre dài, khi viết phần ngòi tự tách ra làm đôi tạo nên các nét thanh đậm rất đẹp mắt. \r\nNgười viết hoàn toàn có thể điều khiển được mức độ thanh đậm, nhạt của nét bút tùy theo độ ấn tay nặng - nhẹ khác nhau. Cách cầm bút, độ nghiêng của bút kết hợp với mức ấn tay sẽ giúp người viết sáng tạo nên vô số các nét thanh đậm nghệ thuật khác nhau. Chính vì thế nên nét chữ được tạo ra từ dòng bút này khiến chúng ta phải bất ngờ vì vẻ đẹp tự nhiên của nó. ', '0000-00-00', ''),
('butmay', 'Bút Máy', 'anh_chinh.jpg', '10000', 'Là đối tác lý tưởng với tiềm năng vô hạn, sở hữu thiết kế hiện đại, Parker IM khơi nguồn cảm hứng sáng tạo cho những người đang tìm kiếm ý tưởng mới trên con đường khởi nghiệp. Với ngòi thép không gỉ và hoàn thiện theo di sản Parker, mỗi chi tiết được tinh chế để đem đến trải nghiệm viết đáng tin cậy.', '2022-07-13', 'Công ty TNHH Bút máy Sao Khuê'),
('sachlaptrinh', 'Vở viết', 'anh_chinh.jpg', '17000', 'Công ty CP Văn phòng phẩm Hồng Hà được thành lập vào ngày 1/10/1959, trải qua 62 năm trưởng thành và phát triển, thương hiệu Văn phòng phẩm Hồng Hà đã để lại dấu ấn sâu đậm trong tâm trí nhiều thế hệ người tiêu dùng Việt Nam với những sản phẩm như bút Trường Sơn, Hoàn Kiếm, Hồng Hà…', '2022-07-15', 'Nhã Nam'),
('thienlong', 'Bút bi nhựa', 'anh_chinh.jpg', '30000', 'Bút bi Thiên Long là một trong những sản phẩm gắn liền với nhiều thế hệ học sinh Việt Nam và giới văn phòng. Với những ưu điểm vượt trội về chất lượng và giá thành, đến nay bút bi vẫn là lựa chọn hàng đầu của nhiều người. Bút bi Thiên Long có nét nhỏ, mực ra đều và trơn, không lem. Đặc biệt, bạn có thể thay ruột bút bi Thiên Long để tiết kiệm chi phí mà không cần phải mua nguyên một cây bút mới. Thiên Long liên tục thay đổi công nghệ để mang lại dòng mực chất lượng nhất cho người dùng. Hãy chọn cho mình những món đồ mà bạn yêu thích tại PENCIL STORE nhé!', '2022-07-15', 'Thiên Long'),
('vo1', 'Sổ tay A5 trang Guden_Guden', '', '25000', '1. Mô tả chung: Sản phẩm được sản xuất tại Việt Nam, sử dụng công nghệ in Offset đem lại màu sắc in sắc nét. Sổ được lót một tấm bìa Carton chống gãy form sổ, đem lại cảm giác cứng cáp trong suốt thời gian sử dụng\r\n2. Công dụng: Sổ tay sử dụng với mục đích ghi chép cơ bản, ghi bài, take note. KHÔNG NÊN sử dụng các loại màu nước lên sổ, sẽ bị thấm qua các trang sau.', '0000-00-00', ''),
('vo2', 'Vở kẻ ngang Klong Hornet ', '', '9000', 'Sản phẩm sử dụng được với nhiều loại bút khác nhau.\r\nSổ có bìa cứng cáp, giúp giữ form sổ tốt, thiết kế bìa độc đáo, đẹp mắt ấn tượng.\r\nSổ giúp bạn ghi chú được nhiều hơn những thông tin quan trọng, kịp thời nắm bắt những ý tưởng hay, bất ngờ.', '0000-00-00', ''),
('vo3', 'Giáo Án A4 200 Trang Subject Hồng Hà', '', '28000', 'Sổ có bề mặt giấy nhẵn mịn, giúp nét chữ thanh thoát, không bị nhòe mực, cho cảm giác viết êm tay.\r\nĐặc biệt, với khả năng chống lóa, sản phẩm giúp bảo vệ, chống mỏi mắt cho người viết.', '0000-00-00', '');

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
('ddsp_but1_1', 'dm_but_dd1', 'but1', 'Xanh, Đỏ, Tím, Vàng'),
('ddsp_but1_2', 'dm_but_dd2', 'but1', '10cm'),
('ddsp_but1_3', 'dm_but_dd3', 'but1', 'PC, Nhôm, Đồng'),
('ddsp_but1_4', 'dm_but_dd4', 'but1', 'Trung Quốc'),
('ddsp_but1_5', 'dm_but_dd5', 'but1', 'Ngòi bút: Ngòi F (0.4-0.5mm)\r\nTúi mực: Gồm 2 chiếc\r\nMàu mực: Đen\r\nDung tích: 1.37ml'),
('ddsp_but1_6', 'dm_but_dd6', 'but1', 'Hãng Axeon'),
('ddsp_but2_1', 'dm_but_dd1', 'but2', 'Đen, Trắng'),
('ddsp_but2_2', 'dm_but_dd2', 'but2', '15cm'),
('ddsp_but2_3', 'dm_but_dd3', 'but2', 'Gỗ, Nhựa'),
('ddsp_but2_4', 'dm_but_dd4', 'but2', 'Trung Quốc'),
('ddsp_but2_5', 'dm_but_dd5', 'but2', 'Ngòi bút: Ngòi F (0.4-0.5mm)\r\nTúi mực: Gồm 2 chiếc\r\nMàu mực: Đen\r\nDung tích: 1.37ml'),
('ddsp_but2_6', 'dm_but_dd6', 'but2', 'THIENLONG'),
('ddsp_but3_1', 'dm_but_dd1', 'but3', 'Trắng, Xanh'),
('ddsp_but3_2', 'dm_but_dd2', 'but3', '10cm'),
('ddsp_but3_3', 'dm_but_dd3', 'but3', 'PC, Nhôm'),
('ddsp_but3_4', 'dm_but_dd4', 'but3', 'Việt Nam'),
('ddsp_but3_5', 'dm_but_dd5', 'but3', 'Ngòi bút: Ngòi F (0.4-0.5mm)\r\nTúi mực: Gồm 2 chiếc\r\nMàu mực: Đen\r\nDung tích: 1.37ml'),
('ddsp_but3_6', 'dm_but_dd6', 'but3', 'HONGHA'),
('ddsp_vo1_1', 'dm_vo_dd1', 'vo1', 'Vàng, Đen, Trắng'),
('ddsp_vo1_2', 'dm_vo_dd2', 'vo1', 'Guden'),
('ddsp_vo1_3', 'dm_vo_dd3', 'vo1', 'Giấy chống lóa'),
('ddsp_vo1_4', 'dm_vo_dd4', 'vo1', 'A2, A3, A4'),
('ddsp_vo1_5', 'dm_vo_dd5', 'vo1', 'Số trang: 45 trang'),
('ddsp_vo2_1', 'dm_vo_dd1', 'vo2', 'Đen, Trắng'),
('ddsp_vo2_2', 'dm_vo_dd2', 'vo2', 'KLONG'),
('ddsp_vo2_3', 'dm_vo_dd3', 'vo2', 'Giấy chống lóa'),
('ddsp_vo2_4', 'dm_vo_dd4', 'vo2', 'A2, A3, A4'),
('ddsp_vo2_5', 'dm_vo_dd5', 'vo2', 'Số trang: 80 trang'),
('ddsp_vo3_1', 'dm_vo_dd1', 'vo3', 'Trắng, Xanh'),
('ddsp_vo3_2', 'dm_vo_dd2', 'vo3', 'HỒNG HÀ'),
('ddsp_vo3_3', 'dm_vo_dd3', 'vo3', 'Giấy chống lóa'),
('ddsp_vo3_4', 'dm_vo_dd4', 'vo3', 'A4, A5'),
('ddsp_vo3_5', 'dm_vo_dd5', 'vo3', 'Số trang: 120 trang'),
('SPDD_BUT1', 'dm_but_dd1', 'but_thienlong', 'Đỏ, Đen'),
('SPDD_BUT2', 'dm_but_dd2', 'butmay', 'Đỏ, Đen'),
('SPDD_VO1', 'dm_vo_dd1', 'sachlaptrinh', 'A3, A4, A5');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `taikhoan`
--

CREATE TABLE `taikhoan` (
  `sPK_TenTK` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sFK_Ma_Quyen` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sMatkhau` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sTenTK` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dNgaysinh` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `taikhoan`
--

INSERT INTO `taikhoan` (`sPK_TenTK`, `sFK_Ma_Quyen`, `sMatkhau`, `sTenTK`, `dNgaysinh`) VALUES
('admin', 'admin', '356a192b7913b04c54574d18c28d46e6395428ab', '123', '0000-00-00'),
('chuyenmon_luat', 'khachhang', '356a192b7913b04c54574d18c28d46e6395428ab', 'Hạnh', '2022-07-04'),
('hung', 'nhanvien', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Hùng', '2001-02-08'),
('kh', 'khachhang', '356a192b7913b04c54574d18c28d46e6395428ab', 'kh', '2022-07-12'),
('tan', 'khachhang', '356a192b7913b04c54574d18c28d46e6395428ab', 'Mạc Đức Tân', '2022-07-01'),
('tan123', 'nhanvien', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Mạc Đức Tan', '2001-02-08');

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
  ADD UNIQUE KEY `sFK_TenTK_2` (`sFK_TenTK`,`sFK_Ma_PLSP`),
  ADD KEY `sFK_Ma_PLSP` (`sFK_Ma_PLSP`),
  ADD KEY `sFK_TenTK` (`sFK_TenTK`),
  ADD KEY `iTrangthai` (`iTrangthai`);

--
-- Chỉ mục cho bảng `phanloai_sanpham`
--
ALTER TABLE `phanloai_sanpham`
  ADD PRIMARY KEY (`sPK_Ma_PLSP`),
  ADD KEY `phanloai_sanpham_sfk_ma_sp_index` (`sFK_Ma_SP`),
  ADD KEY `phanloai_sanpham_sfk_ma_dd_index` (`sTenPL`),
  ADD KEY `sFK_Ma_DD` (`sFK_Ma_DD`);

--
-- Chỉ mục cho bảng `quyen`
--
ALTER TABLE `quyen`
  ADD PRIMARY KEY (`sPK_Ma_quyen`);

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
  ADD PRIMARY KEY (`sPK_TenTK`),
  ADD KEY `sFK_Ma_Quyen` (`sFK_Ma_Quyen`);

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

--
-- Các ràng buộc cho bảng `taikhoan`
--
ALTER TABLE `taikhoan`
  ADD CONSTRAINT `taikhoan_ibfk_1` FOREIGN KEY (`sFK_Ma_Quyen`) REFERENCES `quyen` (`sPK_Ma_quyen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
