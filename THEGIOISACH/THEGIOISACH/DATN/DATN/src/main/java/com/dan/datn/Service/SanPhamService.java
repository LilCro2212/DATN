package com.dan.datn.Service;

import com.dan.datn.Entity.SanPham;

import java.util.List;

public interface SanPhamService {

    // Lấy danh sách tất cả sản phẩm
    List<SanPham> getAllSanPham();

    // Lấy sản phẩm theo ID
    SanPham getSanPhamById(Long id);

    // Lưu sản phẩm
    SanPham saveSanPham(SanPham sanPham);

    boolean deleteProductById(Long id);

}
