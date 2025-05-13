package com.dan.datn.Controller;

import com.dan.datn.Entity.Hinh;
import com.dan.datn.Entity.SanPham;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import static com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl.sanPhamRepository;


@SessionAttributes("username")
@Controller
public class GioHangController {
    private final UserServiceImpl userServiceImpl;
    @Autowired
    private HttpSession session;

    public GioHangController(UserServiceImpl userServiceImpl) {
        this.userServiceImpl = userServiceImpl;
    }

    @GetMapping("/giohang")
    public String giohang(Model model) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập giỏ hàng.");
            return "index/dangNhap";
        }
        // Lấy giỏ hàng từ session, nếu chưa có thì tạo mới
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        for (SanPham sp : cart) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }
        // Truyền giỏ hàng vào model để hiển thị
        model.addAttribute("cart", cart);
        return "layout/gioHang";  // Trả về view giỏ hàng
    }


    @PostMapping("/cart")
    public String addToCart(@RequestParam("productId") Long productId, Model model) {
        // Tìm sản phẩm trong cơ sở dữ liệu
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập giỏ hàng.");
            return "index/dangNhap";
        }

        SanPham sanpham = sanPhamRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Sản phẩm không tồn tại với ID: " + productId));

        // Kiểm tra số lượng tồn kho
        if (sanpham.getSoLuongTonKho() == null || sanpham.getSoLuongTonKho() <= 0) {
            session.setAttribute("error", "Sản phẩm này đã hết hàng, không thể thêm vào giỏ.");
            return "redirect:/sanpham/" + productId;
        }

        // Lấy giỏ hàng từ session, nếu chưa có thì tạo mới
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        boolean found = false;
        for (SanPham item : cart) {
            if (item.getID_san_pham().equals(sanpham.getID_san_pham())) {
                found = true;
                break;
            }
        }

        // Nếu sản phẩm chưa có trong giỏ hàng, thêm vào giỏ hàng
        if (!found) {
            cart.add(sanpham);
            session.setAttribute("cart", cart);  // Lưu lại giỏ hàng mới vào session
            session.setAttribute("success", "Sản phẩm đã được thêm vào giỏ hàng");
        } else {
            session.setAttribute("error", "Sản phẩm này đã có trong giỏ hàng");
        }

        // Truyền giỏ hàng vào model
        model.addAttribute("sanpham", sanpham);
        model.addAttribute("username", session.getAttribute("username"));

        // Chuyển hướng về trang chi tiết sản phẩm với thông báo thành công
        return "redirect:/sanpham/" + productId;
    }


    @PostMapping("/removeFromCart")
    public String removeFromCart(@RequestParam("productId") Long productId, Model model, RedirectAttributes redirectAttributes) {
        // Lấy giỏ hàng từ session
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập giỏ hàng.");
            return "index/dangNhap";
        }
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        if (cart != null) {
            // Tìm sản phẩm trong giỏ hàng và xóa nó
            // biểu thức lamda
            cart.removeIf(item -> item.getID_san_pham().equals(productId));

            // Cập nhật lại giỏ hàng trong session
            session.setAttribute("cart", cart);

            redirectAttributes.addFlashAttribute("success", "Sản phẩm đã được xóa khỏi giỏ hàng");
        } else {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng trống");
        }

        // Truyền giỏ hàng vào model để hiển thị
        redirectAttributes.addFlashAttribute("cart", cart);
        redirectAttributes.addFlashAttribute("username", session.getAttribute("username"));

        return "redirect:/giohang";  // Trả về view giỏ hàng
    }
}
