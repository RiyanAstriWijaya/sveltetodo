-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Jul 2024 pada 08.42
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` smallint(6) NOT NULL,
  `nama` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `nama`) VALUES
(1, 'Programming');

-- --------------------------------------------------------

--
-- Struktur dari tabel `post`
--

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `kategori` smallint(6) NOT NULL,
  `judul` varchar(256) NOT NULL,
  `deskripsi` text NOT NULL,
  `gambar` varchar(80) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `post`
--

INSERT INTO `post` (`id`, `kategori`, `judul`, `deskripsi`, `gambar`, `created_at`, `updated_at`) VALUES
(5, 1, 'Kesepian', 'sendiri melintas sepi', '/img/07ltlwdwu1nqex5uj15xjkj.jpg', '2024-06-27 14:04:25', '2024-06-27 14:04:25'),
(6, 1, 'Algoritma pemograman', 'Langkah awal menjadi programer', '/img/8aly7pryckwisxg4klwv.jpg', '2024-06-27 14:50:14', '2024-06-27 14:50:14'),
(7, 1, 'Dunia Angkasa', 'WJWJWJWJWKwjjwjw', '/img/zx051ptw3gg4gz6atj76g.jpg', '2024-06-27 14:53:10', '2024-06-27 14:53:10'),
(8, 1, 'wjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', 'wjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjwjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjwjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjwjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', '/img/ftgj3e4poemyl3ejtx9img.jpg', '2024-06-27 15:35:58', '2024-06-27 15:35:58'),
(9, 1, 'kjjjjjwhdgygadgtadf', 'kjjjjjwhdgygadgtadfkjjjjjwhdgygadgtadfkjjjjjwhdgygadgtadf', '/img/b108ob4lyww0yxrf19mfw6s.jpg', '2024-06-27 15:36:33', '2024-06-27 15:36:33'),
(10, 1, 'analisis simtem informasi', 'pengiriman ini menggukan si cepat exprres dan estimasinya sehari setelah pengiriman apabila kami telat dari sehari maka pembeli tidak usah bayar', '/img/ri47azwjbffzwjuaazxvk.jpg', '2024-07-04 13:22:42', '2024-07-04 13:22:42');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategori_post` (`kategori`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `kategori_post` FOREIGN KEY (`kategori`) REFERENCES `kategori` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
