package com.dan.datn.API;

import com.dan.datn.Entity.SanPham;
import com.dan.datn.Repository.SanPhamRepository;
import com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/sanpham")
public class SanPhamAPI {

    // Autowired service
    @Autowired
    private SanPhamServiceImpl sanPhamService;

    // Lấy tất cả sản phẩm
    @GetMapping
    public ResponseEntity<List<SanPham>> getAllSanPham() {
        List<SanPham> sanPhams = sanPhamService.getAllSanPham();
        return new ResponseEntity<>(sanPhams, HttpStatus.OK);
    }

    // Lấy sản phẩm theo ID
    @GetMapping("/{id}")
    public ResponseEntity<SanPham> getSanPhamById(@PathVariable Long id) {
        try {
            SanPham sanPham = sanPhamService.getSanPhamById(id);
            return new ResponseEntity<>(sanPham, HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Lấy sản phẩm ngẫu nhiên (limit)
//    @GetMapping("/random")
//    public ResponseEntity<List<SanPham>> getRandomSanPham(@RequestParam int limit) {
//        List<SanPham> sanPhams = sanPhamService.getSanPhamSanPham(limit);
//        return new ResponseEntity<>(sanPhams, HttpStatus.OK);
//    }

    // Tìm kiếm sản phẩm theo từ khóa
//    @GetMapping("/search")
//    public ResponseEntity<List<SanPham>> searchSanPham(@RequestParam String keyword) {
//        List<SanPham> sanPhams = sanPhamService.searchAllFields(keyword);
//        return new ResponseEntity<>(sanPhams, HttpStatus.OK);
//    }

    // Gợi ý sản phẩm (theo từ khóa)
//    @GetMapping("/suggestions")
//    public ResponseEntity<List<String>> getSuggestions(@RequestParam String keyword) {
//        List<String> suggestions = sanPhamService.findSuggestions(keyword);
//        return new ResponseEntity<>(suggestions, HttpStatus.OK);
//    }

    // Lấy sản phẩm theo thể loại và ID ngoại trừ
//    @GetMapping("/theloai")
//    public ResponseEntity<List<SanPham>> getSanPhamByTheLoai(@RequestParam Long theLoaiId, @RequestParam Long excludeId) {
//        List<SanPham> sanPhams = sanPhamService.findByTheLoai(theLoaiId, excludeId);
//        return new ResponseEntity<>(sanPhams, HttpStatus.OK);
//    }
}
