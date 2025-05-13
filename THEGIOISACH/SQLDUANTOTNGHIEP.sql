
-- Tạo database
create database DATN_Bookstore
use DATN_Bookstore


-- Cấu hình một số thuộc tính cho database
ALTER DATABASE DATN_Bookstore SET COMPATIBILITY_LEVEL = 150;
ALTER DATABASE DATN_Bookstore SET RECOVERY FULL;
GO

CREATE TABLE Nguoi_Dung(
    ID_nguoi_dung INT IDENTITY(1,1) PRIMARY KEY,
    Ten NVARCHAR(50) NOT NULL,
	Ho_va_Ten nvarchar(50) not null,
    Email NVARCHAR(50) NOT NULL,
    SDT INT NOT NULL,
    Dia_chi NVARCHAR(200) NOT NULL,
    Mat_khau NVARCHAR(50) NOT NULL,
    Role BIT NOT NULL
);
CREATE TABLE Danh_Gia (
    ID_danh_gia INT IDENTITY(1,1) PRIMARY KEY,
    ID_nguoi_dung INT NOT NULL,
    ID_san_pham INT NOT NULL,
    Ngay_danh_gia DATE NOT NULL,
    Danh_gia INT NOT NULL,
    Binh_luan NVARCHAR(200) NOT NULL
);
CREATE TABLE Thanh_Toan (
    ID_thanh_toan INT IDENTITY(1,1) PRIMARY KEY,
    ID_nguoi_dung INT NOT NULL,
    ID_san_pham INT NOT NULL,
    Ngay_dat_hang DATE NOT NULL,
    Tong_tien INT NOT NULL,
    Phuong_thuc_thanh_toan NVARCHAR(50) NOT NULL,
    So_luong INT NOT NULL
);

CREATE TABLE Thong_Ke (
    ID_thong_ke INT IDENTITY(1,1) PRIMARY KEY,
    ID_thanh_toan INT NOT NULL,
 tong_doanh_thu INT DEFAULT 0,
 );
 
 CREATE TABLE The_Loai (
    ID_the_loai INT IDENTITY(1,1) PRIMARY KEY,
    The_loai NVARCHAR(50) NOT NULL
);
CREATE TABLE Hinh (
    ID_hinh INT IDENTITY(1,1) PRIMARY KEY,
    Hinh_main VARBINARY(MAX) NOT NULL,
    Hinh_1 VARBINARY(MAX) ,
    Hinh_2 VARBINARY(MAX) ,
    Hinh_3 VARBINARY(MAX) ,
    Hinh_4 VARBINARY(MAX) 
);
CREATE TABLE San_Pham (
    ID_san_pham INT IDENTITY(1,1) PRIMARY KEY,
    ID_the_loai INT NOT NULL,
    ID_hinh INT NOT NULL, 
    Nha_xuat_ban NVARCHAR(50) NOT NULL,
    NSX DATE NOT NULL,
    Ten_sach NVARCHAR(MAX) NOT NULL,
    Tac_gia NVARCHAR(50) NOT NULL,
    Gia INT NOT NULL,
    So_luong_da_ban INT,
    So_luong_ton_kho INT not null,
    So_luong_tong_san_pham INT NOT NULL,
    Mo_ta NVARCHAR(MAX) NOT NULL
);


ALTER TABLE Danh_Gia
ADD CONSTRAINT FK_DanhGia_NguoiDung FOREIGN KEY (ID_nguoi_dung) REFERENCES Nguoi_Dung(ID_nguoi_dung),
    CONSTRAINT FK_DanhGia_SanPham FOREIGN KEY (ID_san_pham) REFERENCES San_Pham(ID_san_pham);

--ALTER TABLE Hinh
--ADD CONSTRAINT FK_Hinh_SanPham FOREIGN KEY (ID_san_pham) REFERENCES San_Pham(ID_san_pham);

ALTER TABLE San_Pham
ADD CONSTRAINT FK_SanPham_Hinh FOREIGN KEY (ID_hinh) REFERENCES Hinh(ID_hinh);

ALTER TABLE San_Pham
ADD CONSTRAINT FK_SanPham_TheLoai FOREIGN KEY (ID_the_loai) REFERENCES The_Loai(ID_the_loai);


ALTER TABLE Thanh_Toan
ADD CONSTRAINT FK_ThanhToan_NguoiDung FOREIGN KEY (ID_nguoi_dung) REFERENCES Nguoi_Dung(ID_nguoi_dung),
    CONSTRAINT FK_ThanhToan_SanPham FOREIGN KEY (ID_san_pham) REFERENCES San_Pham(ID_san_pham);

ALTER TABLE Thong_Ke
ADD CONSTRAINT FK_ThongKe_ThanhToan FOREIGN KEY (ID_thanh_toan) REFERENCES Thanh_Toan(ID_thanh_toan);


-- Chèn dữ liệu vào bảng Admins
INSERT INTO Nguoi_Dung (Ten,Ho_va_Ten, Email, SDT, Dia_chi, Mat_khau, Role)
VALUES 
    (N'huynhcaodan',N'Huỳnh Cao Dân', 'huynhcaodan123@gmail.com', 0358978038, N'209/1 Nguyễn Văn Khối, Phường 8, Quận Gò Vấp, Thành Phố Hồ Chí Minh', '16062004', 0),
    (N'nguyenhoanganhkiet',N'Nguyễn Hoàng Anh Kiệt', 'kietnguyenhoang155@gmail.com', 0353904515, N'204 Nguyễn Thị Mười, Quận 12, Thành Phố Hồ Chí Minh', '123456789', 0),
	(N'lengockhanhthu',N'Lê Ngọc Khánh Thư', 'thukhanhngocle240203@gmail.com', 0909297251, N'84 Tô Ký, Quận 12, Thành Phố Hồ Chí Minh', '123456789', 1),
	(N'ledoanhkhai',N'Lê Đỗ Anh Khải', 'ledoanhkhai17@gmail.com', 0393378417, N'Thống Nhất, Tỉnh Đồng Nai', '123456789', 1),
	(N'huynhthephong',N'Huỳnh Thế Phong', 'huynhthephongb@gmail.com', 0914257687, N'86 Tô Ký, Quận 12, Thành Phố Hồ Chí Minh', '123456789', 1),
	(N'nguyendohongvu',N'Nguyễn Đỗ Hoàng Vũ', 'vu4283222@gmail.com', 0334849121, N'796/66 Lê Đức Thọ, Phường 15, Quận Gò Vấp, Thành Phố Hồ Chí Minh', '123456789', 1);





-- Chèn dữ liệu vào bảng The_Loai
INSERT INTO The_Loai (The_loai)
VALUES 
    (N'Văn học'),
    (N'Tiểu thuyết'),
    (N'Lịch sử'),
	(N'Khoa học'),
	(N'Cổ tích'),
	(N'Địa lý');
	

	-- Chạy bảng thể loại xong tới hình rồi tới sản phẩm 
