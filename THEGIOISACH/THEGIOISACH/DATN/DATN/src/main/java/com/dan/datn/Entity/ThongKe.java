package com.dan.datn.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Table(name = "Thong_Ke")
@Getter
@Setter
public class ThongKe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_thong_ke;
    @Column(name = "tong_doanh_thu")
    private Integer tongDoanhThu;
    // Relationships
    @OneToOne
    @JoinColumn(name = "ID_thanh_toan", nullable = false) // Foreign key referencing Thanh_Toan
    private ThanhToan thanhToan; // This is mapped to the Thanh_Toan table
}
