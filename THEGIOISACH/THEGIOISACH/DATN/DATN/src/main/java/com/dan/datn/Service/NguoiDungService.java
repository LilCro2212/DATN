package com.dan.datn.Service;

import org.springframework.stereotype.Service;

@Service
public interface NguoiDungService {
    boolean existsByEmail(String email);
    void savePasswordResetToken(String email, String token);
    String getEmailByResetToken(String token);
    void updatePassword(String email, String newPassword);
    void deleteResetToken(String token);
}
