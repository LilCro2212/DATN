package com.dan.datn.Controller;

import com.dan.datn.Entity.DanhGia;
import com.dan.datn.Entity.Hinh;
import com.dan.datn.Entity.SanPham;
import com.dan.datn.Entity.User;
import com.dan.datn.Service.DanhGiaService;
import com.dan.datn.Service.ServiceImpl.DanhGiaServiceImpl;
import com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import static com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl.sanPhamRepository;

@Controller
@RequestMapping("/sanpham")
public class ChiTietSanPhamController {
    @Autowired
    private SanPhamServiceImpl sanPhamServiceImpl;
    @Autowired
    private HttpSession session;
    @Autowired
    private UserServiceImpl userServiceImpl;
    @Autowired
    private DanhGiaServiceImpl danhGiaServiceImpl;
    @Autowired
    private DanhGiaService danhGiaService;
    @GetMapping("/{id}")
    public String viewProductDetails(@PathVariable("id") Long id, Model model) {
        SanPham sanpham = sanPhamRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Sản phẩm không tồn tại với ID: " + id));
        session.setAttribute("sanpham", sanpham);  // Lưu sản phẩm vào session
        model.addAttribute("sanpham", sanpham);
// Lấy trung bình số sao
        Double averageRating = danhGiaServiceImpl.getAverageRating(sanpham);
        model.addAttribute("averageRating", averageRating);
        // Kiểm tra sản phẩm có hình ảnh không và chuyển các     hình ảnh thành base64
        if (sanpham.getHinh() != null) {
            Hinh hinh = sanpham.getHinh();

            // Chuyển đổi hình ảnh sang Base64
            String base64MainImage = Base64.getEncoder().encodeToString(hinh.getHinhMain());
            sanpham.getHinh().setBase64Image(base64MainImage);

            // Chuyển đổi các hình thu nhỏ sang base64
            String base64Image1 = Base64.getEncoder().encodeToString(hinh.getHinh1());
            String base64Image2 = Base64.getEncoder().encodeToString(hinh.getHinh2());
            String base64Image3 = Base64.getEncoder().encodeToString(hinh.getHinh3());
            String base64Image4 = Base64.getEncoder().encodeToString(hinh.getHinh4());

            model.addAttribute("base64Image1", base64Image1);
            model.addAttribute("base64Image2", base64Image2);
            model.addAttribute("base64Image3", base64Image3);
            model.addAttribute("base64Image4", base64Image4);
        }
        // Lấy username từ session
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username != null){
            System.out.println("Tên người dùng: " + username);
        }

        // Lấy danh sách các sản phẩm liên quan có cùng thể loại (trừ sản phẩm hiện tại)
        List<SanPham> sanPhamLienQuan = sanPhamServiceImpl.getRandomProducts();
        for (SanPham sp : sanPhamLienQuan) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }
        model.addAttribute("sanPhamLienQuan", sanPhamLienQuan);

        // Lấy danh sách đánh giá của sản phẩm
        List<DanhGia> danhGiaList = danhGiaServiceImpl.getDanhGiaBySanPham(sanpham);
        model.addAttribute("danhGiaList", danhGiaList);
        String successMessage = (String) session.getAttribute("success");
        String errorMessage = (String) session.getAttribute("error");
        if (successMessage != null) {
            model.addAttribute("success", successMessage);
            session.removeAttribute("success"); // Xóa khỏi session
        }

        if (errorMessage != null) {
            model.addAttribute("error", errorMessage);
            session.removeAttribute("error"); // Xóa khỏi session
        }

        if (successMessage != null) {
            model.addAttribute("success", successMessage);
            session.removeAttribute("success"); // Xóa khỏi session
        }

        if (errorMessage != null) {
            model.addAttribute("error", errorMessage);
            session.removeAttribute("error"); // Xóa khỏi session
        }
        return "index/chiTietSanPham";  // Chuyển hướng đến trang chi tiết sản phẩm
    }

    @PostMapping("/{id}/danhgia")
    public String submitReview(@PathVariable("id") Long sanPhamId,
                               @RequestParam(value = "danhGia", required = false) Integer danhGia,
                               @RequestParam(value = "binhLuan", required = false) String binhLuan,
                               HttpSession session,
                               Model model,
                               RedirectAttributes redirectAttributes) { // Sử dụng RedirectAttributes
        // Kiểm tra người dùng đã đăng nhập hay chưa
        String ten = (String) session.getAttribute("username");
        if (ten == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần đăng nhập để đánh giá.");
            return "redirect:/dangnhap"; // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
        }

        // Kiểm tra các tham số đầu vào
        if (danhGia == null && (binhLuan == null || binhLuan.isEmpty())) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần cung cấp đánh giá và bình luận.");
            return "redirect:/sanpham/" + sanPhamId; // Quay lại trang chi tiết sản phẩm
        }
        if (danhGia == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần cung cấp đánh giá.");
            return "redirect:/sanpham/" + sanPhamId; // Quay lại trang chi tiết sản phẩm
        }
        if (binhLuan == null || binhLuan.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Bạn cần cung cấp bình luận.");
            return "redirect:/sanpham/" + sanPhamId; // Quay lại trang chi tiết sản phẩm
        }

        try {
            // Lấy thông tin người dùng
            Optional<User> optionalUser = userServiceImpl.getUserByTen(ten);
            if (!optionalUser.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng.");
                return "redirect:/index/dangNhap";
            }
            User user = optionalUser.get();

            // Lấy thông tin sản phẩm
            SanPham sanPham = null;
            try {
                sanPham = sanPhamServiceImpl.getSanPhamById(sanPhamId);
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm có ID: " + sanPhamId);
                return "redirect:/error";
            }

            if (sanPham == null) {
                redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại.");
                return "redirect:/error";
            }

            // Tạo đối tượng đánh giá mới
            DanhGia danhGiaMoi = new DanhGia();
            danhGiaMoi.setUser(user);
            danhGiaMoi.setSanPham(sanPham);
            danhGiaMoi.setDanhGia(danhGia);
            danhGiaMoi.setBinhLuan(binhLuan);
            danhGiaMoi.setNgayDanhGia(new Date());

            try {
                // Lưu đánh giá
                danhGiaService.save(danhGiaMoi);
                if (danhGiaMoi == null) {
                    throw new Exception("Đánh giá thất bại.");
                }
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Đã xảy ra lỗi khi lưu đánh giá: " + e.getMessage());
                return "redirect:/sanpham/" + sanPhamId;
            }

            redirectAttributes.addFlashAttribute("success", "Đánh giá của bạn đã được gửi thành công!");
        } catch (Exception e) {
            // Xử lý các lỗi chung
            redirectAttributes.addFlashAttribute("error", "Đã xảy ra lỗi khi gửi đánh giá: " + e.getMessage());
        }

        return "redirect:/sanpham/" + sanPhamId; // Quay lại trang chi tiết sản phẩm
    }


}
