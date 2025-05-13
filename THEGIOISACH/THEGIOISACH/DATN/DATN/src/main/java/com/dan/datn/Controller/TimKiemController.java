package com.dan.datn.Controller;

import com.dan.datn.Entity.SanPham;
import com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Base64;
import java.util.List;

@Controller
public class TimKiemController {

    @Autowired
    private SanPhamServiceImpl sanPhamServiceImpl;
    @Autowired
    private HttpSession httpSession;

    //Chức năng tìm kiếm
    @GetMapping("/search")
    public String searchSanPham(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "theLoai", required = false) String theLoai,
            Model model) {

        List<SanPham> sanPhams;

        if (theLoai != null && !theLoai.isEmpty()) {
            sanPhams = sanPhamServiceImpl.getSanPhamsByTheLoai(theLoai);
        } else if (keyword != null && !keyword.isEmpty()) {
            sanPhams = sanPhamServiceImpl.searchAllFields(keyword);
        } else {
            sanPhams = sanPhamServiceImpl.getAllSanPham();

        }
        for (SanPham sp : sanPhams) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }

        model.addAttribute("sanPhams", sanPhams);
//        String username = (String) httpSession.getAttribute("username");
//        model.addAttribute("username", username);

        return "index/sanPhamSauTimKiem"; // Trang hiển thị kết quả
    }

    @GetMapping("/suggestions")
    @ResponseBody
    public List<String> getSuggestions(@RequestParam("keyword") String keyword) {
        return sanPhamServiceImpl.findSuggestions(keyword);
    }

    //Lọc theo thể loại
    @GetMapping("/filter")
    public String locSanPham(@RequestParam("theLoai") String theLoai, Model model) {
        List<SanPham> sanPhams = sanPhamServiceImpl.getSanPhamsByTheLoai(theLoai);

        // Kiểm tra xem sanPhams có dữ liệu không
        if (sanPhams.isEmpty()) {
            model.addAttribute("message", "Không có sản phẩm trong thể loại này.");
        }

        for (SanPham sp : sanPhams) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }

        model.addAttribute("sanPhams", sanPhams);
//        String username = (String) httpSession.getAttribute("username");
//        model.addAttribute("username", username);

        return "index/sanPhamSauTimKiem"; // Trả về trang hiển thị kết quả
    }

    //Lọc theo giá
    @GetMapping("/filterByPrice")
    public String filterSanPhamByPrice(
            @RequestParam("minPrice") Integer minPrice,
            @RequestParam("maxPrice") Integer maxPrice,
            Model model) {

        List<SanPham> sanPhams = sanPhamServiceImpl.getSanPhamsByPriceRange(minPrice, maxPrice);

        if (sanPhams.isEmpty()) {
            model.addAttribute("message", "Không tìm thấy sản phẩm trong khoảng giá này.");
        }

        for (SanPham sp : sanPhams) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }

        model.addAttribute("sanPhams", sanPhams);
//        String username = (String) httpSession.getAttribute("username");
//        model.addAttribute("username", username);

        return "index/sanPhamSauTimKiem"; // Trả về trang hiển thị kết quả
    }



}
