package com.dan.datn.Controller;

import com.dan.datn.Entity.ThongKe;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import com.dan.datn.Service.ThongKeService;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.TextStyle;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class ThongKeController {

    @Autowired
    private ThongKeService thongKeService;

    @Autowired
    private UserServiceImpl userServiceImpl;

    private final String exportPath = "D:/Excel";  // Đường dẫn mặc định là D:/Excel

    // Lấy thống kê doanh thu
    @GetMapping("/thongke")
    public String getThongKe(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String ten = (String) session.getAttribute("ten");
        if (ten == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập với vai trò admin để xem thống kê.");
            return "redirect:/dangnhapadmin";
        }

        // Nếu đã đăng nhập
        model.addAttribute("email", ten);

        // Lấy dữ liệu thống kê
        List<ThongKe> thongKes = thongKeService.getAllThongKe();

        // Lọc các sản phẩm trùng lặp và tính tổng doanh thu
        List<ThongKe> uniqueThongKes = getUniqueThongKes(thongKes);
        double totalRevenue = 0;
        int totalQuantitySold = 0;  // Khai báo biến để tính tổng số lượng sản phẩm bán được

        // Duyệt qua danh sách ThongKe và tính tổng doanh thu và số lượng bán được
        for (ThongKe tk : uniqueThongKes) {
            totalRevenue += tk.getThanhToan().getTongTien();  // Tổng doanh thu
            totalQuantitySold += tk.getThanhToan().getSoLuong();  // Tổng số lượng sản phẩm bán được
        }

        // Doanh thu theo tháng
        Map<String, Double> revenueByMonth = thongKes.stream()
                .filter(thongKe -> thongKe.getThanhToan() != null && thongKe.getThanhToan().getNgayDatHang() != null) // Kiểm tra null
                .collect(Collectors.groupingBy(
                        thongKe -> {
                            LocalDate date = thongKe.getThanhToan().getNgayDatHang().toInstant()
                                    .atZone(ZoneId.systemDefault())
                                    .toLocalDate();
                            return date.getMonth().getDisplayName(TextStyle.FULL, new Locale("vi", "VN")) + " " + date.getYear();
                        },
                        Collectors.summingDouble(thongKe -> thongKe.getThanhToan().getTongTien())
                ));

        // Doanh thu theo năm
        Map<Integer, Double> revenueByYear = thongKes.stream()
                .filter(thongKe -> thongKe.getThanhToan() != null && thongKe.getThanhToan().getNgayDatHang() != null) // Kiểm tra null
                .collect(Collectors.groupingBy(
                        thongKe -> {
                            LocalDate date = thongKe.getThanhToan().getNgayDatHang().toInstant()
                                    .atZone(ZoneId.systemDefault())
                                    .toLocalDate();
                            return date.getYear();
                        },
                        Collectors.summingDouble(thongKe -> thongKe.getThanhToan().getTongTien())
                ));

        // Log doanh thu theo tháng
        revenueByMonth.forEach((key, value) -> System.out.println("Tháng: " + key + ", Tổng doanh thu: " + value));

        // Log doanh thu theo năm
        revenueByYear.forEach((key, value) -> System.out.println("Năm: " + key + ", Tổng doanh thu: " + value));

        // Thử xử lý và truyền JSON vào model
        try {
            ObjectMapper objectMapper = new ObjectMapper();

            // Doanh thu theo tháng
            String revenueJson = objectMapper.writeValueAsString(revenueByMonth);
            System.out.println("Doanh thu theo tháng (JSON): " + revenueJson);
            model.addAttribute("revenueByMonthJson", revenueJson);

            // Doanh thu theo năm
            objectMapper.configure(JsonGenerator.Feature.WRITE_BIGDECIMAL_AS_PLAIN, true);
            String revenueByYearJson = objectMapper.writeValueAsString(revenueByYear);
            System.out.println("Doanh thu theo năm (JSON): " + revenueByYearJson);
            model.addAttribute("revenueByYearJson", revenueByYearJson);

        } catch (Exception e) {
            // Log lỗi nếu có
            System.err.println("Lỗi khi xử lý JSON hoặc thêm vào model: " + e.getMessage());
            e.printStackTrace();
        }

        // Truyền các giá trị vào model
        model.addAttribute("thongKes", uniqueThongKes);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalQuantitySold", totalQuantitySold);  // Thêm tổng số lượng sản phẩm đã bán vào model

        // Cập nhật session với email
        session.setAttribute("email", ten);

        return "index/ThongKeDoanhThu";
    }



    // Phương thức để lọc và gộp các sản phẩm trùng lặp
    private List<ThongKe> getUniqueThongKes(List<ThongKe> thongKes) {
        Map<Long, ThongKe> uniqueProductsMap = new HashMap<>();
        for (ThongKe thongKe : thongKes) {
            Long productId = thongKe.getThanhToan().getSanPham().getID_san_pham();
            if (uniqueProductsMap.containsKey(productId)) {
                ThongKe existingThongKe = uniqueProductsMap.get(productId);
                existingThongKe.getThanhToan().setSoLuong(
                        existingThongKe.getThanhToan().getSoLuong() + thongKe.getThanhToan().getSoLuong()
                );
                existingThongKe.getThanhToan().setTongTien(
                        existingThongKe.getThanhToan().getTongTien() + thongKe.getThanhToan().getTongTien()
                );
            } else {
                uniqueProductsMap.put(productId, thongKe);
            }
        }
        return new ArrayList<>(uniqueProductsMap.values());
    }

    // Xuất Excel
    @GetMapping("/export/excel-to-path")
    public String exportToExcel(HttpSession session, Model model, RedirectAttributes redirectAttributes) throws IOException {
        String email = (String) session.getAttribute("email");
        if (email == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập với vai trò admin để xem thống kê.");
            return "redirect:/dangnhapadmin";
        }

        // Nếu đã đăng nhập
        model.addAttribute("email", email);

        // Lấy dữ liệu thống kê
        List<ThongKe> thongKes = thongKeService.getAllThongKe();
        List<ThongKe> uniqueThongKes = getUniqueThongKes(thongKes);

        // Tạo workbook
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("ThongKe");

        // Tạo header
        Row headerRow = sheet.createRow(0);
        String[] headers = {"ID Sản phẩm", "Tên sản phẩm", "Giá", "Số lượng", "Tổng tiền"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            CellStyle style = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            style.setFont(font);
            cell.setCellStyle(style);
        }

        // Tạo CellStyle cho định dạng tiền tệ (VND)
        CellStyle currencyStyle = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        currencyStyle.setDataFormat(format.getFormat("#,##0 ₫"));

        // Điền dữ liệu vào các dòng
        int rowIndex = 1;
        double totalRevenue = 0;
        int totalProductsSold = 0; // Tổng sản phẩm bán được

        for (ThongKe thongKe : uniqueThongKes) {
            Row row = sheet.createRow(rowIndex++);
            row.createCell(0).setCellValue(thongKe.getThanhToan().getSanPham().getID_san_pham());
            row.createCell(1).setCellValue(thongKe.getThanhToan().getSanPham().getTenSach());

            // Định dạng giá tiền
            Cell priceCell = row.createCell(2);
            priceCell.setCellValue(thongKe.getThanhToan().getSanPham().getGia());
            priceCell.setCellStyle(currencyStyle);

            row.createCell(3).setCellValue(thongKe.getThanhToan().getSoLuong());
            totalProductsSold += thongKe.getThanhToan().getSoLuong(); // Cộng tổng sản phẩm bán được

            // Định dạng tổng tiền
            Cell totalCell = row.createCell(4);
            totalCell.setCellValue(thongKe.getThanhToan().getTongTien());
            totalCell.setCellStyle(currencyStyle);

            totalRevenue += thongKe.getThanhToan().getTongTien();
        }

        // Tạo dòng "Tổng sản phẩm bán được" ở một hàng riêng
        Row totalProductsRow = sheet.createRow(rowIndex++);
        totalProductsRow.createCell(0).setCellValue("");  // Cột "ID Sản phẩm"
        totalProductsRow.createCell(1).setCellValue("");  // Cột "Tên sản phẩm"
        totalProductsRow.createCell(2).setCellValue("");  // Cột "Giá"
        totalProductsRow.createCell(3).setCellValue("Tổng sản phẩm bán được");  // Cột "Số lượng"

        // Định dạng chữ "Tổng sản phẩm bán được" để in đậm
        CellStyle boldStyle = workbook.createCellStyle();
        Font boldFont = workbook.createFont();
        boldFont.setBold(true);  // Đặt font chữ in đậm
        boldStyle.setFont(boldFont);
        totalProductsRow.getCell(3).setCellStyle(boldStyle);

        // Ghi tổng sản phẩm bán được vào cột tiếp theo
        Cell totalProductsCell = totalProductsRow.createCell(4);
        totalProductsCell.setCellValue(totalProductsSold);
        totalProductsCell.setCellStyle(boldStyle);

        // Tạo dòng "Tổng doanh thu" ngay bên dưới
        Row totalRow = sheet.createRow(rowIndex++);
        totalRow.createCell(0).setCellValue("");  // Cột "ID Sản phẩm"
        totalRow.createCell(1).setCellValue("");  // Cột "Tên sản phẩm"
        totalRow.createCell(2).setCellValue("");  // Cột "Giá"
        totalRow.createCell(3).setCellValue("Tổng doanh thu");  // Cột "Số lượng"
        totalRow.getCell(3).setCellStyle(boldStyle);

        // Định dạng tổng doanh thu
        Cell totalRevenueCell = totalRow.createCell(4);
        totalRevenueCell.setCellValue(totalRevenue);
        totalRevenueCell.setCellStyle(currencyStyle);

        // Tự động điều chỉnh kích thước cột
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Tạo thư mục nếu chưa tồn tại
        File directory = new File(exportPath);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // Lấy ngày giờ hiện tại và tạo tên file
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String formattedDate = dateFormat.format(new Date());
        String fileName = "ThongKe_" + formattedDate + ".xlsx";
        String filePath = exportPath + File.separator + fileName;

        // Ghi file Excel vào đường dẫn
        try (FileOutputStream fileOut = new FileOutputStream(filePath)) {
            workbook.write(fileOut);
            workbook.close();
            redirectAttributes.addFlashAttribute("success", "File Excel đã được lưu tại: " + filePath);
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xuất file Excel: " + e.getMessage());
            return "redirect:/thongke";
        }

        // Trả về thông báo thành công
        return "redirect:/thongke";
    }

}
