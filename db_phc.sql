/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.5.9-MariaDB : Database - db_phc
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_phc` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_phc`;

/*Table structure for table `absen` */

DROP TABLE IF EXISTS `absen`;

CREATE TABLE `absen` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `tipe` enum('Sakit','Ijin','Mangkir','Cuti') NOT NULL,
  `dari_tanggal` date NOT NULL,
  `sampai_tanggal` date NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_kehadiran_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_kehadiran_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `absen` */

/*Table structure for table `jabatan` */

DROP TABLE IF EXISTS `jabatan`;

CREATE TABLE `jabatan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `tipe` enum('Promosi','Demosi','Mutasi') NOT NULL,
  `terhitung_mulai` date NOT NULL,
  `no_sk` varchar(255) NOT NULL,
  `nama_jabatan` varchar(255) NOT NULL,
  `departemen` varchar(255) NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_jabatan_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_jabatan_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `jabatan` */

/*Table structure for table `kabupaten` */

DROP TABLE IF EXISTS `kabupaten`;

CREATE TABLE `kabupaten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_provinsi` int(11) NOT NULL,
  `nama_kabupaten` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=latin1;

/*Data for the table `kabupaten` */

insert  into `kabupaten`(`id`,`id_provinsi`,`nama_kabupaten`) values 
(1,1,'Kabupaten Aceh Barat'),
(2,1,'Kabupaten Aceh Barat Daya'),
(3,1,'Kabupaten Aceh Besar'),
(4,1,'Kabupaten Aceh Jaya'),
(5,1,'Kabupaten Aceh Selatan'),
(6,1,'Kabupaten Aceh Singkil'),
(7,1,'Kabupaten Aceh Tamiang'),
(8,1,'Kabupaten Aceh Tengah'),
(9,1,'Kabupaten Aceh Tenggara'),
(10,1,'Kabupaten Aceh Timur'),
(11,1,'Kabupaten Aceh Utara'),
(12,1,'Kabupaten Bener Meriah'),
(13,1,'Kabupaten Bireuen'),
(14,1,'Kabupaten Gayo Lues'),
(15,1,'Kabupaten Nagan Raya'),
(16,1,'Kabupaten Pidie'),
(17,1,'Kabupaten Pidie Jaya'),
(18,1,'Kabupaten Simeulue'),
(19,2,'Kabupaten Asahan'),
(20,2,'Kabupaten Batu Bara'),
(21,2,'Kabupaten Dairi'),
(22,2,'Kabupaten Deli Serdang'),
(23,2,'Kabupaten Humbang Hasundutan'),
(24,2,'Kabupaten Karo'),
(25,2,'Kabupaten Labuhanbatu'),
(26,2,'Kabupaten Labuhanbatu Selatan'),
(27,2,'Kabupaten Labuhanbatu Utara'),
(28,2,'Kabupaten Langkat'),
(29,2,'Kabupaten Mandailing Natal'),
(30,2,'Kabupaten Nias'),
(31,2,'Kabupaten Nias Barat'),
(32,2,'Kabupaten Nias Selatan'),
(33,2,'Kabupaten Nias Utara'),
(34,2,'Kabupaten Padang Lawas'),
(35,2,'Kabupaten Padang Lawas Utara'),
(36,2,'Kabupaten Pakpak Bharat'),
(37,2,'Kabupaten Samosir'),
(38,2,'Kabupaten Serdang Bedagai'),
(39,2,'Kabupaten Simalungun'),
(40,2,'Kabupaten Tapanuli Selatan'),
(41,2,'Kabupaten Tapanuli Tengah'),
(42,2,'Kabupaten Tapanuli Utara'),
(43,2,'Kabupaten Toba Samosir'),
(44,3,'Kabupaten Agam'),
(45,3,'Kabupaten Dharmasraya'),
(46,3,'Kabupaten Kepulauan Mentawai'),
(47,3,'Kabupaten Lima Puluh Kota'),
(48,3,'Kabupaten Padang Pariaman'),
(49,3,'Kabupaten Pasaman'),
(50,3,'Kabupaten Pasaman Barat'),
(51,3,'Kabupaten Pesisir Selatan'),
(52,3,'Kabupaten Sijunjung'),
(53,3,'Kabupaten Solok'),
(54,3,'Kabupaten Solok Selatan'),
(55,3,'Kabupaten Tanah Datar'),
(56,4,'Kabupaten Bengkalis'),
(57,4,'Kabupaten Indragiri Hilir'),
(58,4,'Kabupaten Indragiri Hulu'),
(59,4,'Kabupaten Kampar'),
(60,4,'Kabupaten Kepulauan Meranti'),
(61,4,'Kabupaten Kuantan Singingi'),
(62,4,'Kabupaten Pelalawan'),
(63,4,'Kabupaten Rokan Hilir'),
(64,4,'Kabupaten Rokan Hulu'),
(65,4,'Kabupaten Siak'),
(66,5,'Kabupaten Bintan'),
(67,5,'Kabupaten Karimun'),
(68,5,'Kabupaten Kepulauan Anambas'),
(69,5,'Kabupaten Lingga'),
(70,5,'Kabupaten Natuna'),
(71,6,'Kabupaten Batanghari'),
(72,6,'Kabupaten Bungo'),
(73,6,'Kabupaten Kerinci'),
(74,6,'Kabupaten Merangin'),
(75,6,'Kabupaten Muaro Jambi'),
(76,6,'Kabupaten Sarolangun'),
(77,6,'Kabupaten Tanjung Jabung Barat'),
(78,6,'Kabupaten Tanjung Jabung Timur'),
(79,6,'Kabupaten Tebo'),
(82,7,'Kabupaten Banyuasin'),
(83,7,'Kabupaten Empat Lawang'),
(84,7,'Kabupaten Lahat'),
(85,7,'Kabupaten Muara Enim'),
(86,7,'Kabupaten Musi Banyuasin	'),
(87,7,'Kabupaten Musi Rawas	'),
(88,7,'Kabupaten Musi Rawas Utara	'),
(89,7,'Kabupaten Ogan Ilir	'),
(90,7,'Kabupaten Ogan Komering Ilir	'),
(91,7,'Kabupaten Ogan Komering Ulubupaten'),
(92,7,'Kabupaten Ogan Komering Ulu Selatan'),
(93,7,'Kabupaten Ogan Komering Ulu Timur'),
(94,7,'Kabupaten Penukal Abab Lematang Ilir'),
(95,8,'Kabupaten Bangka'),
(96,8,'Kabupaten Bangka Barat'),
(97,8,'Kabupaten Bangka Selatan'),
(98,8,'Kabupaten Bangka Tengah'),
(99,8,'Kabupaten Belitung'),
(100,8,'Kabupaten Belitung Timur'),
(101,9,'Kabupaten Bengkulu Selatan'),
(102,9,'Kabupaten Bengkulu Tengah'),
(103,9,'Kabupaten Bengkulu Utara'),
(104,9,'Kabupaten Kaur'),
(105,9,'Kabupaten Kepahiang'),
(106,9,'Kabupaten Lebong'),
(107,9,'Kabupaten Mukomuko'),
(108,9,'Kabupaten  Rejang Lebong'),
(109,9,'Kabupaten Seluma'),
(110,10,'Kabupaten Lampung Barat'),
(111,10,'Kabupaten Lampung Selatan'),
(112,10,'Kabupaten Lampung Tengah'),
(113,10,'Kabupaten Lampung Timur'),
(114,10,'Kabupaten Lampung Utara'),
(115,10,'Kabupaten Mesuji'),
(116,10,'Kabupaten Pesawaran'),
(117,10,'Kabupaten Pesisir Barat'),
(118,10,'Kabupaten Pringsewu'),
(119,10,'Kabupaten Tenggamus'),
(120,10,'Kabupaten Tulang Bawang'),
(121,10,'Kabupaten Tulang Bawang Barat'),
(123,10,'Kabupaten Way Kanan'),
(124,11,'Kabupaten Administrasi Kepulauan Seribu'),
(125,11,'Kota Administrasi Jakarta Barat'),
(126,11,'Kota Administrasi Jakarta Pusat'),
(127,11,'Kota Administrasi Jakarta Selatan'),
(128,11,'Kota Administrasi Jakarta Timur'),
(129,11,'Kota Administrasi Jakarta Utara'),
(130,12,'Kabupaten Lebak'),
(131,12,'Kabupaten Serang'),
(132,12,'Kabupaten Tangerang'),
(133,12,'Kota Cilegon'),
(134,12,'Kota Serang'),
(135,12,'Kota Tangerang'),
(136,12,'Kota Tangerang Selatan'),
(137,12,'Kabupaten Pandegelang'),
(138,13,'Kabupaten Bandung'),
(139,13,'Kabupaten Bandung Barat'),
(140,13,'Kabupaten Bekasi'),
(141,13,'Kabupaten Bogor'),
(142,13,'Kabupaten Ciamis'),
(143,13,'Kabupaten Cianjur'),
(144,13,'Kabupaten Cirebon'),
(145,13,'Kabupaten Garut'),
(146,13,'Kabupaten Indramayu'),
(147,13,'Kabupaten Karawang'),
(148,13,'Kabupaten Kuningan'),
(149,13,'Kabupaten Majalengka'),
(150,13,'Kabupaten Pangandaran'),
(151,13,'Kabupaten Purwakarta'),
(152,13,'Kabupaten Subang'),
(153,13,'Kabupaten Sukabumi'),
(154,13,'Kabupaten Sumedang'),
(155,13,'Kabupaten Tasikmalaya'),
(156,14,'Kabupaten Banjarnegara'),
(157,14,'Kabupaten Banyumas'),
(158,14,'Kabupaten Batang'),
(159,14,'Kabupaten Blora'),
(160,14,'Kabupaten Boyolali'),
(161,14,'Kabupaten Brebes'),
(162,14,'Kabupaten Cilacap'),
(163,14,'Kabupaten Demak'),
(164,14,'Kabupaten Grobogan'),
(165,14,'Kabupaten Jepara'),
(166,14,'Kabupaten Karanganyar'),
(167,14,'Kabupaten Kebumen'),
(168,14,'Kabupaten Kendal'),
(169,14,'Kabupaten Klaten'),
(170,14,'Kabupaten Kudus'),
(171,14,'Kabupaten Magelang'),
(172,14,'Kabupaten Pati'),
(173,14,'Kabupaten Pekalongan'),
(174,14,'Kabupaten Pemalang'),
(175,14,'Kabupaten Purbalingga'),
(176,14,'Kabupaten Purworejo'),
(177,14,'Kabupaten Rembang'),
(178,14,'Kabupaten Semarang'),
(179,14,'Kabupaten Sragen'),
(180,14,'Kabupaten Sukoharjo'),
(181,14,'Kabupaten Tegal'),
(182,14,'Kabupaten Temanggung'),
(183,14,'Kabupaten Wonogiri'),
(184,14,'Kabupaten Wonosobo'),
(185,15,'Kabupaten Bantul'),
(186,15,'Kabupaten Gunung Kidul'),
(187,15,'Kabupaten Kulon Progo'),
(188,15,'Kabupaten Sleman	'),
(189,16,'Kabupaten Bangkalan'),
(190,16,'Kabupaten Banyuwangi'),
(191,16,'Kabupaten Blitar'),
(192,16,'Kabupaten Bojonegoro'),
(193,16,'Kabupaten Bondowoso'),
(194,16,'Kabupaten Gresik'),
(195,16,'Kabupaten Jember'),
(196,16,'Kabupaten Jombang'),
(197,16,'Kabupaten Kediri'),
(198,16,'Kabupaten Lamongan'),
(199,16,'Kabupaten Lumajang'),
(200,16,'Kabupaten Madiun'),
(201,16,'Kabupaten Magetan'),
(202,16,'Kabupaten Malang'),
(203,16,'Kabupaten Mojokerto'),
(204,16,'Kabupaten Nganjuk'),
(205,16,'Kabupaten Ngawi'),
(206,16,'Kabupaten Pacitan'),
(207,16,'Kabupaten Pamekasan'),
(208,16,'	Kabupaten Pasuruan'),
(209,16,'Kabupaten Ponorogo'),
(210,16,'Kabupaten Probolinggo'),
(211,16,'Kabupaten Sampang'),
(212,16,'Kabupaten Sidoarjo'),
(213,16,'Kabupaten Situbondo'),
(214,16,'Kabupaten Sumenep'),
(215,16,'Kabupaten Trenggalek'),
(216,16,'Kabupaten Tuban'),
(217,16,'Kabupaten Tulungagung'),
(218,17,'Kabupaten Badung'),
(219,17,'Kabupaten Bangli'),
(220,17,'	Kabupaten Buleleng	'),
(221,17,'Kabupaten Gianyar'),
(222,17,'Kabupaten Jembrana'),
(223,17,'Kabupaten Karangasem'),
(224,17,'Kabupaten Klungkung'),
(225,17,'Kabupaten Tabanan'),
(226,18,'Kabupaten Bima'),
(227,18,'	Kabupaten Dompu'),
(228,18,'Kabupaten Lombok Barat'),
(229,18,'Kabupaten Lombok Tengah'),
(230,18,'Kabupaten Lombok Timur'),
(231,18,'Kabupaten Lombok Utara'),
(232,18,'Kabupaten Sumbawa'),
(233,18,'Kabupaten Sumbawa Barat'),
(234,19,'Kabupaten Alor'),
(235,19,'Kabupaten Belu'),
(236,19,'Kabupaten Ende'),
(237,19,'Kabupaten Flores Timur'),
(238,19,'Kabupaten Kupang'),
(239,19,'Kabupaten Lembata'),
(240,19,'Kabupaten Malaka'),
(241,19,'Kabupaten Manggarai'),
(242,19,'Kabupaten Manggarai Barat'),
(243,19,'Kabupaten Manggarai Timur'),
(244,19,'Kabupaten Nagekeo'),
(245,19,'Kabupaten Ngada'),
(246,19,'Kabupaten Rote Ndao'),
(247,19,'Kabupaten Sabu Raijua'),
(248,19,'Kabupaten Sikka'),
(249,19,'Kabupaten Sumba Barat'),
(250,19,'Kabupaten Sumba Barat Daya'),
(251,19,'Kabupaten Sumba Tengah'),
(252,19,'Kabupaten Sumba Timur'),
(253,19,'Kabupaten Timor Tengah Selatan'),
(255,19,'Kabupaten Timor Tengah Utara'),
(256,20,'Kabupaten Bengayang'),
(257,20,'Kabupaten Kapuas Hulu'),
(259,20,'Kabupaten Kayong Utara'),
(260,20,'Kabupaten Ketapang'),
(261,20,'Kabupaten Kubu Raya'),
(262,20,'Kabupaten Landak'),
(263,20,'Kabupaten Melawi'),
(264,21,'Kabupaten Barito Selatan'),
(265,21,'Kabupaten Barito Timur'),
(266,21,'Kabupaten Barito Utara'),
(267,21,'Kabupaten Gunung Mas	'),
(268,21,'Kabupaten Kapuas	'),
(269,21,'Kabupaten Katingan	'),
(270,21,'Kabupaten Kotawaringin Barat	'),
(271,21,'Kabupaten Kotawaringin Timur	'),
(272,21,'Kabupaten Lamandau	'),
(273,21,'Kabupaten Murung Raya	'),
(274,21,'Kabupaten Pulang Pisau	'),
(275,21,'Kabupaten Seruyan	'),
(276,21,'Kabupaten Sukamara	'),
(277,22,'Kabupaten Balangan'),
(278,22,'Kabupaten Banjar'),
(279,22,'Kabupaten Barito Kuala'),
(280,22,'Kabupaten Hulu Sungai Selatan'),
(281,22,'Kabupaten Hulu Sungai Tengah'),
(282,22,'Kabupaten Hulu Sungai Utara'),
(283,22,'Kabupaten Kotabaru'),
(284,22,'Kabupaten Tabalong'),
(285,22,'Kabupaten Tanah Bumbu'),
(287,22,'Kabupaten Tanah Laut'),
(288,22,'Kabupaten Tapin'),
(289,23,'Kabupaten Berau'),
(290,23,'Kabupaten Kutai Barat'),
(291,23,'Kabupaten Kutai Kartanegara'),
(292,23,'Kabupaten Kutai Timur'),
(293,23,'Kabupaten Mahakam Ulu'),
(294,23,'Kabupaten Panajam Paser Utara'),
(295,23,'Kabupaten Paser'),
(297,24,'Kabupaten Bulungan'),
(298,24,'Kabupaten Malinau'),
(299,24,'Kabupaten Nunukan'),
(300,24,'Kabupaten Tana Tidung'),
(301,25,'Kabupaten Bolaang Mongondow'),
(302,25,'Kabupaten Bolaang Mongondow Selatan'),
(303,25,'Kabupaten Bolaang Mongondow Timur'),
(304,25,'Kabupaten Bolaang Mongondow Utara'),
(305,25,'Kabupaten Kepulauan Sangihe'),
(306,25,'Kabupaten Kepulauan Talaud'),
(307,25,'Kabupaten Minahasa'),
(309,25,'Kabupaten Minahasa Selatan'),
(310,25,'Kabupaten Minahasa Tenggara'),
(311,25,'Kabupaten Minahasa Utara'),
(312,25,'Kabupaten Siau Tagulandang Biaro'),
(313,26,'Kabupaten Boalemo'),
(314,26,'Kabupaten Bone Bolango'),
(315,26,'Kabupaten Gorontalo'),
(316,26,'Kabupaten Gorontalo Utara'),
(317,26,'Kabupaten Pahuwato'),
(318,27,'Kabupaten Banggai'),
(319,27,'Kabupaten Banggai Kepulauan'),
(320,27,'Kabupaten Banggai Laut'),
(321,27,'Kabupaten Buol'),
(322,27,'Kabupaten Donggala'),
(323,27,'Kabupaten Morowali'),
(324,27,'Kabupaten Morowali Utara'),
(325,27,'Kabupaten Parigi Moutong'),
(326,27,'Kabupaten Poso'),
(327,27,'Kabupaten Sigi'),
(328,27,'Kabupaten Tojo Una-una'),
(329,27,'Kabupaten Tolitoli'),
(330,28,'Kabupaten Majene'),
(331,28,'Kabupaten Mamasa'),
(332,28,'Kabupaten Mamuju'),
(333,28,'Kabupaten Mamuju Tengah'),
(334,28,'Kabupaten Pasangkayu'),
(335,28,'Kabupaten Poliwali Mandar'),
(336,29,'Kabupaten Bantaeng'),
(337,29,'Kabupaten Barru'),
(338,29,'Kabupaten Bone'),
(339,29,'Kabupaten Bulukumba'),
(340,29,'Kabupaten Enrekang'),
(341,29,'Kabupaten Gowa'),
(342,29,'Kabupaten Jeneponto'),
(343,29,'Kabupaten Kepulauan Selayar'),
(344,29,'Kabupaten Luwu'),
(345,29,'Kabupaten Luwu Timur'),
(346,29,'Kabupaten Luwu Utara'),
(347,29,'Kabupaten Maros'),
(348,29,'Kabupaten Pangkajene dan Kepulauan'),
(349,29,'Kabupaten Pinrang'),
(350,29,'Kabupaten Sidenreng Rappang'),
(351,29,'Kabupaten Sinjai'),
(352,29,'Kabupaten Soppeng'),
(353,29,'Kabupaten Takalar'),
(354,29,'Kabupaten Takalar'),
(355,29,'Kabupaten Toraja Utara'),
(356,29,'Kabupaten Wajo'),
(357,30,'Kabupaten Bombana'),
(358,30,'Kabupaten Buton'),
(359,30,'Kabupaten Buton Selatan'),
(360,30,'Kabupaten Buton Tengah'),
(361,30,'Kabupaten Buton Utara'),
(362,30,'Kabupaten Kolaka	'),
(363,30,'Kabupaten Kolaka Timur'),
(365,30,'Kabupaten Kolaka Utara'),
(366,30,'Kabupaten Konawe'),
(367,30,'Kabupaten Konawe Kepulauan'),
(368,30,'Kabupaten Konawe Selatan'),
(369,30,'Kabupaten Konawe Utara'),
(370,30,'Kabupaten Muna'),
(371,30,'Kabupaten Muna Barat'),
(372,30,'Kabupaten Wakatobi'),
(373,31,'Kabupaten Halmahera Barat'),
(374,31,'Kabupaten Halmahera Selatan'),
(375,31,'Kabupaten Halmahera Tengah'),
(376,31,'Kabupaten Halmahera Timur'),
(377,31,'Kabupaten Halmahera Utara'),
(378,31,'Kabupaten Kepulauan Sula'),
(379,31,'Kabupaten Pulau Morotai'),
(380,31,'Kabupaten Pulau Taliabu'),
(381,32,'Kabupaten Halmahera Barat'),
(382,32,'Kabupaten Halmahera Selatan'),
(383,32,'Kabupaten Halmahera Tengah'),
(384,32,'Kabupaten Halmahera Timur'),
(385,32,'Kabupaten Halmahera Utara'),
(386,32,'Kabupaten Kepulauan Sula'),
(387,32,'Kabupaten Pulau Morotai'),
(388,32,'Kabupaten Pulau Taliabu');

/*Table structure for table `keluarga` */

DROP TABLE IF EXISTS `keluarga`;

CREATE TABLE `keluarga` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `tipe_hubungan` enum('Ayah','Ibu','Saudara','Suami','Istri','Anak') NOT NULL,
  `jenis_kelamin` enum('Pria','Wanita') NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `pendidikan` varchar(255) NOT NULL,
  `pekerjaan` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_keluarga_reference_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `from_keluarga_reference_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `keluarga` */

