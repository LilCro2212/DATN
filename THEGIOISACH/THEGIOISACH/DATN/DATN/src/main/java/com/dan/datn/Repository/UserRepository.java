package com.dan.datn.Repository;

import com.dan.datn.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByTen(String ten);
    boolean existsByEmail(String email);
    boolean existsBySDT(String sdt);
    boolean existsByten(String ten); // Đổi tên phương thức cho khớp với Entity
    Optional<User> findByEmail(String email);// tìm admin bằng email
    List<User> findByRole(int role);

}