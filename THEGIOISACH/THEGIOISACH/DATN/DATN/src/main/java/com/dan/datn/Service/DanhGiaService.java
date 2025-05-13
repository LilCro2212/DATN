package com.dan.datn.Service;

import com.dan.datn.Entity.DanhGia;
import com.dan.datn.Entity.SanPham;

import java.util.List;

public interface DanhGiaService {
    List<DanhGia> getDanhGiaBySanPham(SanPham sanPham);
    void save(DanhGia danhGia);
}