/*Table structure for table `kontak_darurat` */

DROP TABLE IF EXISTS `kontak_darurat`;

CREATE TABLE `kontak_darurat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `hubungan` varchar(255) NOT NULL,
  `alamat_rumah` text NOT NULL,
  `no_telp_rumah` varchar(255) NOT NULL,
  `no_telp_kantor` varchar(255) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_kontak_darurat_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_kontak_darurat_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `kontak_darurat` */

/*Table structure for table `lokakarya` */

DROP TABLE IF EXISTS `lokakarya`;

CREATE TABLE `lokakarya` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `nama_seminar` varchar(255) NOT NULL,
  `lokasi_penyelenggaraan` varchar(255) NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_lokakarya_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_lokakarya_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `lokakarya` */

insert  into `lokakarya`(`id`,`id_pegawai`,`nama_seminar`,`lokasi_penyelenggaraan`,`tanggal_mulai`,`tanggal_selesai`,`created_at`) values 
(1,1,'Menjadi Android Developer Expert','Online','2021-04-01','2021-04-03','2021-04-15 10:30:13');

/*Table structure for table `pegawai` */

DROP TABLE IF EXISTS `pegawai`;

CREATE TABLE `pegawai` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_kabupaten` int(11) NOT NULL,
  `nik` int(11) unsigned NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `nama_panggilan` varchar(255) NOT NULL,
  `nktp` varchar(255) NOT NULL,
  `nohp` varchar(255) NOT NULL,
  `jenis_kelamin` enum('Pria','Wanita') NOT NULL,
  `tempat_lahir` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `agama` enum('Islam','Protestan','Katolik','Hindu','Budha','Lainnya') NOT NULL,
  `status_perkawinan` enum('Kawin','Belum Kawin','Cerai Hidup','Cerai Mati') NOT NULL,
  `kewarganegaraan` enum('WNI','WNA') NOT NULL,
  `golongan_darah` enum('A','B','AB','O') NOT NULL,
  `bahasa` varchar(255) NOT NULL,
  `suku` varchar(255) NOT NULL,
  `daerah_asal` varchar(255) NOT NULL,
  `tanggal_mulai_bekerja` date NOT NULL,
  `level` varchar(255) NOT NULL,
  `divisi` varchar(255) NOT NULL,
  `seksi` varchar(255) NOT NULL,
  `bagian` varchar(255) NOT NULL,
  `status_karyawan` enum('PKWTT','PKWT','PKWT MUSIMAN','PKWT PRODUK BARU','KONTRAK','HARIAN LEPAS') NOT NULL,
  `tanggal_pengangkatan` date NOT NULL,
  `no_rekening` varchar(255) NOT NULL,
  `no_bpjs_kesehatan` varchar(255) NOT NULL,
  `no_bpjs_ketenagakerjaan` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX` (`nik`),
  KEY `from_pegawai_to_kabupaten_using_id_kabupaten` (`id_kabupaten`),
  CONSTRAINT `from_pegawai_to_kabupaten_using_id_kabupaten` FOREIGN KEY (`id_kabupaten`) REFERENCES `kabupaten` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pegawai` */