-- Chèn dữ liệu vào bảng San_Pham
INSERT INTO San_Pham (ID_the_loai,ID_hinh, Nha_xuat_ban, NSX, Ten_sach, Tac_gia, Gia, So_luong_da_ban, So_luong_ton_kho, So_luong_tong_san_pham, Mo_ta)
VALUES
	-- văn học --
    (1,1, N'NXB Trẻ', '2021-01-01', N'Cánh Đồng Bất Tận (Tái Bản 2019)', N'Nguyễn Ngọc Tư', 85000, 0, 500, 500, N' Đây là tác phẩm đang gây xôn xao trong đời sống văn học, bởi ở đó người ta tìm thấy sự dữ dội, khốc liệt của đời sống thôn dã qua cái nhìn của một cô gái.'),
    (1,2, N'NXB Văn học', '2022-01-01', N'Hà Nội 36 Phố Phường (Tái Bản)', N'Thạch Lam', 50000, 0, 500, 500,N'Thạch Lam tên thật là Nguyễn Tường Vinh, sau đổi là Nguyễn Tường Lân. Ngoài tên Thạch Lam, ông còn có bút danh khác như Việt Sinh, Thiện Sỹ.'),
	(1, 3, N'NXB Kim Đồng', '2021-01-01', N'Thơ Hàn Mặc Tử - Văn Học Trong Nhà Trường', N'Hàn Mặc Tử', 40000, 0, 500, 500, N'Hàn Mặc Tử được sinh ra cho thơ. Sinh thời, Hàn đã sống bằng thơ. Bây giờ và mai sau Hàn vẫn sống bằng thơ.'),
    (1, 4, N'NXB Văn Học', '2023-01-01', N'Tác Phẩm Văn Học Kinh Điển - Hoàng Tử Bé', N'Antoine De Saint-Exupéry', 50000, 0, 500, 500, N'Hoàng Tử Bé” (tên tiếng Pháp: Le Petit Prince) xuất bản năm 1943 và là tác phẩm nối tiếng nhất trong sự nghiệp của nhà văn phi công Pháp Antoine de Saint-Exupéry.'),
	(1, 5, N'NXB Kim Đồng', '2022-01-01', N'Hai Vạn Dặm Dưới Biển (Tái Bản 2022)', N'Jules Verne', 99000, 5, 495, 500, N'Một chiếc tàu ngầm thoắt ẩn, thoắt hiện, cùng một vị thuyền trưởng mang trong mình lời thề sẽ không bao giờ can dự vào cuộc sống trên đất liền thêm một lần nào nữa…'),
    (1, 6, N'NXB Văn Học', '2023-01-01', N'Nước Non Vạn Dặm - Tập 2 : Lênh Đênh Trên Biển', N'Nguyễn Thế Kỷ', 188000, 7, 493, 500, N'Bộ tiểu thuyết “Nước non vạn dặm” gồm 3 tập khắc họa hình tượng Chủ tịch Hồ Chí Minh ở ba giai đoạn quan trọng của Người.'),
	(1, 7, N'NXB Trẻ', '2024-01-01', N'Lũy Hoa', N'Nguyễn Huy Tưởng', 119000, 0, 500, 500, N'Thảo xong Sống mãi với Thủ đô, Tập 1, về ba ngày đầu Toàn quốc kháng chiến ở Hà Nội, Nguyễn Huy Tưởng viết xen Lũy hoa, và kết thúc truyện phim này vào ngày 15-6-1959, khi căn bệnh hiểm trong mình đang phát lộ, để chỉ hơn một năm sau, ngày 25-7-1960 thì nhà văn qua đời.'),
	(1, 8, N'NXB Văn Học', '2023-01-01', N'Nhật Ký Trong Tù (Tái Bản)', N'Hồ Chí Minh', 48000, 0, 500, 500, N'Chủ tịch Hồ Chí Minh là vị lãnh tụ thiên tài của Đảng và nhân dân Việt Nam, anh hùng giải phóng dân tộc, danh nhân văn hoá thế giới.'),
	(1, 9, N'NXB Văn Học', '2023-01-01', N'Nước Non Vạn Dặm - Tập 1: Nợ Nước Non', N'Nguyễn Thế Kỷ', 168000, 0, 500, 500, N'Bộ tiểu thuyết “Nước non vạn dặm” gồm 3 tập khắc họa hình tượng Chủ tịch Hồ Chí Minh ở ba giai đoạn quan trọng của Người.'),
	(1, 10, N'NXB Văn Học', '2024-01-01', N'Tắt Đèn', N'Ngô Tất Tố', 86000, 0, 500, 500, N'"Tắt Đèn" – tác phẩm nổi bật của Ngô Tất Tố, mang đến một cái nhìn chân thực và sâu sắc về cuộc sống của người dân nghèo trong xã hội xưa.'),
	(1, 11, N'NXB Văn Học', '2022-01-01', N'Hồ Xuân Hương Tiếng Vọng', N'Nghiêm Thị Hằng', 215000, 0, 500, 500, N'Bức chân dung nữ sĩ trong tiểu thuyết được vẽ nên bởi những con chữ có tiếng vọng của người xưa chỉ dẫn.'),
	(1, 12, N'NXB Văn Học', '2024-01-01', N'Trúng Số Độc Đắc', N'Vũ Trọng Phụng', 98000, 0, 500, 500, N'"Trúng Số Độc Đắc" – tác phẩm nổi bật của Vũ Trọng Phụng, mang đến cho bạn một cái nhìn sắc sảo và hài hước về xã hội Việt Nam thời kỳ đầu thế kỷ 20.'),
	(1, 13, N'NXB Văn Học', '2015-01-01', N'Truyện Kiều', N'Nguyễn Du, Đào Duy Anh', 35000, 0, 500, 500, N'Tác phẩm Truyện Kiều, nguyên tên là Đoạn trường tân thanh, từ khi ra đời đến nay (khoảng 200 năm), trong lịch sử Văn học Việt Nam chưa có công trình nào nghiên cứu sâu sắc về nó.'),
	(1, 14, N'NXB Trẻ', '2018-01-01', N'Tự Nhiên Say - Văn Học Tuổi 20', N'Phát Dương', 52000, 7, 493, 500, N'Tập truyện xoay quanh cuộc sống của người dân quê, nơi đất vườn đã dần hóa thành đô thị làm thay đổi cả lòng người. Cách viết mộc mạc giản dị nhưng ẩn sau là những thông điệp sâu sắc, và bàng bạc một cái tình rất đỗi tha thiết với nhân gian.'),
	(1, 15, N'NXB Văn Học', '2024-01-01', N'Vũ Trọng Phụng', N'Vũ Trọng Phụng', 90000, 0, 500, 500, N'Vỡ Đê– một tác phẩm nổi bật của Vũ Trọng Phụng, mở ra một cái nhìn sâu sắc và sắc sảo về xã hội Việt Nam trong giai đoạn đầu thế kỷ XX.'),
	
	-- tiểu thuyết -- 
	(2, 16, N'NXB Trẻ', '2023-01-01', N'Beartown - Thị Trấn Nhỏ, Giấc Mơ Lớn', N'Fredrik Backman', 210000, 0, 500, 500, N'Fredrik Backman cuốn hút người đọc vào cuốn tiểu thuyết sâu sắc, quyến rũ về một thị trấn nhỏ mang giấc mơ lớn – và cái giá phải trả để biến giấc mơ thành hiện thực.'),
	(2, 17, N'NXB Hội Nhà Văn', '2024-01-01', N'Bố Già ', N'Mario Puzo, Art Werger', 200000, 0, 500, 500, N'Thế giới ngầm được phản ánh trong tiểu thuyết Bố già là sự gặp gỡ giữa một bên là ý chí cương cường và nền tảng gia tộc chặt chẽ theo truyền thống mafia xứ Sicily với một bên là xã hội Mỹ nhập nhằng đen trắng, mảnh đất màu mỡ cho những cơ hội làm ăn bất chính hứa hẹn những món lợi kếch xù..'),
	(2, 18, N'NXB Trẻ', '2014-01-01', N'Cáo Già, Gái Già Và Tiểu Thuyết Diễm Tình', N'Dương Thụy', 45000, 0, 500, 500, N'Với những chi tiết thú vị thế, tôi đọc cả tập truyện của cùng một tác giả mà không thấy chán.'),
	(2, 19, N'NXB Kim Đồng', '2022-01-01', N'Cha Và Con - Tiểu Thuyết Về Bác Hồ Và Cụ Phó Bảng Nguyễn Sinh Sắc (Tái Bản 2022)', N'Hồ Phương', 100000, 0, 200, 200, N'Viết về một thời kì lịch sử còn đậm đặc chất phong kiến, nhưng nhà văn Hồ Phương chọn cách thể hiện nhanh, khá hiện đại, mang màu sắc điện ảnh.'),
	(2, 20, N'NXB Dân Trí', '2023-01-01', N'Chưa Kịp Lớn Đã Trưởng Thành (Tái Bản 2023)', N'Tớ Là Mây', 79000, 0, 500, 500, N'Chúng ta của hiện tại, đều chưa kịp lớn đã phải trưởng thành. '),
	(2, 21, N'NXB Văn Học', '2022-01-01', N'Hiệu Sách Cuối Cùng Ở London - Tiểu Thuyết Về Chiến Tranh Thế Giới Thứ Hai', N'Madeline Martin', 180000, 0, 200, 200, N'Hiệu sách cuối cùng ở London là cuốn tiểu thuyết tình cảm hấp dẫn, là những trang sử ghi lại quãng thời gian khó khăn của người dân London trong Chiến tranh Thế giới thứ Hai'),
	(2, 22, N'NXB Hà Nội', '2023-01-01', N'Hãy Về Với Cha', N'Shin Kyung-Sook', 179000, 0, 500, 500, N'Mất đi con gái, nữ nhà văn thu mình lại, đoạn tuyệt với mọi mối quan hệ, thậm chí với chính những người thân trong gia đình, hòng trốn tránh nỗi đau và dằn vặt quá lớn.'),
	(2, 23, N'NXB Phụ Nữ Việt Nam', '2024-01-01', N'Kéo Búa Bao', N'Alice Feeney', 229000, 0, 500, 500, N'Mười năm hôn nhân. Mười năm chôn giấu bí mật. Và một ngày kỷ niệm chẳng bao giờ có thể lãng quên.'),
	(2, 24, N'NXB Văn Học', '2022-01-01', N'Không Gia Đình (Tái Bản 2022)', N'Hector Malot', 175000, 0, 500, 500, N'Không gia đình kể về cậu bé Rê-mi. Rê-mi bị bắt cóc khi còn nhỏ. Sau đó, bị bán để theo một đoàn xiếc thú, rồi dẫn đầu đoàn ấy đi lưu lạc khắc nước Pháp và cuối cùng tìm thấy gia đình.'),
	(2, 25, N'NXB Hội Nhà Văn', '2020-01-01', N'Nhà Giả Kim (Tái Bản 2020)', N'Paulo Coelho', 79000, 0, 500, 500, N'Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người.'),
	(2, 26, N'NXB Kim Đồng', '2024-01-01', N'Người Người Lớp Lớp', N'Trần Dần', 95000, 0, 500, 500, N'Người Người Lớp Lớp - Tiểu Thuyết Đầu Tiên Về Chiến Dịch Điện Biên Phủ,'),
	(2, 27, N'NXB Hội Nhà Văn', '2022-01-01', N'Thư Viện Nửa Đêm', N'Matt Haig', 150000, 0, 500, 500, N'Thắng hạng mục sách hư cấu của Goodreads.Được đưa vào danh sách tổng kết sách hay nhất năm của The Washington Post, Christian Science Monitor, New York Public Library, Boston Globe, Amazon, PureWow, St. Louis Public Radio, She Reads, Lit Hub, The Mary Sue v.v.'),
	(2, 28, N'NXB Trẻ', '2018-01-01', N'Thông Reo Ngàn Hống (Tiểu Thuyết Lịch Sử)', N'Nguyễn Thế Quang', 140000, 8, 492, 500, N'Nguyễn Công Trứ là một nhân vật lịch sử lỗi lạc, độc đáo, giàu cá tính bậc nhất trong lịch sử Việt Nam, là nguồn cảm hứng phong phú cho sáng tạo nghệ thuật.'),
	(2, 29, N'NXB Kim Đồng', '2020-01-01', N'Trường Ca Achilles', N'Madeline Miller', 156000, 0, 500, 500, N'Trường Ca Achilles đã đoạt giải Orange năm 2012 và luôn nằm trong top các sách bán chạy của tờ New York Times.'),
	(2, 30, N'NXB Hội Nhà Văn', '2024-01-01', N'Xanh Xanh Góc Trời', N'Lê Minh', 148000, 0, 500, 500, N'Giữa cuộc đời chảy trôi theo từng bước chân, giữa tháng năm thấm thoát chẳng thể nào quay lại, vẫn còn một mảnh trời xanh nơi ngôi trường ngày ấy đã chứng kiến bao khoảnh khắc vụng dại của những cô cậu học trò.'),
	
	-- lịch sử -- 
	(3, 31, N'NXB Thanh Niên', '2021-01-01', N'Các Triều Đại Việt Nam', N'Quỳnh Cư, Đỗ Đức Hùng', 120000, 3, 497, 500, N'Dân tộc Việt Nam anh hùng đã trải qua hơn bốn ngàn năm lịch sử dựng nước và giữ nước. Với ý chí quật cường ông cha ta đã viết nên những trang sử vàng chói lói làm vẻ vang cho dân tộc ta, đất nước ta.'),
	(3, 32, N'NXB Trẻ', '2020-01-01', N'Thắng Pháp trên bầu trời Điện Biên Phủ', N'Lưu Trọng Luân', 90000, 2, 498, 500, N'Với lời tựa của Đại Tướng Võ Nguyên Giáp.'),
	(3, 33, N'NXB Văn Học', '2022-01-01', N'Đại Việt Sử Ký Toàn Thư (Box Set)', N'Nhiều Tác Giả', 1900000, 0, 500, 500, N'Đại Việt sử ký toàn thư là bộ quốc sử danh tiếng, một di sản quý báu của dân tộc Việt Nam nghìn năm văn hiến. Đây là bộ sử cái có giá trị về nhiều mặt, gắn liền với tên tuổi của các nhà sử học nổi tiếng như Lê Văn Hưu, Phan Phu Tiên, Ngô Sĩ Liên, Phạm Công Trứ, Lê Hy…'),
	(3, 34, N'NXB Tổng Hợp TPHCM', '2024-01-01', N'Điệp Viên Tám Thảo', N'Mã Thiện Đồng', 110000, 0, 500, 500, N'Nữ điệp viên Tám Thảo, xuyên suốt thời kỳ hoạt động, vẫn vẹn nguyên là một cô tiểu thư Mỹ Nhung xinh đẹp, tài năng, sống giữa đô thành “Hòn Ngọc Viễn Đông” hoa lệ; bình thản làm việc bên cạnh ngài Trung tá tình báo Cố vấn Mỹ ở bộ Tư lệnh Hải quân.'),
	(3, 35, N'NXB Kim Đồng', '2023-01-01', N'Hoàng Lê Nhất Thống Chí', N'Ngô Gia Văn Phái', 140000, 0, 500, 500, N'Trong văn học cổ điển của ta, Hoàng Lê nhất thống chí là một tác phẩm văn xuôi đầu tiên có quy mô hoành tráng của một bộ sử thi, xứng đáng là một bộ tiểu thuyết lịch sử đặc sắc, có giá trị cả về hai mặt – văn học và sử học.'),
	(3, 36, N'NXB Kim Đồng', '2023-01-01', N'Hành Trình Sáng Tạo Chữ Quốc Ngữ (Tái Bản 2023)', N'Tạ Huy Long, Phạm Thị Kiều Ly', 105000, 0, 500, 500, N'Chữ viết Tiếng Việt ra đời như thế nào? Tại sao chúng ta hiện nay lại đang dùng thứ văn tự Latinh, khác hẳn với các nước xung quanh? Chúng ta vẫn nói mình dùng chữ Quốc ngữ. Vậy chữ Quốc ngữ là gì? Ai đã tạo ra nó? Đó chính là những nội dung mà cuốn sách Người Việt gọi tôi là Cha Đắc Lộ - Hành trình sáng tạo chữ Quốc ngữ sẽ giải đáp.'),
	(3, 37, N'NXB Tổng Hợp TPHCM', '2019-01-01', N'Ký Hiệu Và Liên Ký Hiệu', N'Lê Huy Bắc', 130000, 0, 500, 500, N'Ký hiệu tồn tại như một sự tổng hòa các mối quan hệ văn hóa. Không thể có bất cứ một ký hiệu nào nằm ngoài văn hóa.'),
	(3, 38, N'NXB Thế Giới', '2024-01-01', N'Lịch Sử Sách - Ấn Bản Đặc Biệt', N'James Raven', 2500000, 0, 500, 500, N'Lịch sử sách tóm lược dòng thời gian mang lại cảm giác sinh động về những điểm tương đồng, tương phản bất ngờ trong lịch sử làm sách cũng như đọc sách trên toàn thế giới. Việc tổng hợp các mốc thời gian về những thời điểm tiêu biểu trong lịch sử toàn cầu của sách sẽ khiến chúng ta phải ngồi ngẫm lại.'),
	(3, 39, N'NXB Thế Giới', '2022-01-01', N'Lịch Sử Cái Đẹp', N'Umberto Eco', 450000, 5, 495, 500, N'Tác phẩm thú vị này hẳn sẽ bóp nghẹt mọi định kiến xưa cũ và qua mỗi chương lại vẽ nên một tấm bản đồ thực sự về sự dịu dàng của Cái Đẹp.'),
	(3, 40, N'NXB Hồng Đức', '2022-01-01', N'Lịch Sử Thế Giới', N'Nguyễn Hiến Lê, Thiên Giang', 254000, 4, 496, 500, N'Lịch sử thế giới hay còn gọi là lịch sử loài người, bắt đầu từ thời đại đồ đá cũ đến nay trong quá trình tiến hóa loài người. Đó là một hành trình lịch sử đem đến vĩ đại của loài người như hiện nay, rất đáng đọc và tìm hiểu. '),
	(3, 41, N'NXB Tổng Hợp TPHCM', '2023-01-01', N'Nam Phương Hoàng Hậu', N'Tử Yếng Lương Hoài Trọng Tính', 85000, 0, 500, 500, N'Vị Quốc Mẫu Tân Thời Qua Tư Liệu Báo Chí (1934-1945).'),
	(3, 42, N'NXB Tổng Hợp TPHCM', '2023-01-01', N'Lịch Sử Tranh Đoạt Tài Nguyên Thế Giới', N'Hikaru Hiranuma', 160000, 0, 500, 500, N'Tài nguyên là tất cả các dạng vật chất, tri thức, thông tin được con người sử dụng để tạo ra của cải vật chất hoặc tạo ra giá trị sử dụng mới cho con người.'),
	(3, 43, N'NXB Dân Trí', '2022-01-01', N'Những Trận Chiến Thay Đổi Lịch Sử', N'DK', 500000, 0, 500, 500, N'Những trận chiến thay đổi lịch sử là tuyển tập hơn 90 trận giao tranh quan trọng nhất thế giới, từ thời cổ đại cho đến kỷ nguyên nguyên tử.'),
	(3, 44, N'NXB Văn Học', '2022-01-01', N'Việt Nam Sử Lược (Tái Bản)', N'Trần Trọng Kim', 150000, 0, 500, 500, N'Việt Nam sử lược là cuốn sách lịch sử Việt Nam đầu tiên viết bằng chữ quốc ngữ, hệ thống lại toàn bộ lịch sử nước Việt (cho đến thời kỳ Pháp thuộc).'),
	(3, 45, N'NXB Tổng Hợp TPHCM', '2023-01-01', N'Võ Thị Sáu - Con Người Và Huyền Thoại (Tái Bản 2023)', N'Nguyễn Đình Thống', 30000, 8, 492, 500, N'Chị Võ Thị Sáu – người thiếu nữ anh hùng của quê hương Đất Đỏ (tỉnh Bà Rịa - Vũng Tàu) đã đi vào huyền thoại, trở thành dấu son truyền thống trong cuộc đấu tranh giành độc lập của dân tộc ta.'),
	
	-- khoa học -- 
	(4, 46, N'NXB Kim Đồng', '2023-01-01', N'30 Giây Khoa Học - 30 Giây Khoa Học Dữ Liệu', N'Liberty Vittert', 1000, 0, 500, 500, N'Liberty Vittert là Giáo sư Khoa học Dữ liệu tại Trường Olin Business thuộc Đại học Washington, St Louis.'),
	(4, 47, N'NXB Picador', '2023-01-01', N'How I Won A Nobel Prize', N'Julius Taranto', 365000, 0, 500, 500, N'‘A stunning new talent, announcing itself fully formed’ – Jonathan Lethem'),
	(4, 48, N'NXB Dân Trí', '2023-01-01', N'Atlas Các Loài Chim', N'Barbara Taylor, Richard Orr', 190000, 0, 500, 500, N'Bách Khoa Bằng Hình Về Các Loài Chim Trên Thế Giới'),
	(4, 49, N'NXB Tổng Hợp TPHCM', '2019-01-01', N'Bên Lề Khoa Học', N'Trương Văn Tân', 1000, 0, 500, 500, N'Cuốn sách gồm hai phần chính: Phần 1: Khoa học và Giáo dục, và Phần 2: Du ký.'),
	(4, 50, N'NXB Tổng Hợp TPHCM', '2018-01-01', N'Câu Chuyện Khoa Học (Tái Bản 2018)', N'Nguyễn Văn Tuấn', 169000, 0, 500, 500, N'Khoa học là một trong những di sản quí báu nhất của văn hóa nhân loại.'),
	(4, 51, N'NXB Dân Trí', '2022-01-01', N'Bách Khoa Tri Thức - Các Phát Minh Làm Nên Lịch Sử', N'Bramblekids, David Mostyn', 50000, 0, 500, 500, N'Ai đã phát minh ra những dụng cụ hữu ích và vật dụng thường ngày mà sự tồn tại của chúng với ta giờ thật hiển nhiên? '),
	(4, 52, N'NXB Thế Giới', '2024-01-01', N'Các Thế Giới Song Song', N'Michiokaku', 150000, 0, 500, 500, N'Dẫn chuyện lôi cuốn, kết hợp tường minh, sống động một lượng thông tin, đồ sộ để khai mở những giới hạn tột cùng của trí tưởng tượng, Kaku thực sự xứng đáng là "nhà truyền giáo" vĩ đại đã mang thế giới vật lý lý thuyết tới quảng đại quần chúng.'),
	(4, 53, N'NXB Thế Giới', '2023-01-01', N'Homo Deus - Lược Sử Tương Lai (Tái Bản 2023)', N'Yuval Noah Harari', 225000, 0, 500, 500, N'Homo sapiens có phải là một dạng sống siêu đẳng, hay chỉ là một tay đầu gấu địa phương?'),
	(4, 54, N'NXB Trẻ', '2023-01-01', N'Khoa Học Và Khám Phá - Cuộc Phiêu Lưu Cuối Cùng Của Feynman (Tái bản 2023)', N'Ralph Leighton', 140000, 8, 492, 500, N'Richard Feynman, một nhà vật lý vĩ đại, một người thầy tuyệt vời, người truyền cảm hứng, một kẻ tò mò, một tay trống, một kẻ phá két, một họa sĩ… dù với cách gọi nào thì cuộc đời của ông là những cuộc phiêu lưu, những trải nghiệm nối tiếp nhau, rất tự nhiên và cũng rất lôi cuốn.'),
	(4,55 , N'NXB Dân Trí', '2022-01-01', N'Bách Khoa Tri Thức - Khám Phá Cơ Thể Người', N'Bramblekids, David Mostyn', 50000, 0, 500, 500, N'Điều gì diễn ra bên trong các cơ quan khiến cơ thể chúng ta hoạt động, phát triển, duy trì sự sống và khỏe mạnh? Cuốn sách này giúp khám phá mọi bộ phận, cơ quan, cùng cách thức hoạt động của chúng.'),
	(4, 56, N'NXB Trẻ', '2022-01-01', N'Khoa Học Khám Phá - Lược Sử Thời Gian (Tái Bản 2022)', N'Stephen Hawking', 115000, 2, 498, 500, N'Tò mò là một trong những phẩm chất bẩm sinh vô cùng quan trọng của chúng ta, và những vấn đề như Bản chất của vũ trụ là gì? Vũ trụ từ đâu ra?'),
	(4, 57, N'NXB Dân Trí', '2023-01-01', N'Lược Sử Của Nhân Loại Về Cảm Xúc', N'Richard Firth-Godbehere', 199000, 0, 500, 500, N'Con người chúng ta thích coi bản thân là những sinh vật có lý trí, với tư cách là một loài đã dựa vào những tính toán và trí tuệ để tồn tại.'),
	(4, 58, N'NXB Dân Trí', '2021-01-01', N'Nguồn Gốc Các Loài', N'Miao Desui', 269000, 0, 500, 500, N'Cuốn sách “Nguồn gốc các loài” (trong bộ Tri thức kinh điển bằng tranh) dựa theo nguyên tác của Charles Darwin là một cuốn sách vô cùng hay và hiếm có.'),
	(4, 59, N'NXB Văn Học', '2023-01-01', N'Kể Chuyện Thiên Tài Nổi Tiếng - Alfred Nobel - Nhà Khoa Học Lừng Danh', N'Tuệ Minh', 36000, 0, 500, 500, N'Bộ sách “KỂ CHUYỆN THIÊN TÀI NỔI TIẾNG” giới thiệu các danh nhân như: Alfred Nobel, Edison, Victor Hugo, Leonardo Da Vinci, Albert Einstein, Beethoven, Newton, Hans Christian Andersen, Marie Curie, Lev Tolstoy…'),
	(4, 60, N'NXB Hồng Đức', '2018-01-01', N'Vũ Trụ Quan Của Albert Einstein Về Cuộc Sống Nghệ Thuật, Khoa Học Và Hoà Bình', N'Albert Einstein', 126000, 0, 500, 500, N'Đã đến lúc cần có ai đó đúc kết lại những diễn ngôn đầy cảm hứng của Albert Einstein vào trong một ấn phẩm.'),

	-- cổ tích -- 
	(5, 61, N'NXB Thanh Niên', '2023-01-01', N'Truyện Cổ Tích Kinh Điển - Cô Bé Quàng Khăn Đỏ', N'Mara Alperin, Loretta Schauer', 60000, 0, 500, 500, N'Khi Khăn Đỏ tới nhà bà ngoại, tên Sói to lớn xấu xa, lông lá đầy đáng sợ đã nằm đợi sẵn trên giường của bà...'),
	(5, 62, N'NXB Kim Đồng', '2023-01-01', N'Sự Tích Chú Cuội Cung Trăng', N'Phương Thúy, Trần Đắc Trung', 60000, 0, 500, 500, N'Chú Cuội là ai? Tại sao trên mặt trăng lại có chú Cuội? Xưa kia, chú Cuội làm gì v.v…? Cuốn sách này sẽ kể các em nghe sự tích chú Cuội cung trăng, và giải đáp tất cả những thắc mắc ấy!'),
	(5, 63, N'NXB Kim Đồng', '2022-01-01', N'Sự Tích Con Muỗi (Tái Bản 2022)', N'Phạm Ngọc Tân, Kim Ngọc', 20000, 0, 500, 500, N'Câu chuyện này kể với chúng ta sự tích về loài muỗi. Đồng thời, đây cũng là lời nhắc nhở về thói vong ân bội nghĩa. Vậy sự tích này như thế nào?'),
	(5, 64, N'NXB Trẻ', '2022-01-01', N'Cây Tre Trăm Đốt ', N'Nhiều tác giả', 15000, 0, 500, 500, N'"Cây tre trăm đốt" là câu chuyện sẽ giúp các bé thấy được ai sống hiền lành, thật thà, biết giúp đỡ mọi người xung quanh sẽ có được một cuộc sống hạnh phúc. Các bé hãy học tập anh nông dân chất phác trong câu chuyện này nhé!'),
	(5, 65, N'NXB Kim Đồng', '2021-01-01', N'Sự Tích Con Dã Tràng (Tái Bản 2021)', N'Phương Thúy, Toma Nguyễn', 20000, 0, 500, 500, N'Tại sao mỗi lần ra bờ biển, chúng mình lại thấy con dã tràng mải mê xe cát nhỉ? Cùng đọc truyện để tìm hiểu xem người xưa giải thích điều này như thế nào nhé!'),
	(5, 66, N'NXB Kim Đồng', '2022-01-01', N'Sự Tích Dưa Hấu (Tái Bản 2022)', N'Hiếu Minh, Cloud Pillow', 30000, 0, 500, 500, N'Dưa hấu là một thức quả quen thuộc với các bạn nhỏ phải không nào? Chúng mình cùng đọc sự tích về loại quả này nhé!'),
	(5, 67, N'NXB Mỹ Thuật', '2018-01-01', N' Sự Tích Hồ Ba Bể', N'Linh Nhi', 16000, 0, 500, 500, N'Từ thở ấu thơ, các em nhỏ đã được biết đến những câu chuyện cổ tích qua lời kể của bà. của mẹ.'),
	(5, 68, N'NXB Kim Đồng', '2021-01-01', N'Hồn Trương Ba Da Hàng Thịt', N'Lưu Quang Vũ', 60000, 0, 500, 500, N' Năm 2000, Lưu Quang Vũ được truy tặng Giải thưởng Hồ Chí Minh về Văn học nghệ thuật. Ông là tác giả trẻ tuổi nhất được trao giải thưởng cao quý này.'),
	(5, 69, N'NXB Kim Đồng', '2024-01-01', N'Sự Tích Ông Ba Mươi (Tái Bản 2024)', N'Kim Seung Hyun, Hồng Hà', 20000, 0, 500, 500, N'Chuyện kể rằng, Hổ vốn là một thiên tướng tài giỏi bậc nhất cõi Trời... Vì sao hổ lại có mặt ở trần gian? Vì sao người ta còn gọi hổ với cái tên là “Ông Ba Mươi’?'),
	(5, 70, N'NXB Phụ Nữ Việt Nam', '2023-01-01', N'Sọ Dừa', N'Búp Trên Cành, Kim Duẩn', 26000, 0, 500, 500, N'Từ tấm bé, thật vui vẻ và hạnh phúc làm sao khi chúng mình được nô đùa với giai điệu của những bài đồng dao, được nghĩ ngợi rồi bật cười khúc khích vì biết bao câu đố, lại còn được mê mải phiêu lưu trong miền cổ tích nữa chứ nhỉ…'),
	(5, 71, N'NXB Kim Đồng', '2022-01-01', N' Sơn Tinh - Thuỷ Tinh (Tái Bản 2022)', N'Hiếu Minh, Cloud Pillow', 20000, 0, 500, 500, N'Sơn Tinh - Thủy Tinh luôn là một truyền thuyết bất tử trong kho tàng dân gian Việt Nam. Hai vị thần đã cầu hôn nàng công chúa xinh đẹp như thế nào?'),
	(5, 72, N'NXB Kim Đồng', '2023-01-01', N'Tấm Cám', N'Mai Long, Vũ Ngọc Phan', 36000, 0, 500, 500, N'Vietnamese Folklore: The Story Of A Vietnamese Cinderella - Truyện Tấm Cám'),
	(5, 73, N'NXB Thanh Niên', '2022-01-01', N'Thánh Gióng (Song Ngữ Việt - Anh)', N'Thùy Dương', 16000, 0, 500, 500, N'Đặc biệt, sách được biên soạn dưới dạng song ngữ Việt - Anh, vừa giúp bé phát triển tiếng Việt, vừa giúp bé làm quen với tiếng Anh từ sớm, tạo tiền đề cho sự phát triển ngôn ngữ của trẻ về sau.'),
	(5, 74, N'NXB Mỹ Thuật', '2018-01-01', N'Cậu Bé Tích Chu', N'Linh Nhi', 16000, 0, 500, 500, N'Từ thở ấu thơ, các em nhỏ đã được biết đến những câu chuyện cổ tích qua lời kể của bà của mẹ.'),
	(5, 75, N'NXB Mỹ Thuật', '2020-01-01', N'Sự Tích Trầu Cau (Tái Bản 2020)', N'Nguyễn Mạnh Thái', 18000, 0, 500, 500, N'Hình ảnh tảng đá, cây cau, cây trầu trong Sự tích trầu cau luôn gần gũi, quấn quít, hoà hợp với nhau, đấy chính là biểu tượng sinh động của tình anh em tươi thắm, tình vợ chồng thuỷ chung, bền chặt. '),

	-- địa lý -- 
	(6, 76, N'NXB Thanh Niên', '2022-01-01', N'Atlas Thế Giới', N'Tomáš Tůma', 199000, 0, 500, 500, N'Các bạn nhỏ sẽ có một chuyến du hành khắp Trái Đất, từ cực Bắc tới cực Nam, từ lục địa Á-Âu sang châu Mỹ, từ sa mạc châu Phi sang châu Úc thú vị... nhờ chắp thêm “đôi cánh” kỳ diệu là tập sách kiêm bản đồ khổ lớn được gấp gọn đầy sáng tạo này.'),
	(6, 77, N'NXB Lao Động', '2020-01-01', N'Bản Đồ', N'Aleksandra Mizielińska, Daniel Mizieliński', 345000, 0, 500, 500, N'Phiên bản "Bản đồ" Việt Nam đặc biệt được tác giả vẽ riêng đất nước Việt Nam.'),
	(6, 78, N'NXB Tổng Hợp TP.HCM', '2023-01-01', N'Xoay Chuyển Tình Hình Biển Đông', N'James Borton', 168000, 0, 500, 500, N'Nói đến Biển Đông, chắc hẳn điều đầu tiên nhiều người sẽ nghĩ đến là tranh chấp chủ quyền “5 nước 6 bên” ngày càng được thế giới quan tâm trong những năm qua. '),
	(6, 79, N'NXB Dân Trí', '2020-01-01', N'1493: Diện Mạo Tân Thế Giới Của Columbus', N'Charles C Mann', 320000, 0, 500, 500, N'1493 – Diện mạo Tân thế giới của Columbus là cuốn sách xuất sắc nhất năm theo tạp chí TIME bình chọn; đồng thời là tác phẩm nổi bật của năm theo New York Times và Washington Post bình chọn.'),
	(6, 80, N'NXB Thanh Niên', '2019-01-01', N'Geography Encyclopedia - Bách Khoa Toàn Thư Về Địa Lý', N'Nhiều Tác Giả', 289000, 0, 500, 500, N'Geography Encyclopedia - Bách khoa toàn thư về Địa lý là một cuốn sách tuyệt vời để tìm hiểu về hành tinh Trái Đất cùng con người và các nền văn hóa từ gần 200 quốc gia khắp thế giới.'),
	(6, 81, N'NXB Trẻ', '2023-01-01', N'Kể Về Hải Đảo Của Chúng Ta', N'Vũ Phi Hoàng', 85000, 0, 500, 500, N'Trong vùng biển, nước ta lại có các đảo ven bờ, nhiều đảo và quần đảo xa bờ rất quan trọng như: quần đảo Hoàng Sa, quần đảo Trường Sa, quần đảo Thổ Chu, đảo Bạch Long Vĩ v.v… '),
	(6, 82, N'NXB Hà Nội', '2022-01-01', N'Bách Khoa Tri Thức Về Các Kỳ Quan Thế Giới - Kỳ Quan Tự Nhiên', N'Molly Oldfield, Federica Bordoni', 160000, 0, 200, 200, N'Nếu bạn chưa có điều kiện đặt chân trực tiếp đến những nơi ấy, vậy thì cuốn sách này chính là phương tiện tuyệt vời để đưa bạn đi thăm một số viện bảo tàng thú vị nhất trên thế giới.'),
	(6, 83, N'NXB Khoa Học Xã Hội', '2022-01-01', N'Lăng Gia Long', N'Léopold Michel Cadière', 249000, 0, 500, 500, N'Ấn phẩm thứ hai thuộc bộ sách “Huế kỳ bí” có tên “Lăng Gia Long” - tác giả là Linh mục Léopold Cadière, với phần thơ của Charles Patris.'),
	(6, 84, N'NXB Văn Hóa Văn Nghệ', '2012-01-01', N'Non Sông Nước Việt (Sách Ảnh)', N'Nguyễn Mạnh Đan', 770000, 0, 500, 500, N'“Non sông đất Việt” như một bản hòa tấu với nhiều cung bậc cảm xúc khác nhau về vẻ đẹp của quê hương được anh em trong giới nhiếp ảnh đánh giá cao.'),
	(6, 85, N'NXB Hội Nhà Văn', '2023-01-01', N'Những Tù Nhân Của Địa Lý', N'Tim Marshall', 210000, 0, 500, 500, N'Hay nói cách khác, theo luận điểm của Tim Marshall, thì một thế kỷ nữa kể từ bây giờ, nhân loại vẫn sẽ là “những tù nhân của địa lý”.'),
	(6, 86, N'NXB Trẻ', '2019-01-01', N'Tìm Hiểu Đất Hậu Giang & Lịch Sử Đất An Giang', N'Sơn Nam', 98000, 0, 500, 500, N'Hậu Giang là vùng đất hữu ngạn sông Tiền, nơi có đầy đủ cả văn minh miệt vườn và văn minh miệt thứ. Vùng đất đầy tiềm năng mới được khai phá nhiều từ cuối thế kỷ XIX và thế kỷ XX.'),
	(6, 87, N'NXB Trẻ', '2019-01-01', N'Vạch Một Chân Trời - Chim Quyên Xuống Đất', N'Sơn Nam', 120000, 0, 500, 500, N'NXB Trẻ tái bản Vạch Một Chân Trời – Chim Quyên Xuống Đất của tác giả Sơn Nam với mong muốn thông qua tác phẩm giúp bạn đọc hiểu thêm về đời sống của những người đi trước, của thế hệ trước đã tạo dựng nên một chân trời mới cho sự quần cư của người mở đất.'),
	(6, 88, N'NXB Hồng Đức', '2021-01-01', N'Địa Lý Toàn Thư Tân Biên (Tái Bản)', N'Trần Văn Hải', 245000, 0, 500, 500, N'ĐỊA LÝ TOÀN THƯ TÂN BIÊN cung cấp các lý giải thuật phong thủy dưới ánh sáng khoa học, mỗi đoạn đều có chú thích, bình giải giúp bạn đọc nắm được nền tảng cốt yếu của bộ môn này.'),
	(6, 89, N'NXB Khoa Học Xã Hội', '2020-01-01', N'Tứ Trấn Thăng Long Hà Nội', N'Nguyễn Doãn Minh', 259000, 0, 500, 500, N'“Tứ trấn Thăng Long” hay “Thăng Long Tứ trấn” là cụm từ thường dùng để chỉ bốn di tích, bốn ngôi đền linh thiêng, tiêu biểu trấn giữ bốn phương của kinh thành Thăng Long xưa.'),
	(6, 90, N'NXB Dân Trí', '2023-01-01', N'Việt Nam - Lãnh Thổ Và Các Vùng Địa Lý', N'GS Lê Bá Thảo', 260000, 0, 500, 500, N'Việt Nam nhìn trên bản đồ giống như hình chữ “S” rộng trên 330.900 km2, nằm ở rìa phía đông của bán đảo Đông Dương, tựa lưng vững chắc vào lục địa châu Á mênh mông về phía Tây-Bắc và nhìn ra Thái Bình Dương với chiều dài bờ biển trên 3000 km về phía Đông-Nam.');

