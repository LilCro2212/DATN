package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.User;
import com.dan.datn.Repository.UserRepository;
import com.dan.datn.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public boolean validateUser(String ten, String matKhau) {
        Optional<User> userOptional = userRepository.findByTen(ten);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getRole() == 1 && user.getMat_khau().equals(matKhau)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean validateAdmin(String ten, String matKhau) {
        Optional<User> userOptional = userRepository.findByTen(ten);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getRole() == 0 && user.getMat_khau().equals(matKhau)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean isEmailExist(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public boolean istenExist(String ten) {
        return userRepository.existsByten(ten);
    }

    @Override
    public boolean isPhoneExist(String sdt) {
        return userRepository.existsBySDT(sdt); // Gọi đúng phương thức
    }


    @Override
    public void saveUser(User user) {
        user.setRole(1); // Đặt role mặc định là 1
        userRepository.save(user);
    }

    @Override
    public void saveAdmin(User user) {
        user.setRole(0); // Đặt role mặc định là 0
        userRepository.save(user);
    }

    @Override
    public Optional<User> getUserByTen(String ten) {
        return userRepository.findByTen(ten);
    }

    @Override
    public List<User> getAllNguoiDung() {
        return userRepository.findAll();
    }

    // Phương thức lấy người dùng theo ID
    @Override
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    // Phương thức xóa người dùng
    @Override
    public boolean deleteNguoiDung(Long id) {
        if (userRepository.existsById(id)) {
            userRepository.deleteById(id);
            return true;
        }
        return false;
    }

    // Thêm lại phương thức getAllAdmins để lấy tất cả người dùng có role = 0 (admin)
    @Override
    public List<User> getAllAdmins() {
        return userRepository.findByRole(0); // Lấy tất cả tài khoản có role = 0 (admin)
    }
    @Override
    public boolean updatePassword(String username, String oldPassword, String newPassword, String confirmPassword) {
        Optional<User> userOptional = userRepository.findByTen(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            // Kiểm tra mật khẩu cũ có đúng không
            if (!user.getMat_khau().equals(oldPassword)) {
                return false; // Mật khẩu cũ không đúng
            }

            // Kiểm tra mật khẩu mới và xác nhận mật khẩu có trùng khớp không
            if (!newPassword.equals(confirmPassword)) {
                return false; // Mật khẩu mới và xác nhận mật khẩu không trùng nhau
            }

            // Cập nhật mật khẩu mới
            user.setMat_khau(newPassword);
            userRepository.save(user); // Lưu thông tin người dùng sau khi cập nhật
            return true; // Cập nhật thành công
        }

        return false; // Người dùng không tồn tại
    }
}
