package com.dan.datn.Service;

import com.dan.datn.Entity.ThanhToan;

import java.util.List;

public interface DonHangCuaToiService {
    // Lấy tất cả thanh toán
    List<ThanhToan> getAllThanhToan();

    // Lấy thanh toán theo ID sản phẩm
    List<ThanhToan> getThanhToanBySanPhamId(Long ID_san_pham);

    // Lấy danh sách thanh toán theo tên người dùng từ session
    List<ThanhToan> getThanhToanByTen(String username);
}
