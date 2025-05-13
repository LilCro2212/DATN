package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.SanPham;
import com.dan.datn.Repository.SanPhamRepository;
import com.dan.datn.Service.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SanPhamServicesImpl implements SanPhamService {
    private final SanPhamRepository sanPhamRepository;

    @Autowired
    public SanPhamServicesImpl(SanPhamRepository sanPhamRepository) {
        this.sanPhamRepository = sanPhamRepository;
    }

    // Lấy danh sách tất cả sản phẩm
    @Override
    public List<SanPham> getAllSanPham() {
        List<SanPham> sanPhams = sanPhamRepository.findAll();
        System.out.println("Danh sách sản phẩm: " + sanPhams);
        return sanPhamRepository.findAll();
    }

    // Lấy sản phẩm theo ID
    @Override
    public SanPham getSanPhamById(Long id) {
        Optional<SanPham> sanPham = sanPhamRepository.findById(id);
        if (sanPham.isPresent()) {
            return sanPham.get();
        } else {
            throw new IllegalArgumentException("Sản phẩm không tồn tại với ID: " + id);
        }
    }

    // Lưu sản phẩm
    @Override
    public SanPham saveSanPham(SanPham sanPham) {
        return sanPhamRepository.save(sanPham);
    }

    @Override
    public boolean deleteProductById(Long id) {
        Optional<SanPham> product = sanPhamRepository.findById(id);
        if (product.isPresent()) {
            sanPhamRepository.delete(product.get());
            return true;  // Deletion successful
        }
        return false;  // Product not found, deletion failed
    }
}
