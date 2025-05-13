package com.dan.datn.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "The_Loai")
@Getter
@Setter
public class TheLoai {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_the_loai;

    @Column(name = "The_loai", nullable = false)
    private String theLoai;

    // Relationships
    @OneToMany(mappedBy = "theLoai")
    private List<SanPham> sanPhamList;

    @Override
    public String toString() {
        return this.theLoai;  // Trả về tên thể loại khi đối tượng được in ra
    }
}