insert  into `pegawai`(`id`,`id_kabupaten`,`nik`,`nama_lengkap`,`nama_panggilan`,`nktp`,`nohp`,`jenis_kelamin`,`tempat_lahir`,`tanggal_lahir`,`agama`,`status_perkawinan`,`kewarganegaraan`,`golongan_darah`,`bahasa`,`suku`,`daerah_asal`,`tanggal_mulai_bekerja`,`level`,`divisi`,`seksi`,`bagian`,`status_karyawan`,`tanggal_pengangkatan`,`no_rekening`,`no_bpjs_kesehatan`,`no_bpjs_ketenagakerjaan`,`created_at`) values 
(1,22,201403186,'Mohamad Novriyanto Ali','Rhein','7503030711920001','082219193211','Pria','suwawa','1992-11-07','Islam','Kawin','WNI','O','indonesia','gorontalo','gorontalo','2018-03-18','staf','belum berlaku','belum berlaku','it','PKWT','2021-06-25','34123124143','413421321321','542342342342342','2021-04-15 10:29:11');

/*Table structure for table `pendidikan` */

DROP TABLE IF EXISTS `pendidikan`;

CREATE TABLE `pendidikan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `tingkat_pendidikan` enum('SD','SMP','SMA/SMK','Akademi','Universitas') NOT NULL,
  `nama_sekolah` varchar(255) NOT NULL,
  `tempat` varchar(255) NOT NULL,
  `jurusan` varchar(255) NOT NULL,
  `tahun_lulus` year(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_pendidikan_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_pendidikan_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pendidikan` */

