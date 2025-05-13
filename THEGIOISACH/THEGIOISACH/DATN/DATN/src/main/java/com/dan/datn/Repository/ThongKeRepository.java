package com.dan.datn.Repository;

import com.dan.datn.Entity.ThongKe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ThongKeRepository extends JpaRepository<ThongKe, Long> {
    List<ThongKe> findAll();
}
