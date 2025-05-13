package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.User;
import com.dan.datn.Repository.MatKhauRepository;
import com.dan.datn.Service.MatKhauService;
import com.dan.datn.Service.VerificationCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MatKhauServiceImpl implements MatKhauService {

    @Autowired
    private MatKhauRepository matKhauRepository;

    @Autowired
    private EmailMaXacNhanService emailService;

    @Autowired
    private VerificationCodeService verificationCodeService;

    @Override
    public boolean kienTraEmail(String email) {
        Optional<User> user = matKhauRepository.findByEmail(email);
        return user.isPresent();
    }

    @Override
    public String guiMaXacNhan(String email) {
        if (!kienTraEmail(email)) {
            return null;
        }

        // Tạo mã xác nhận ngẫu nhiên
        String verificationCode = generateVerificationCode();

        // Gửi email với mã xác nhận
        emailService.sendEmail(email, "Mã xác nhận quên mật khẩu", "Mã xác nhận của bạn là: " + verificationCode);

        // Lưu mã xác nhận vào bộ nhớ tạm thời
        verificationCodeService.sendVerificationCode(email, verificationCode);

        return verificationCode;
    }

    @Override
    public boolean datLaiMatKhau(String email, String matKhauMoi, String maXacNhan) {
        Optional<User> userOptional = matKhauRepository.findByEmail(email);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setMat_khau(matKhauMoi);
            matKhauRepository.save(user);
            return true;
        }
        return false;
    }

    private String generateVerificationCode() {
        return String.valueOf((int) (Math.random() * 900000) + 100000);  // Mã xác nhận dài 6 ký tự ngẫu nhiên
    }
}