/*Table structure for table `pengalaman_kerja` */

DROP TABLE IF EXISTS `pengalaman_kerja`;

CREATE TABLE `pengalaman_kerja` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `dari_tahun` year(4) NOT NULL,
  `sampai_tahun` year(4) NOT NULL,
  `nama_perusahaan` varchar(244) NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `alasan_berhenti` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_pengalaman_kerja_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_pengalaman_kerja_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pengalaman_kerja` */

/*Table structure for table `penghargaan` */

DROP TABLE IF EXISTS `penghargaan`;

CREATE TABLE `penghargaan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `jenis_penghargaan` varchar(255) NOT NULL,
  `tanggal_diterima` date NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_penghargaan_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_penghargaan_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penghargaan` */

/*Table structure for table `provinsi` */

DROP TABLE IF EXISTS `provinsi`;

CREATE TABLE `provinsi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_provinsi` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

/*Data for the table `provinsi` */

insert  into `provinsi`(`id`,`nama_provinsi`,`created_at`) values 
(1,'Aceh','2021-04-14 14:55:01'),
(2,'Sumatera Utara','2021-04-14 14:55:01'),
(3,'Sumatera Barat','2021-04-14 14:55:01'),
(4,'Riau','2021-04-14 14:55:01'),
(5,'Kepulauan Riau','2021-04-14 14:55:01'),
(6,'Jambi','2021-04-14 14:55:01'),
(7,'Sumatera Selatan','2021-04-14 14:55:01'),
(8,'Kepulauan Bangka Belitung','2021-04-14 14:55:01'),
(9,'Bengkulu','2021-04-14 14:55:01'),
(10,'Lampung','2021-04-14 14:55:01'),
(11,'DKI Jakarta','2021-04-14 14:55:01'),
(12,'Banten','2021-04-14 14:55:01'),
(13,'Jawa Barat','2021-04-14 14:55:01'),
(14,'Jawa Tengah','2021-04-14 14:55:01'),
(15,'DI Yogyakarta','2021-04-14 14:55:01'),
(16,'Jawa Timur','2021-04-14 14:55:14'),
(17,'Bali','2021-04-14 14:55:45'),
(18,'Nusa Tenggara Barat','2021-04-14 14:59:31'),
(19,'Nusa Tenggara Timur ','2021-04-14 15:00:10'),
(20,'Kalimantan Barat','2021-04-14 15:00:30'),
(21,'Kalimantan Tengah ','2021-04-14 15:00:54'),
(22,'Kalimantan Selatan ','2021-04-14 15:01:13'),
(23,'Kalimantan Timur','2021-04-14 15:33:39'),
(24,'Kalimantan Utara','2021-04-14 15:34:11'),
(25,'Sulawesi Utara ','2021-04-14 15:34:41'),
(26,'Gorontalo','2021-04-14 15:35:06'),
(27,'Sulawesi Tengah','2021-04-14 15:35:53'),
(28,'Sulawesi Barat ','2021-04-14 15:36:11'),
(29,'Sulawesi Selatan','2021-04-14 15:36:35'),
(30,'Sulawesi Tenggara','2021-04-14 15:36:59'),
(31,'Maluku','2021-04-14 15:37:17'),
(32,'Maluku Utara','2021-04-14 15:37:33'),
(33,'Papua Barat','2021-04-14 15:37:50'),
(34,'Papua ','2021-04-14 15:38:06');

/*Table structure for table `speringatan` */

DROP TABLE IF EXISTS `speringatan`;

CREATE TABLE `speringatan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `jenis_sp` varchar(255) NOT NULL,
  `tanggal_dikeluarkan` date NOT NULL,
  `masa_berlaku` varchar(255) NOT NULL,
  `kesalahan` text NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `speringatan` */

/*Table structure for table `teguran` */

DROP TABLE IF EXISTS `teguran`;

CREATE TABLE `teguran` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pegawai` int(11) unsigned NOT NULL,
  `jenis_pelanggaran` varchar(255) NOT NULL,
  `tanggal_dikeluarkan` date NOT NULL,
  `kesalahan` varchar(255) NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_from_teguran_to_pegawai_using_id_pegawai` (`id_pegawai`),
  CONSTRAINT `fk_from_teguran_to_pegawai_using_id_pegawai` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `teguran` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `id_telegram` int(11) unsigned NOT NULL,
  `nik` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
