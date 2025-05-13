package com.dan.datn.Service;

import com.dan.datn.Entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    boolean validateUser(String ten, String matKhau);
    boolean validateAdmin(String ten, String matKhau);
    boolean isEmailExist(String email);
    boolean istenExist(String ten);
    boolean isPhoneExist(String sdt);
    void saveUser(User user);
    void saveAdmin(User user);
    Optional<User> getUserByTen(String ten);
    List<User> getAllNguoiDung();

    Optional<User> getUserById(Long id);
    boolean deleteNguoiDung(Long id);

    // Thêm phương thức để lấy tất cả admin
    List<User> getAllAdmins(); // Lấy tất cả người dùng có role = 0 (admin)
    boolean updatePassword(String username, String oldPassword, String newPassword, String confirmPassword);
}
