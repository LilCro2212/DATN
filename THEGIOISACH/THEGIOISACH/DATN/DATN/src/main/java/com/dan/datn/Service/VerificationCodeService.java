package com.dan.datn.Service;

public interface VerificationCodeService {
    boolean verifyCode(String email, String maXacNhan); // Kiểm tra mã xác nhận
    void sendVerificationCode(String email, String verificationCode); // Gửi mã xác nhận
}

