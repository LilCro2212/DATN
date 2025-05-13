package com.dan.datn.Repository;

import com.dan.datn.Entity.Hinh;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface HinhRepository extends JpaRepository<Hinh, Long> {

    // Phương thức tìm Hình bằng ID (JpaRepository đã cung cấp phương thức này rồi)
    Optional<Hinh> findById(Long id);

    // Bạn có thể thêm các truy vấn tuỳ chỉnh ở đây nếu cần
}