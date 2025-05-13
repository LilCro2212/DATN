package com.dan.datn.Repository;

import com.dan.datn.Entity.SanPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import static com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl.sanPhamRepository;


@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, Long> {
    // Truy vấn sản phẩm theo khoảng ID
    @Query("SELECT s FROM SanPham s WHERE s.ID_san_pham BETWEEN 3 AND 6")
    List<SanPham> findSanPhamByIdRange();

    // Truy vấn sản phẩm theo danh sách ID cụ thể
    @Query("SELECT s FROM SanPham s WHERE s.ID_san_pham IN (2, 16, 31, 46, 61, 76)")
    List<SanPham> findSanPhamBySpecificIds();

    @Query("SELECT s FROM SanPham s ORDER BY FUNCTION('RAND')")
    List<SanPham> findSanPhamSanPham();

    public default List<SanPham> getSanPhamByIdRange() {
        return sanPhamRepository.findSanPhamByIdRange();
    }

    @Query("SELECT sp FROM SanPham sp JOIN sp.theLoai tl WHERE tl.theLoai = :theLoai")
    List<SanPham> findByTheLoai(@Param("theLoai") String theLoai);

    @Query(value = "SELECT TOP 12 * FROM San_Pham ORDER BY NEWID()", nativeQuery = true)
    List<SanPham> findRandomProducts();

    // Phương thức tìm sản phẩm theo ID
    Optional<SanPham> findById(Long id);

    //Truy vấn sản phẩm theo giá thấp nhất đến cao nhất
    @Query("SELECT sp FROM SanPham sp WHERE sp.gia BETWEEN :minPrice AND :maxPrice")
    List<SanPham> findSanPhamsByPriceRange(@Param("minPrice") Integer minPrice, @Param("maxPrice") Integer maxPrice);

    @Query("SELECT s FROM SanPham s " +
            "JOIN FETCH s.theLoai tl " +
            "WHERE LOWER(s.tenSach) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(s.nhaXuatBan) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(s.tacGia) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(s.moTa) LIKE LOWER(CONCAT('%', :keyword, '%')) " )
//            "OR LOWER(tl.theLoai) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<SanPham> searchAllFields(String keyword);

    @Query("SELECT s.tenSach FROM SanPham s WHERE LOWER(s.tenSach) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<String> findSuggestionsByKeyword(@Param("keyword") String keyword);


}