--Chèn dữ liệu vào bảng Hinh
INSERT INTO Hinh (Hinh_main, Hinh_1, Hinh_2, Hinh_3, Hinh_4)
VALUES
	-- văn học
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\cdbt1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\cdbt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\cdbt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\cdbt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\cdbt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hanoi36pp1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hanoi36pp2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hanoi36pp3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hanoi36pp4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hanoi36pp5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hmt1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hmt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hmt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hmt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hmt5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hoangtube1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hoangtube2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hoangtube3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hoangtube4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hoangtube5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hvddb1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hvddb2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hvddb3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hvddb4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\hvddb5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\ldtb1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\ldtb2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\ldtb3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\ldtb4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\ldtb5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\luyhoa1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\luyhoa2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\luyhoa3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\luyhoa4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\luyhoa5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nktt1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nktt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nktt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nktt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nktt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nonuocnon1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nonuocnon2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nonuocnon3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nonuocnon4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\nonuocnon5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tatden1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tatden2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tatden3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tatden4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tatden5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tiengvong1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tiengvong2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tiengvong3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tiengvong4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tiengvong5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\trungso1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\trungso2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\trungso3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\trungso4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\trungso5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\truyenkieu1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\truyenkieu2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\truyenkieu3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\truyenkieu4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\truyenkieu5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tunhiensay1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tunhiensay2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tunhiensay3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tunhiensay4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\tunhiensay5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\vode1.webp', SINGLE_BLOB) AS Image), 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\vode2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\vode3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\vode4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\vanhoc\vode5.webp', SINGLE_BLOB) AS Image)
	),

	--tiểu thuyết -- 
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\beartown1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\beartown2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\beartown3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\beartown4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\beartown5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\bogia1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\bogia2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\bogia3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\bogia4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\bogia5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\caogiagaigia1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\caogiagaigia2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\caogiagaigia3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\caogiagaigia4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\caogiagaigia5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\chavacon1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\chavacon2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\chavacon3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\chavacon4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\chavacon5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\ckldtt1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\ckldtt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\ckldtt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\ckldtt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\ckldtt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hieusachcuoicungolondon1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hieusachcuoicungolondon2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hieusachcuoicungolondon3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hieusachcuoicungolondon4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hieusachcuoicungolondon5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hvvc1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hvvc2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hvvc3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hvvc4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\hvvc5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\keobuabao1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\keobuabao2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\keobuabao3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\keobuabao4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\keobuabao5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\khonggidinh1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\khonggidinh2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\khonggidinh3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\khonggidinh4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\khonggidinh5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nhagiakim1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nhagiakim2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nhagiakim3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nhagiakim4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nhagiakim5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nnll1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nnll2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nnll3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nnll4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\nnll5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\thuviennuadem1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\thuviennuadem2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\thuviennuadem3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\thuviennuadem4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\thuviennuadem5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\trnh1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\trnh2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\trnh3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\trnh4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\trnh5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\truongcaachilles1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\truongcaachilles2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\truongcaachilles3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\truongcaachilles4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\truongcaachilles5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\xanhxanhgoctroi1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\xanhxanhgoctroi2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\xanhxanhgoctroi3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\xanhxanhgoctroi4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\tieuthuyet\xanhxanhgoctroi5.webp', SINGLE_BLOB) AS Image)
	),
	
	-- lịch sử -- 
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\ctdvn1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\ctdvn2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\ctdvn3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\ctdvn4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\ctdvn5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dbp1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dbp2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dbp3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dbp4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dbp5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvsktt1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvsktt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvsktt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvsktt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvsktt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvtt1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvtt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvtt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvtt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\dvtt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\hlntt1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\hlntt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\hlntt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\hlntt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\hlntt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\htstcqn1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\htstcqn2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\htstcqn3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\htstcqn4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\htstcqn5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\kyhieu1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\kyhieu2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\kyhieu3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\kyhieu4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\kyhieu5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lichsusach1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lichsusach2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lichsusach3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lichsusach4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lichsusach5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lscd1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lscd2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lscd3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lscd4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lscd5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lstg1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lstg2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lstg3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lstg4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\lstg5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\namphuong1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\namphuong2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\namphuong3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\namphuong4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\namphuong5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\tntg1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\tntg2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\tntg3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\tntg4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\tntg5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\trientranhlichsu1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\trientranhlichsu2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\trientranhlichsu3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\trientranhlichsu4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\trientranhlichsu5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vnsl1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vnsl2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vnsl3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vnsl4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vnsl5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vts1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vts2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vts3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vts4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\lichsu\vts5.webp', SINGLE_BLOB) AS Image)
	),

	--khoa học --
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\30giay1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\30giay2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\30giay3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\30giay4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\30giay5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\anobelprize1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\anobelprize2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\anobelprize3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\anobelprize4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\anobelprize5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\atlascacloaichim1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\atlascacloaichim2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\atlascacloaichim3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\atlascacloaichim4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\atlascacloaichim5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\belekhoahoc1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\belekhoahoc2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\belekhoahoc3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\belekhoahoc4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\belekhoahoc5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cckh1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cckh2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cckh3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cckh4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cckh5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cpmlnls1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cpmlnls2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cpmlnls3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cpmlnls4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\cpmlnls5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ctgss1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ctgss2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ctgss3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ctgss4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ctgss5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\homodeus1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\homodeus2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\homodeus3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\homodeus4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\homodeus5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\khoahocvakhampha1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\khoahocvakhampha2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\khoahocvakhampha3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\khoahocvakhampha4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\khoahocvakhampha5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\kpctn1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\kpctn2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\kpctn3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\kpctn4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\kpctn5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lichsuthoigian1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lichsuthoigian2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lichsuthoigian3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lichsuthoigian4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lichsuthoigian5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lscnlvcx1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lscnlvcx2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lscnlvcx3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lscnlvcx4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\lscnlvcx5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ngccl1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ngccl2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ngccl3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ngccl4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\ngccl5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\nobel1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\nobel2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\nobel3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\nobel4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\nobel5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\vutruquan1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\vutruquan2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\vutruquan3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\vutruquan4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\khoahoc\vutruquan5.webp', SINGLE_BLOB) AS Image)
	),

	-- cổ tích -- 
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cbqkd1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cbqkd2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cbqkd3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cbqkd4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cbqkd5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\chucuoi1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\chucuoi2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\chucuoi3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\chucuoi4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\chucuoi5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\conmui1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\conmui2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\conmui3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\conmui4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\conmui5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cttd1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cttd2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cttd3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cttd4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\cttd5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\datrang1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\datrang2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\datrang3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\datrang4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\datrang5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\duahau1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\duahau2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\duahau3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\duahau4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\duahau5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\hobabe1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\hobabe2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\hobabe3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\hobabe4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\hobabe5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\htbdht1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\htbdht2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\htbdht3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\htbdht4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\htbdht5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\ongbamuoi1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\ongbamuoi2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\ongbamuoi3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\ongbamuoi4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\ongbamuoi5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sodua1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sodua2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sodua3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sodua4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sodua5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sttt1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sttt2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sttt3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sttt4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\sttt5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tamcam1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tamcam2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tamcam3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tamcam4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tamcam5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\thanhgiong1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\thanhgiong2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\thanhgiong3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\thanhgiong4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\thanhgiong5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tichchu1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tichchu2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tichchu3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tichchu4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\tichchu5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\traucau1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\traucau2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\traucau3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\traucau4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\cotich\traucau5.webp', SINGLE_BLOB) AS Image)
	),

	-- địa lý--
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\atg1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\atg2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\atg3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\atg4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\atg5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\bando1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\bando2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\bando3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\bando4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\bando5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\biendong1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\biendong2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\biendong3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\biendong4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\biendong5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\columbus1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\columbus2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\columbus3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\columbus4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\columbus5.webp', SINGLE_BLOB) AS Image)
	),
	( 
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ge1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ge2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ge3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ge4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ge5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\haidao1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\haidao2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\haidao3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\haidao4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\haidao5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\kqtg1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\kqtg2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\kqtg3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\kqtg4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\kqtg5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\lgl1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\lgl2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\lgl3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\lgl4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\lgl5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\nsnv1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\nsnv2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\nsnv3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\nsnv4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\nsnv5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ntncdl1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ntncdl2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ntncdl3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ntncdl4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\ntncdl5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\snhg1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\snhg2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\snhg3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\snhg4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\snhg5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\sonnam1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\sonnam2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\sonnam3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\sonnam4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\sonnam5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tanbien1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tanbien2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tanbien3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tanbien4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tanbien5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tutran1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tutran2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tutran3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tutran4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\tutran5.webp', SINGLE_BLOB) AS Image)
	),
	(
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\vn1.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\vn2.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\vn3.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\vn4.webp', SINGLE_BLOB) AS Image),
	(SELECT BulkColumn FROM OPENROWSET(BULK 'D:\School\Hinhanh\dialy\vn5.webp', SINGLE_BLOB) AS Image)
	);


