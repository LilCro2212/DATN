package com.dan.datn.Repository;

import com.dan.datn.Entity.TheLoai;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TheLoaiRepository extends JpaRepository<TheLoai, Long> {
    TheLoai findByTheLoai(String theLoai);
}
