package com.dan.datn.Repository;

import com.dan.datn.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MatKhauRepository extends JpaRepository<User, Long> {

    // Lấy một dòng duy nhất bằng email
    Optional<User> findByEmail(String email);

    // Cập nhật mật khẩu
//    @Modifying
//    @Transactional
//    @Query("UPDATE User u SET u.Mat_khau = :newPassword WHERE u.email = :email")
//    void updatePasswordByEmail(@Param("email") String email, @Param("newPassword") String newPassword);
}
