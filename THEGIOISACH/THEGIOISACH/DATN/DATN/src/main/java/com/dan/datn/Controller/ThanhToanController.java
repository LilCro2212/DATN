package com.dan.datn.Controller;

import com.dan.datn.Entity.SanPham;
import com.dan.datn.Entity.User;
import com.dan.datn.Repository.SanPhamRepository;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import com.dan.datn.Service.ThanhToanService;
import com.dan.datn.Service.UserService;
import com.dan.datn.dto.ProductDTO;
import com.dan.datn.dto.ThanhToanDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@SessionAttributes("username")
@RequiredArgsConstructor
@RequestMapping("/api")
public class ThanhToanController {
    private final HttpSession session;
    private final ThanhToanService thanhToanService;
    private final UserService userService;
    private final SanPhamRepository spRepository;
    private final UserServiceImpl userServiceImpl;

    @GetMapping("/checkout")
    public String showCheckoutPage(@RequestParam String productIds,
                                   @RequestParam String quantities,
                                   Model model) {
        // Logging để debug
        System.out.println("Received productIds: " + productIds);
        System.out.println("Received quantities: " + quantities);

        String username = (String) session.getAttribute("username");
        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập giỏ hàng.");
            return "index/dangNhap";
        }

        // Cập nhật lại thông tin người dùng
        Optional<User> userOptional = userServiceImpl.getUserByTen(username);
        if (userOptional.isPresent()) {
            model.addAttribute("user", userOptional.get());
        }

        // Chuyển đổi chuỗi thành mảng
        String[] productIdArray = productIds.split(",");
        String[] quantityArray = quantities.split(",");

        // Logging sau khi split
        System.out.println("Product IDs array: " + Arrays.toString(productIdArray));
        System.out.println("Quantities array: " + Arrays.toString(quantityArray));

        List<SanPham> selectedProducts = new ArrayList<>();
        double total = 0;

        try {
            for (int i = 0; i < productIdArray.length; i++) {
                Long productId = Long.valueOf(productIdArray[i]);
                System.out.println("Processing product ID: " + productId); // Logging

                SanPham sanPham = spRepository.findById(productId)
                        .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với ID: " + productId));

                int quantity = Integer.parseInt(quantityArray[i]);
                System.out.println("Quantity for product " + productId + ": " + quantity); // Logging

                sanPham.setSoLuongTongSanPham(quantity);
                selectedProducts.add(sanPham);
                total += sanPham.getGia() * quantity;
            }
            session.setAttribute("cart", selectedProducts);
            model.addAttribute("cart", selectedProducts);
            model.addAttribute("total", total);
            model.addAttribute("user", userService.getUserByTen(username).get());

            return "layout/checkout";

        } catch (Exception e) {
            e.printStackTrace(); // In stack trace để debug
            model.addAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            return "error-page";
        }
    }

    @PostMapping("/processCheckout")
    public String processCheckout(@RequestParam("phuong_thuc_thanh_toan") String phuongThucThanhToan,
                                  @RequestParam("total") Double total,
                                  Model model) {
        System.out.println("Processing checkout...");

        // Lấy giỏ hàng từ session
        List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            model.addAttribute("error", "Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
            return "redirect:/cart";
        }
        // Chuyển giỏ hàng thành danh sách ProductDTO
        List<ProductDTO> productDTOs = new ArrayList<>();
        for (SanPham sanPham : cart) {
            if (sanPham != null) {
                ProductDTO productDTO = new ProductDTO();
                productDTO.setId(sanPham.getID_san_pham());
                productDTO.setTenSach(sanPham.getTenSach());
                productDTO.setGia(sanPham.getGia());
                productDTO.setSoLuong(sanPham.getSoLuongTongSanPham());// Sử dụng số lượng từ giỏ hàng
                productDTOs.add(productDTO);
            }
        }
        model.addAttribute("products", productDTOs);

        // Tạo DTO cho thanh toán
        ThanhToanDTO thanhToanDTO = new ThanhToanDTO();
        thanhToanDTO.setUserName((String) session.getAttribute("username"));
        thanhToanDTO.setPhuong_thuc_thanh_toan(phuongThucThanhToan);
        thanhToanDTO.setTongTien(total);
        thanhToanDTO.setProducts(productDTOs);

        // Gọi service thanh toán
        thanhToanService.thanhToan(thanhToanDTO);

        // Xóa giỏ hàng khỏi session
        session.removeAttribute("cart");

        // Quay về trang thành công
        return "layout/checkoutSuccess";
    }


    @GetMapping("/checkoutSuccess")
    public String showCheckoutSuccess(Model model) {

        return "layout/checkoutSuccess";
    }

    // New method for updating user information
    @PostMapping("/updateThongTin")
    public String updateThongTin(
            @RequestParam("ten") String ten,
            @RequestParam("phone") String phone,
            @RequestParam("email") String email,
            @RequestParam("diachi") String diachi,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        String username = (String) session.getAttribute("username");

        if (username == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng đăng nhập trước khi cập nhật thông tin cá nhân.");
            return "redirect:/login";
        }

        Optional<User> userOptional = userServiceImpl.getUserByTen(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.setTen(ten);
            user.setSDT(phone);
            user.setEmail(email);
            user.setDia_chi(diachi);

            try {
                userServiceImpl.saveUser(user);
                redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Đã xảy ra lỗi khi cập nhật thông tin.");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Người dùng không tồn tại.");
        }

        // Chuyển hướng đến trang checkout
        return "redirect:/api/checkout";
    }


}
