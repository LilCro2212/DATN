package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.ThanhToan;
import com.dan.datn.Repository.DonHangCuaToiRepository;
import com.dan.datn.Service.DonHangCuaToiService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DonHangCuaToiServiceImpl implements DonHangCuaToiService {

    private final DonHangCuaToiRepository donHangCuaToiRepository;

    // Constructor Injection
    public DonHangCuaToiServiceImpl(DonHangCuaToiRepository donHangCuaToiRepository) {
        this.donHangCuaToiRepository = donHangCuaToiRepository;
    }

    @Override
    public List<ThanhToan> getAllThanhToan() {
        return donHangCuaToiRepository.findAll(); // Trả về tất cả đơn hàng
    }

    @Override
    public List<ThanhToan> getThanhToanByTen(String username) {
        return donHangCuaToiRepository.findByUser_Ten(username); // Lấy đơn hàng theo tên người dùng
    }

    @Override
    public List<ThanhToan> getThanhToanBySanPhamId(Long ID_san_pham) {
        return donHangCuaToiRepository.findBySanPhamId(ID_san_pham); // Lấy đơn hàng theo ID sản phẩm
    }
}
