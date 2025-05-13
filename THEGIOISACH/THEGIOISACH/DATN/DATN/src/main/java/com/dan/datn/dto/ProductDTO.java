package com.dan.datn.dto;

import lombok.*;

import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProductDTO {
    private Long id;
    private String tenSach;
    private String nhaXuatBan;
    private String nhaCungCap;
    private String tacGia;
    private String theLoai;
    private int gia;
    private Integer soLuong;
}
