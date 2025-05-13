package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Service.VerificationCodeService;
import org.springframework.stereotype.Service;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

@Service
public class VerificationCodeServiceImpl implements VerificationCodeService {

    private ConcurrentHashMap<String, String> verificationCodes = new ConcurrentHashMap<>();
    private ConcurrentHashMap<String, Long> verificationCodeExpiry = new ConcurrentHashMap<>();

    private static final long EXPIRATION_TIME = TimeUnit.MINUTES.toMillis(5); // Mã xác nhận hết hạn sau 5 phút

    @Override
    public void sendVerificationCode(String email, String verificationCode) {
        verificationCodes.put(email, verificationCode);
        verificationCodeExpiry.put(email, System.currentTimeMillis() + EXPIRATION_TIME);
    }

    @Override
    public boolean verifyCode(String email, String verificationCode) {
        String storedCode = verificationCodes.get(email);
        Long expiryTime = verificationCodeExpiry.get(email);

        // Debug in ra mã xác nhận
        System.out.println("Stored code: " + storedCode);
        System.out.println("Entered code: " + verificationCode);

        // Kiểm tra mã và thời gian hết hạn
        if (storedCode != null && storedCode.equals(verificationCode) && System.currentTimeMillis() < expiryTime) {
            return true;
        }

        // Nếu mã không hợp lệ hoặc hết hạn, xóa mã
        verificationCodes.remove(email);
        verificationCodeExpiry.remove(email);
        return false;
    }
}
