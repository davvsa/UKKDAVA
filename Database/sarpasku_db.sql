-- phpMyAdmin-style SQL Dump
-- Project : SarpasKu - Sistem Pengaduan Sarana & Prasarana Sekolah
-- Catatan : Skema ini sudah disinkronkan dengan kode aplikasi (lihat README_PERUBAHAN.md).
--           Tabel `lampiran` dan `histori` ditambahkan, serta kolom yang sebelumnya
--           hilang (siswa.password, kategori.nama_kategori, aspirasi.id_admin)
--           sudah dilengkapi supaya aplikasi berjalan tanpa error.

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(50) NOT NULL DEFAULT 'Admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
-- (kolom `password` ditambahkan — dipakai oleh login.php & register.php)
--

CREATE TABLE `siswa` (
  `nis` varchar(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `kelas` varchar(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
-- (kolom `nama_kategori` ditambahkan — dipakai di semua halaman kategori/aspirasi)
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL,
  `ket_kategori` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `aspirasi`
-- (kolom `id_admin` ditambahkan — dipakai saat insert dari form_aspirasi.php & buat_pengaduan.php)
--

CREATE TABLE `aspirasi` (
  `id_aspirasi` int(11) NOT NULL,
  `nis` varchar(10) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `lokasi` varchar(50) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `status` enum('Menunggu','Proses','Selesai') NOT NULL DEFAULT 'Menunggu',
  `feedback` varchar(255) DEFAULT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `histori`
-- (tabel baru — sebelumnya dipakai kode tapi tidak ada di dump lama, jadi menyebabkan error)
--

CREATE TABLE `histori` (
  `id_histori` int(11) NOT NULL,
  `id_aspirasi` int(11) NOT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `status_lama` enum('Menunggu','Proses','Selesai') DEFAULT NULL,
  `status_baru` enum('Menunggu','Proses','Selesai') NOT NULL,
  `catatan` varchar(255) DEFAULT NULL,
  `diubah_oleh` varchar(50) DEFAULT NULL,
  `waktu_ubah` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lampiran`
-- (tabel baru — sebelumnya dipakai kode tapi tidak ada di dump lama, jadi menyebabkan error)
--

CREATE TABLE `lampiran` (
  `id_lampiran` int(11) NOT NULL,
  `id_aspirasi` int(11) NOT NULL,
  `url_file` varchar(255) NOT NULL,
  `nama_file` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
--
-- Data sample: admin
--
INSERT INTO `admin` (`id_admin`, `username`, `password`, `nama`, `created_at`) VALUES
(1, 'admin', 'admin123', 'Farah Amelia Putri', NOW());

--
-- Data sample: siswa
--
INSERT INTO `siswa` (`nis`, `nama`, `kelas`, `password`, `created_at`) VALUES
('2526001', 'Bagas Firmansyah', 'XI TKJ 1', 'siswa123', NOW()),
('2526002', 'Nadia Ayu Lestari', 'XI TKJ 1', 'siswa123', NOW()),
('2526003', 'Rafi Ardiansyah', 'XII RPL 2', 'siswa123', NOW()),
('2526004', 'Salsabila Zahra', 'X MM 1', 'siswa123', NOW());

--
-- Data sample: kategori
--
INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `ket_kategori`) VALUES
(1, 'Listrik & Elektronik', 'Kerusakan lampu, stop kontak, proyektor, AC, dan perangkat elektronik lain'),
(2, 'Furnitur', 'Kerusakan meja, kursi, lemari, papan tulis'),
(3, 'Sanitasi & Air', 'Masalah toilet, wastafel, saluran air, kran bocor'),
(4, 'Bangunan', 'Kerusakan atap, dinding, jendela, pintu, lantai'),
(5, 'Jaringan Internet', 'Wifi lambat/mati, gangguan jaringan komputer lab');

--
-- Data sample: aspirasi (pengaduan)
--
INSERT INTO `aspirasi` (`id_aspirasi`, `nis`, `id_kategori`, `id_admin`, `lokasi`, `keterangan`, `status`, `feedback`, `tanggal`, `updated_at`) VALUES
(1, '2526001', 1, 1, 'Lab Komputer 2', 'Lampu ruangan bagian belakang mati total sejak dua hari lalu.', 'Selesai', 'Lampu sudah diganti baru oleh petugas sarpras.', DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY)),
(2, '2526002', 3, 1, 'Toilet Putri Lt.2', 'Keran wastafel bocor terus-menerus, air tergenang di lantai.', 'Proses', 'Sudah dijadwalkan perbaikan oleh teknisi minggu ini.', DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),
(3, '2526003', 2, 1, 'Ruang XII RPL 2', 'Salah satu kursi siswa patah pada bagian kaki.', 'Menunggu', NULL, DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY)),
(4, '2526004', 5, 1, 'Lab Multimedia', 'Koneksi wifi sangat lambat saat jam praktik berlangsung.', 'Menunggu', NULL, NOW(), NOW());

--
-- Data sample: histori (riwayat perubahan status)
--
INSERT INTO `histori` (`id_histori`, `id_aspirasi`, `id_admin`, `status_lama`, `status_baru`, `catatan`, `diubah_oleh`, `waktu_ubah`) VALUES
(1, 1, 1, NULL, 'Menunggu', 'Aspirasi baru masuk.', 'siswa', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(2, 1, 1, 'Menunggu', 'Proses', 'Teknisi sudah dijadwalkan untuk pengecekan.', 'Farah Amelia Putri', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(3, 1, 1, 'Proses', 'Selesai', 'Lampu sudah diganti baru oleh petugas sarpras.', 'Farah Amelia Putri', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(4, 2, 1, NULL, 'Menunggu', 'Aspirasi baru masuk.', 'siswa', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 2, 1, 'Menunggu', 'Proses', 'Sudah dijadwalkan perbaikan oleh teknisi minggu ini.', 'Farah Amelia Putri', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(6, 3, 1, NULL, 'Menunggu', 'Aspirasi baru masuk.', 'siswa', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(7, 4, 1, NULL, 'Menunggu', 'Aspirasi baru masuk.', 'siswa', NOW());

--
-- Indexes for dumped tables
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `username` (`username`);

ALTER TABLE `siswa`
  ADD PRIMARY KEY (`nis`);

ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`),
  ADD UNIQUE KEY `nama_kategori` (`nama_kategori`);

ALTER TABLE `aspirasi`
  ADD PRIMARY KEY (`id_aspirasi`),
  ADD KEY `fk_aspirasi_siswa` (`nis`),
  ADD KEY `fk_aspirasi_kategori` (`id_kategori`),
  ADD KEY `fk_aspirasi_admin` (`id_admin`);

ALTER TABLE `histori`
  ADD PRIMARY KEY (`id_histori`),
  ADD KEY `fk_histori_aspirasi` (`id_aspirasi`),
  ADD KEY `fk_histori_admin` (`id_admin`);

ALTER TABLE `lampiran`
  ADD PRIMARY KEY (`id_lampiran`),
  ADD KEY `fk_lampiran_aspirasi` (`id_aspirasi`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `aspirasi`
  MODIFY `id_aspirasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `histori`
  MODIFY `id_histori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `lampiran`
  MODIFY `id_lampiran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Foreign Keys)
--
ALTER TABLE `aspirasi`
  ADD CONSTRAINT `fk_aspirasi_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_aspirasi_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_aspirasi_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `histori`
  ADD CONSTRAINT `fk_histori_aspirasi` FOREIGN KEY (`id_aspirasi`) REFERENCES `aspirasi` (`id_aspirasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_histori_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `lampiran`
  ADD CONSTRAINT `fk_lampiran_aspirasi` FOREIGN KEY (`id_aspirasi`) REFERENCES `aspirasi` (`id_aspirasi`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;