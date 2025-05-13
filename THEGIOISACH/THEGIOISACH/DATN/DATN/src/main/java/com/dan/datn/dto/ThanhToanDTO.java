package com.dan.datn.dto;

import lombok.*;

import java.util.Date;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ThanhToanDTO {
    Long idSanPham;
    String userName;
    String phuong_thuc_thanh_toan;
    int soLuong;
    String diaChi;
    double tongTien;
    List<ProductDTO> products;
}
