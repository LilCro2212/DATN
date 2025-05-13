package com.dan.datn.Controller;

import com.dan.datn.Entity.SanPham;
import com.dan.datn.Entity.ThanhToan;
import com.dan.datn.Service.DonHangCuaToiService;
import com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.List;

@SessionAttributes("username")
@Controller
public class DonHangCuaToiController {

    private final DonHangCuaToiService donHangCuaToiService;

    @Autowired
    private HttpSession session;
    @Autowired
    private SanPhamServiceImpl sanPhamServiceImpl;

    public DonHangCuaToiController(DonHangCuaToiService donHangCuaToiService) {
        this.donHangCuaToiService = donHangCuaToiService;
    }

    // Lấy danh sách đơn hàng theo username trong session
    @GetMapping("/donhangcuatoi")
    public String getThanhToanByTenFromSession(Model model) {
        // Lấy tên người dùng từ session
        String username = (String) session.getAttribute("username");

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập giỏ hàng.");
            return "index/dangNhap"; // Trả về trang đăng nhập nếu chưa đăng nhập
        }

        // Lấy danh sách đơn hàng của người dùng theo tên
        List<ThanhToan> thanhToans = donHangCuaToiService.getThanhToanByTen(username);
        if (thanhToans.isEmpty()) {
            model.addAttribute("message", "Bạn chưa có đơn hàng nào.");
        } else {
            model.addAttribute("donhangcuatoi", thanhToans);  // Truyền danh sách đơn hàng vào model với tên 'donhangcuatoi'
        }

        // Thêm tên người dùng vào model để hiển thị trên trang
        model.addAttribute("username", username);

        // Trả về view danh sách đơn hàng
        return "layout/Donhangcuatoi";
    }


    @GetMapping("/{productId}")
    public String xemSanPham(@PathVariable("productId") Long productId, Model model) {
        // Thực hiện logic để lấy thông tin sản phẩm từ cơ sở dữ liệu
        SanPham sanPham = sanPhamServiceImpl.getSanPhamById(productId);

        // Thêm sản phẩm vào Model để hiển thị trên trang
        model.addAttribute("sanPham", sanPham);

        // Trả về view chi tiết sản phẩm
        return "redirect:/sanpham/" + productId; // Tên tệp HTML của bạn
    }
}