INSERT INTO Thanh_Toan (ID_nguoi_dung ,ID_san_pham ,Ngay_dat_hang,Tong_tien ,Phuong_thuc_thanh_toan, So_luong )
VALUES
	(3, 5, '2023-9-25', 495000, 'cod', 5),
	(3, 6, '2023-9-25', 1316000, 'cod', 7),
	(3, 14, '2023-9-27', 364000, 'cod', 7),
	(4, 56, '2023-9-30', 230000, 'cod', 2),
	(4, 28, '2024-1-30', 560000, 'cod', 4),
	(4, 31, '2024-2-12', 360000, 'cod', 3),
	(5, 39, '2024-3-21', 2250000, 'cod', 5),
	(5, 40, '2024-4-13', 1016000, 'cod', 4),
	(5, 32, '2024-5-30', 180000, 'cod', 2),
	(6, 45, '2024-6-16', 240000, 'cod', 8),
	(6, 54, '2024-7-1', 1120000, 'cod', 8);
	
INSERT INTO	Thong_Ke (ID_thanh_toan, tong_doanh_thu)
VALUES 
	(1, 495000),
	(2, 1316000),
	(3, 364000),
	(4, 230000),
	(5, 560000),
	(6, 360000),
	(7, 2250000),
	(8, 1016000),
	(9, 180000),
	(10, 240000),
	(11, 1120000);