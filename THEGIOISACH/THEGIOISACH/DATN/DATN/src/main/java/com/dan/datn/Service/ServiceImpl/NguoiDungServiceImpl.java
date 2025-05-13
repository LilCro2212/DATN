package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Service.NguoiDungService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class NguoiDungServiceImpl implements NguoiDungService {
    private final Map<String, String> resetTokenStore = new HashMap<>();

    @Override
    public boolean existsByEmail(String email) {
        // Thay bằng truy vấn cơ sở dữ liệu thực tế
        return "test@example.com".equals(email);
    }

    @Override
    public void savePasswordResetToken(String email, String token) {
        resetTokenStore.put(token, email);
    }

    @Override
    public String getEmailByResetToken(String token) {
        return resetTokenStore.get(token);
    }

    @Override
    public void updatePassword(String email, String newPassword) {
        // Thay bằng logic cập nhật mật khẩu vào cơ sở dữ liệu
        System.out.println("Đã cập nhật mật khẩu mới cho email: " + email);
    }

    @Override
    public void deleteResetToken(String token) {
        resetTokenStore.remove(token);
    }
}
