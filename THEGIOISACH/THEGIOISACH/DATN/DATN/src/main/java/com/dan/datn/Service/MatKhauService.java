package com.dan.datn.Service;

public interface MatKhauService {

    boolean kienTraEmail(String email);  // Kiểm tra xem email có tồn tại trong hệ thống không

    String guiMaXacNhan(String email);  // Gửi mã xác nhận
    // Đặt lại mật khẩu
    boolean datLaiMatKhau(String email, String matKhauMoi, String maXacNhan);
}
