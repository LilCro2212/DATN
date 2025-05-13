package com.dan.datn.Repository;

import com.dan.datn.Entity.ThanhToan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonHangCuaToiRepository extends JpaRepository<ThanhToan, Long> {

    // Tìm danh sách thanh toán theo tên người dùng
    List<ThanhToan> findByUser_Ten(String username);

    // Tìm thanh toán theo ID sản phẩm
    @Query("SELECT t FROM ThanhToan t WHERE t.sanPham.ID_san_pham = :ID_san_pham")
    List<ThanhToan> findBySanPhamId(@Param("ID_san_pham") Long ID_san_pham); // Đổi tên thành 'findBySanPham_ID_san_pham'
}
