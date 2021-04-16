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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `absen` */

insert  into `absen`(`id`,`id_pegawai`,`tipe`,`dari_tanggal`,`sampai_tanggal`,`keterangan`,`created_at`) values 
(1,1,'Ijin','2021-04-18','2021-04-19','ok bri','2021-04-16 14:32:32'),
(2,1,'Mangkir','2021-04-20','2021-04-20','mangkir utiz','2021-04-16 15:55:02');

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=latin1;

/*Data for the table `kabupaten` */

insert  into `kabupaten`(`id`,`id_provinsi`,`nama_kabupaten`,`created_at`) values 
(1,1,'Kabupaten Aceh Barat','2021-04-16 09:28:26'),
(2,1,'Kabupaten Aceh Barat Daya','2021-04-16 09:28:26'),
(3,1,'Kabupaten Aceh Besar','2021-04-16 09:28:26'),
(4,1,'Kabupaten Aceh Jaya','2021-04-16 09:28:26'),
(5,1,'Kabupaten Aceh Selatan','2021-04-16 09:28:26'),
(6,1,'Kabupaten Aceh Singkil','2021-04-16 09:28:26'),
(7,1,'Kabupaten Aceh Tamiang','2021-04-16 09:28:26'),
(8,1,'Kabupaten Aceh Tengah','2021-04-16 09:28:26'),
(9,1,'Kabupaten Aceh Tenggara','2021-04-16 09:28:26'),
(10,1,'Kabupaten Aceh Timur','2021-04-16 09:28:26'),
(11,1,'Kabupaten Aceh Utara','2021-04-16 09:28:26'),
(12,1,'Kabupaten Bener Meriah','2021-04-16 09:28:26'),
(13,1,'Kabupaten Bireuen','2021-04-16 09:28:26'),
(14,1,'Kabupaten Gayo Lues','2021-04-16 09:28:26'),
(15,1,'Kabupaten Nagan Raya','2021-04-16 09:28:26'),
(16,1,'Kabupaten Pidie','2021-04-16 09:28:26'),
(17,1,'Kabupaten Pidie Jaya','2021-04-16 09:28:26'),
(18,1,'Kabupaten Simeulue','2021-04-16 09:28:26'),
(19,2,'Kabupaten Asahan','2021-04-16 09:28:26'),
(20,2,'Kabupaten Batu Bara','2021-04-16 09:28:26'),
(21,2,'Kabupaten Dairi','2021-04-16 09:28:26'),
(22,2,'Kabupaten Deli Serdang','2021-04-16 09:28:26'),
(23,2,'Kabupaten Humbang Hasundutan','2021-04-16 09:28:26'),
(24,2,'Kabupaten Karo','2021-04-16 09:28:26'),
(25,2,'Kabupaten Labuhanbatu','2021-04-16 09:28:26'),
(26,2,'Kabupaten Labuhanbatu Selatan','2021-04-16 09:28:26'),
(27,2,'Kabupaten Labuhanbatu Utara','2021-04-16 09:28:26'),
(28,2,'Kabupaten Langkat','2021-04-16 09:28:26'),
(29,2,'Kabupaten Mandailing Natal','2021-04-16 09:28:26'),
(30,2,'Kabupaten Nias','2021-04-16 09:28:26'),
(31,2,'Kabupaten Nias Barat','2021-04-16 09:28:26'),
(32,2,'Kabupaten Nias Selatan','2021-04-16 09:28:26'),
(33,2,'Kabupaten Nias Utara','2021-04-16 09:28:26'),
(34,2,'Kabupaten Padang Lawas','2021-04-16 09:28:26'),
(35,2,'Kabupaten Padang Lawas Utara','2021-04-16 09:28:26'),
(36,2,'Kabupaten Pakpak Bharat','2021-04-16 09:28:26'),
(37,2,'Kabupaten Samosir','2021-04-16 09:28:26'),
(38,2,'Kabupaten Serdang Bedagai','2021-04-16 09:28:26'),
(39,2,'Kabupaten Simalungun','2021-04-16 09:28:26'),
(40,2,'Kabupaten Tapanuli Selatan','2021-04-16 09:28:26'),
(41,2,'Kabupaten Tapanuli Tengah','2021-04-16 09:28:26'),
(42,2,'Kabupaten Tapanuli Utara','2021-04-16 09:28:26'),
(43,2,'Kabupaten Toba Samosir','2021-04-16 09:28:26'),
(44,3,'Kabupaten Agam','2021-04-16 09:28:26'),
(45,3,'Kabupaten Dharmasraya','2021-04-16 09:28:26'),
(46,3,'Kabupaten Kepulauan Mentawai','2021-04-16 09:28:26'),
(47,3,'Kabupaten Lima Puluh Kota','2021-04-16 09:28:26'),
(48,3,'Kabupaten Padang Pariaman','2021-04-16 09:28:26'),
(49,3,'Kabupaten Pasaman','2021-04-16 09:28:26'),
(50,3,'Kabupaten Pasaman Barat','2021-04-16 09:28:26'),
(51,3,'Kabupaten Pesisir Selatan','2021-04-16 09:28:26'),
(52,3,'Kabupaten Sijunjung','2021-04-16 09:28:26'),
(53,3,'Kabupaten Solok','2021-04-16 09:28:26'),
(54,3,'Kabupaten Solok Selatan','2021-04-16 09:28:26'),
(55,3,'Kabupaten Tanah Datar','2021-04-16 09:28:26'),
(56,4,'Kabupaten Bengkalis','2021-04-16 09:28:26'),
(57,4,'Kabupaten Indragiri Hilir','2021-04-16 09:28:26'),
(58,4,'Kabupaten Indragiri Hulu','2021-04-16 09:28:26'),
(59,4,'Kabupaten Kampar','2021-04-16 09:28:26'),
(60,4,'Kabupaten Kepulauan Meranti','2021-04-16 09:28:26'),
(61,4,'Kabupaten Kuantan Singingi','2021-04-16 09:28:26'),
(62,4,'Kabupaten Pelalawan','2021-04-16 09:28:26'),
(63,4,'Kabupaten Rokan Hilir','2021-04-16 09:28:26'),
(64,4,'Kabupaten Rokan Hulu','2021-04-16 09:28:26'),
(65,4,'Kabupaten Siak','2021-04-16 09:28:26'),
(66,5,'Kabupaten Bintan','2021-04-16 09:28:26'),
(67,5,'Kabupaten Karimun','2021-04-16 09:28:26'),
(68,5,'Kabupaten Kepulauan Anambas','2021-04-16 09:28:26'),
(69,5,'Kabupaten Lingga','2021-04-16 09:28:26'),
(70,5,'Kabupaten Natuna','2021-04-16 09:28:26'),
(71,6,'Kabupaten Batanghari','2021-04-16 09:28:26'),
(72,6,'Kabupaten Bungo','2021-04-16 09:28:26'),
(73,6,'Kabupaten Kerinci','2021-04-16 09:28:26'),
(74,6,'Kabupaten Merangin','2021-04-16 09:28:26'),
(75,6,'Kabupaten Muaro Jambi','2021-04-16 09:28:26'),
(76,6,'Kabupaten Sarolangun','2021-04-16 09:28:26'),
(77,6,'Kabupaten Tanjung Jabung Barat','2021-04-16 09:28:26'),
(78,6,'Kabupaten Tanjung Jabung Timur','2021-04-16 09:28:26'),
(79,6,'Kabupaten Tebo','2021-04-16 09:28:26'),
(82,7,'Kabupaten Banyuasin','2021-04-16 09:28:26'),
(83,7,'Kabupaten Empat Lawang','2021-04-16 09:28:26'),
(84,7,'Kabupaten Lahat','2021-04-16 09:28:26'),
(85,7,'Kabupaten Muara Enim','2021-04-16 09:28:26'),
(86,7,'Kabupaten Musi Banyuasin	','2021-04-16 09:28:26'),
(87,7,'Kabupaten Musi Rawas	','2021-04-16 09:28:26'),
(88,7,'Kabupaten Musi Rawas Utara	','2021-04-16 09:28:26'),
(89,7,'Kabupaten Ogan Ilir	','2021-04-16 09:28:26'),
(90,7,'Kabupaten Ogan Komering Ilir	','2021-04-16 09:28:26'),
(91,7,'Kabupaten Ogan Komering Ulubupaten','2021-04-16 09:28:26'),
(92,7,'Kabupaten Ogan Komering Ulu Selatan','2021-04-16 09:28:26'),
(93,7,'Kabupaten Ogan Komering Ulu Timur','2021-04-16 09:28:26'),
(94,7,'Kabupaten Penukal Abab Lematang Ilir','2021-04-16 09:28:26'),
(95,8,'Kabupaten Bangka','2021-04-16 09:28:26'),
(96,8,'Kabupaten Bangka Barat','2021-04-16 09:28:26'),
(97,8,'Kabupaten Bangka Selatan','2021-04-16 09:28:26'),
(98,8,'Kabupaten Bangka Tengah','2021-04-16 09:28:26'),
(99,8,'Kabupaten Belitung','2021-04-16 09:28:26'),
(100,8,'Kabupaten Belitung Timur','2021-04-16 09:28:26'),
(101,9,'Kabupaten Bengkulu Selatan','2021-04-16 09:28:26'),
(102,9,'Kabupaten Bengkulu Tengah','2021-04-16 09:28:26'),
(103,9,'Kabupaten Bengkulu Utara','2021-04-16 09:28:26'),
(104,9,'Kabupaten Kaur','2021-04-16 09:28:26'),
(105,9,'Kabupaten Kepahiang','2021-04-16 09:28:26'),
(106,9,'Kabupaten Lebong','2021-04-16 09:28:26'),
(107,9,'Kabupaten Mukomuko','2021-04-16 09:28:26'),
(108,9,'Kabupaten  Rejang Lebong','2021-04-16 09:28:26'),
(109,9,'Kabupaten Seluma','2021-04-16 09:28:26'),
(110,10,'Kabupaten Lampung Barat','2021-04-16 09:28:26'),
(111,10,'Kabupaten Lampung Selatan','2021-04-16 09:28:26'),
(112,10,'Kabupaten Lampung Tengah','2021-04-16 09:28:26'),
(113,10,'Kabupaten Lampung Timur','2021-04-16 09:28:26'),
(114,10,'Kabupaten Lampung Utara','2021-04-16 09:28:26'),
(115,10,'Kabupaten Mesuji','2021-04-16 09:28:26'),
(116,10,'Kabupaten Pesawaran','2021-04-16 09:28:26'),
(117,10,'Kabupaten Pesisir Barat','2021-04-16 09:28:26'),
(118,10,'Kabupaten Pringsewu','2021-04-16 09:28:26'),
(119,10,'Kabupaten Tenggamus','2021-04-16 09:28:26'),
(120,10,'Kabupaten Tulang Bawang','2021-04-16 09:28:26'),
(121,10,'Kabupaten Tulang Bawang Barat','2021-04-16 09:28:26'),
(123,10,'Kabupaten Way Kanan','2021-04-16 09:28:26'),
(124,11,'Kabupaten Administrasi Kepulauan Seribu','2021-04-16 09:28:26'),
(125,11,'Kota Administrasi Jakarta Barat','2021-04-16 09:28:26'),
(126,11,'Kota Administrasi Jakarta Pusat','2021-04-16 09:28:26'),
(127,11,'Kota Administrasi Jakarta Selatan','2021-04-16 09:28:26'),
(128,11,'Kota Administrasi Jakarta Timur','2021-04-16 09:28:26'),
(129,11,'Kota Administrasi Jakarta Utara','2021-04-16 09:28:26'),
(130,12,'Kabupaten Lebak','2021-04-16 09:28:26'),
(131,12,'Kabupaten Serang','2021-04-16 09:28:26'),
(132,12,'Kabupaten Tangerang','2021-04-16 09:28:26'),
(133,12,'Kota Cilegon','2021-04-16 09:28:26'),
(134,12,'Kota Serang','2021-04-16 09:28:26'),
(135,12,'Kota Tangerang','2021-04-16 09:28:26'),
(136,12,'Kota Tangerang Selatan','2021-04-16 09:28:26'),
(137,12,'Kabupaten Pandegelang','2021-04-16 09:28:26'),
(138,13,'Kabupaten Bandung','2021-04-16 09:28:26'),
(139,13,'Kabupaten Bandung Barat','2021-04-16 09:28:26'),
(140,13,'Kabupaten Bekasi','2021-04-16 09:28:26'),
(141,13,'Kabupaten Bogor','2021-04-16 09:28:26'),
(142,13,'Kabupaten Ciamis','2021-04-16 09:28:26'),
(143,13,'Kabupaten Cianjur','2021-04-16 09:28:26'),
(144,13,'Kabupaten Cirebon','2021-04-16 09:28:26'),
(145,13,'Kabupaten Garut','2021-04-16 09:28:26'),
(146,13,'Kabupaten Indramayu','2021-04-16 09:28:26'),
(147,13,'Kabupaten Karawang','2021-04-16 09:28:26'),
(148,13,'Kabupaten Kuningan','2021-04-16 09:28:26'),
(149,13,'Kabupaten Majalengka','2021-04-16 09:28:26'),
(150,13,'Kabupaten Pangandaran','2021-04-16 09:28:26'),
(151,13,'Kabupaten Purwakarta','2021-04-16 09:28:26'),
(152,13,'Kabupaten Subang','2021-04-16 09:28:26'),
(153,13,'Kabupaten Sukabumi','2021-04-16 09:28:26'),
(154,13,'Kabupaten Sumedang','2021-04-16 09:28:26'),
(155,13,'Kabupaten Tasikmalaya','2021-04-16 09:28:26'),
(156,14,'Kabupaten Banjarnegara','2021-04-16 09:28:26'),
(157,14,'Kabupaten Banyumas','2021-04-16 09:28:26'),
(158,14,'Kabupaten Batang','2021-04-16 09:28:26'),
(159,14,'Kabupaten Blora','2021-04-16 09:28:26'),
(160,14,'Kabupaten Boyolali','2021-04-16 09:28:26'),
(161,14,'Kabupaten Brebes','2021-04-16 09:28:26'),
(162,14,'Kabupaten Cilacap','2021-04-16 09:28:26'),
(163,14,'Kabupaten Demak','2021-04-16 09:28:26'),
(164,14,'Kabupaten Grobogan','2021-04-16 09:28:26'),
(165,14,'Kabupaten Jepara','2021-04-16 09:28:26'),
(166,14,'Kabupaten Karanganyar','2021-04-16 09:28:26'),
(167,14,'Kabupaten Kebumen','2021-04-16 09:28:26'),
(168,14,'Kabupaten Kendal','2021-04-16 09:28:26'),
(169,14,'Kabupaten Klaten','2021-04-16 09:28:26'),
(170,14,'Kabupaten Kudus','2021-04-16 09:28:26'),
(171,14,'Kabupaten Magelang','2021-04-16 09:28:26'),
(172,14,'Kabupaten Pati','2021-04-16 09:28:26'),
(173,14,'Kabupaten Pekalongan','2021-04-16 09:28:26'),
(174,14,'Kabupaten Pemalang','2021-04-16 09:28:26'),
(175,14,'Kabupaten Purbalingga','2021-04-16 09:28:26'),
(176,14,'Kabupaten Purworejo','2021-04-16 09:28:26'),
(177,14,'Kabupaten Rembang','2021-04-16 09:28:26'),
(178,14,'Kabupaten Semarang','2021-04-16 09:28:26'),
(179,14,'Kabupaten Sragen','2021-04-16 09:28:26'),
(180,14,'Kabupaten Sukoharjo','2021-04-16 09:28:26'),
(181,14,'Kabupaten Tegal','2021-04-16 09:28:26'),
(182,14,'Kabupaten Temanggung','2021-04-16 09:28:26'),
(183,14,'Kabupaten Wonogiri','2021-04-16 09:28:26'),
(184,14,'Kabupaten Wonosobo','2021-04-16 09:28:26'),
(185,15,'Kabupaten Bantul','2021-04-16 09:28:26'),
(186,15,'Kabupaten Gunung Kidul','2021-04-16 09:28:26'),
(187,15,'Kabupaten Kulon Progo','2021-04-16 09:28:26'),
(188,15,'Kabupaten Sleman	','2021-04-16 09:28:26'),
(189,16,'Kabupaten Bangkalan','2021-04-16 09:28:26'),
(190,16,'Kabupaten Banyuwangi','2021-04-16 09:28:26'),
(191,16,'Kabupaten Blitar','2021-04-16 09:28:26'),
(192,16,'Kabupaten Bojonegoro','2021-04-16 09:28:26'),
(193,16,'Kabupaten Bondowoso','2021-04-16 09:28:26'),
(194,16,'Kabupaten Gresik','2021-04-16 09:28:26'),
(195,16,'Kabupaten Jember','2021-04-16 09:28:26'),
(196,16,'Kabupaten Jombang','2021-04-16 09:28:26'),
(197,16,'Kabupaten Kediri','2021-04-16 09:28:26'),
(198,16,'Kabupaten Lamongan','2021-04-16 09:28:26'),
(199,16,'Kabupaten Lumajang','2021-04-16 09:28:26'),
(200,16,'Kabupaten Madiun','2021-04-16 09:28:26'),
(201,16,'Kabupaten Magetan','2021-04-16 09:28:26'),
(202,16,'Kabupaten Malang','2021-04-16 09:28:26'),
(203,16,'Kabupaten Mojokerto','2021-04-16 09:28:26'),
(204,16,'Kabupaten Nganjuk','2021-04-16 09:28:26'),
(205,16,'Kabupaten Ngawi','2021-04-16 09:28:26'),
(206,16,'Kabupaten Pacitan','2021-04-16 09:28:26'),
(207,16,'Kabupaten Pamekasan','2021-04-16 09:28:26'),
(208,16,'	Kabupaten Pasuruan','2021-04-16 09:28:26'),
(209,16,'Kabupaten Ponorogo','2021-04-16 09:28:26'),
(210,16,'Kabupaten Probolinggo','2021-04-16 09:28:26'),
(211,16,'Kabupaten Sampang','2021-04-16 09:28:26'),
(212,16,'Kabupaten Sidoarjo','2021-04-16 09:28:26'),
(213,16,'Kabupaten Situbondo','2021-04-16 09:28:26'),
(214,16,'Kabupaten Sumenep','2021-04-16 09:28:26'),
(215,16,'Kabupaten Trenggalek','2021-04-16 09:28:26'),
(216,16,'Kabupaten Tuban','2021-04-16 09:28:26'),
(217,16,'Kabupaten Tulungagung','2021-04-16 09:28:26'),
(218,17,'Kabupaten Badung','2021-04-16 09:28:26'),
(219,17,'Kabupaten Bangli','2021-04-16 09:28:26'),
(220,17,'	Kabupaten Buleleng	','2021-04-16 09:28:26'),
(221,17,'Kabupaten Gianyar','2021-04-16 09:28:26'),
(222,17,'Kabupaten Jembrana','2021-04-16 09:28:26'),
(223,17,'Kabupaten Karangasem','2021-04-16 09:28:26'),
(224,17,'Kabupaten Klungkung','2021-04-16 09:28:26'),
(225,17,'Kabupaten Tabanan','2021-04-16 09:28:26'),
(226,18,'Kabupaten Bima','2021-04-16 09:28:26'),
(227,18,'	Kabupaten Dompu','2021-04-16 09:28:26'),
(228,18,'Kabupaten Lombok Barat','2021-04-16 09:28:26'),
(229,18,'Kabupaten Lombok Tengah','2021-04-16 09:28:26'),
(230,18,'Kabupaten Lombok Timur','2021-04-16 09:28:26'),
(231,18,'Kabupaten Lombok Utara','2021-04-16 09:28:26'),
(232,18,'Kabupaten Sumbawa','2021-04-16 09:28:26'),
(233,18,'Kabupaten Sumbawa Barat','2021-04-16 09:28:26'),
(234,19,'Kabupaten Alor','2021-04-16 09:28:26'),
(235,19,'Kabupaten Belu','2021-04-16 09:28:26'),
(236,19,'Kabupaten Ende','2021-04-16 09:28:26'),
(237,19,'Kabupaten Flores Timur','2021-04-16 09:28:26'),
(238,19,'Kabupaten Kupang','2021-04-16 09:28:26'),
(239,19,'Kabupaten Lembata','2021-04-16 09:28:26'),
(240,19,'Kabupaten Malaka','2021-04-16 09:28:26'),
(241,19,'Kabupaten Manggarai','2021-04-16 09:28:26'),
(242,19,'Kabupaten Manggarai Barat','2021-04-16 09:28:26'),
(243,19,'Kabupaten Manggarai Timur','2021-04-16 09:28:26'),
(244,19,'Kabupaten Nagekeo','2021-04-16 09:28:26'),
(245,19,'Kabupaten Ngada','2021-04-16 09:28:26'),
(246,19,'Kabupaten Rote Ndao','2021-04-16 09:28:26'),
(247,19,'Kabupaten Sabu Raijua','2021-04-16 09:28:26'),
(248,19,'Kabupaten Sikka','2021-04-16 09:28:26'),
(249,19,'Kabupaten Sumba Barat','2021-04-16 09:28:26'),
(250,19,'Kabupaten Sumba Barat Daya','2021-04-16 09:28:26'),
(251,19,'Kabupaten Sumba Tengah','2021-04-16 09:28:26'),
(252,19,'Kabupaten Sumba Timur','2021-04-16 09:28:26'),
(253,19,'Kabupaten Timor Tengah Selatan','2021-04-16 09:28:26'),
(255,19,'Kabupaten Timor Tengah Utara','2021-04-16 09:28:26'),
(256,20,'Kabupaten Bengayang','2021-04-16 09:28:26'),
(257,20,'Kabupaten Kapuas Hulu','2021-04-16 09:28:26'),
(259,20,'Kabupaten Kayong Utara','2021-04-16 09:28:26'),
(260,20,'Kabupaten Ketapang','2021-04-16 09:28:26'),
(261,20,'Kabupaten Kubu Raya','2021-04-16 09:28:26'),
(262,20,'Kabupaten Landak','2021-04-16 09:28:26'),
(263,20,'Kabupaten Melawi','2021-04-16 09:28:26'),
(264,21,'Kabupaten Barito Selatan','2021-04-16 09:28:26'),
(265,21,'Kabupaten Barito Timur','2021-04-16 09:28:26'),
(266,21,'Kabupaten Barito Utara','2021-04-16 09:28:26'),
(267,21,'Kabupaten Gunung Mas	','2021-04-16 09:28:26'),
(268,21,'Kabupaten Kapuas	','2021-04-16 09:28:26'),
(269,21,'Kabupaten Katingan	','2021-04-16 09:28:26'),
(270,21,'Kabupaten Kotawaringin Barat	','2021-04-16 09:28:26'),
(271,21,'Kabupaten Kotawaringin Timur	','2021-04-16 09:28:26'),
(272,21,'Kabupaten Lamandau	','2021-04-16 09:28:26'),
(273,21,'Kabupaten Murung Raya	','2021-04-16 09:28:26'),
(274,21,'Kabupaten Pulang Pisau	','2021-04-16 09:28:26'),
(275,21,'Kabupaten Seruyan	','2021-04-16 09:28:26'),
(276,21,'Kabupaten Sukamara	','2021-04-16 09:28:26'),
(277,22,'Kabupaten Balangan','2021-04-16 09:28:26'),
(278,22,'Kabupaten Banjar','2021-04-16 09:28:26'),
(279,22,'Kabupaten Barito Kuala','2021-04-16 09:28:26'),
(280,22,'Kabupaten Hulu Sungai Selatan','2021-04-16 09:28:26'),
(281,22,'Kabupaten Hulu Sungai Tengah','2021-04-16 09:28:26'),
(282,22,'Kabupaten Hulu Sungai Utara','2021-04-16 09:28:26'),
(283,22,'Kabupaten Kotabaru','2021-04-16 09:28:26'),
(284,22,'Kabupaten Tabalong','2021-04-16 09:28:26'),
(285,22,'Kabupaten Tanah Bumbu','2021-04-16 09:28:26'),
(287,22,'Kabupaten Tanah Laut','2021-04-16 09:28:26'),
(288,22,'Kabupaten Tapin','2021-04-16 09:28:26'),
(289,23,'Kabupaten Berau','2021-04-16 09:28:26'),
(290,23,'Kabupaten Kutai Barat','2021-04-16 09:28:26'),
(291,23,'Kabupaten Kutai Kartanegara','2021-04-16 09:28:26'),
(292,23,'Kabupaten Kutai Timur','2021-04-16 09:28:26'),
(293,23,'Kabupaten Mahakam Ulu','2021-04-16 09:28:26'),
(294,23,'Kabupaten Panajam Paser Utara','2021-04-16 09:28:26'),
(295,23,'Kabupaten Paser','2021-04-16 09:28:26'),
(297,24,'Kabupaten Bulungan','2021-04-16 09:28:26'),
(298,24,'Kabupaten Malinau','2021-04-16 09:28:26'),
(299,24,'Kabupaten Nunukan','2021-04-16 09:28:26'),
(300,24,'Kabupaten Tana Tidung','2021-04-16 09:28:26'),
(301,25,'Kabupaten Bolaang Mongondow','2021-04-16 09:28:26'),
(302,25,'Kabupaten Bolaang Mongondow Selatan','2021-04-16 09:28:26'),
(303,25,'Kabupaten Bolaang Mongondow Timur','2021-04-16 09:28:26'),
(304,25,'Kabupaten Bolaang Mongondow Utara','2021-04-16 09:28:26'),
(305,25,'Kabupaten Kepulauan Sangihe','2021-04-16 09:28:26'),
(306,25,'Kabupaten Kepulauan Talaud','2021-04-16 09:28:26'),
(307,25,'Kabupaten Minahasa','2021-04-16 09:28:26'),
(309,25,'Kabupaten Minahasa Selatan','2021-04-16 09:28:26'),
(310,25,'Kabupaten Minahasa Tenggara','2021-04-16 09:28:26'),
(311,25,'Kabupaten Minahasa Utara','2021-04-16 09:28:26'),
(312,25,'Kabupaten Siau Tagulandang Biaro','2021-04-16 09:28:26'),
(313,26,'Kabupaten Boalemo','2021-04-16 09:28:26'),
(314,26,'Kabupaten Bone Bolango','2021-04-16 09:28:26'),
(315,26,'Kabupaten Gorontalo','2021-04-16 09:28:26'),
(316,26,'Kabupaten Gorontalo Utara','2021-04-16 09:28:26'),
(317,26,'Kabupaten Pahuwato','2021-04-16 09:28:26'),
(318,27,'Kabupaten Banggai','2021-04-16 09:28:26'),
(319,27,'Kabupaten Banggai Kepulauan','2021-04-16 09:28:26'),
(320,27,'Kabupaten Banggai Laut','2021-04-16 09:28:26'),
(321,27,'Kabupaten Buol','2021-04-16 09:28:26'),
(322,27,'Kabupaten Donggala','2021-04-16 09:28:26'),
(323,27,'Kabupaten Morowali','2021-04-16 09:28:26'),
(324,27,'Kabupaten Morowali Utara','2021-04-16 09:28:26'),
(325,27,'Kabupaten Parigi Moutong','2021-04-16 09:28:26'),
(326,27,'Kabupaten Poso','2021-04-16 09:28:26'),
(327,27,'Kabupaten Sigi','2021-04-16 09:28:26'),
(328,27,'Kabupaten Tojo Una-una','2021-04-16 09:28:26'),
(329,27,'Kabupaten Tolitoli','2021-04-16 09:28:26'),
(330,28,'Kabupaten Majene','2021-04-16 09:28:26'),
(331,28,'Kabupaten Mamasa','2021-04-16 09:28:26'),
(332,28,'Kabupaten Mamuju','2021-04-16 09:28:26'),
(333,28,'Kabupaten Mamuju Tengah','2021-04-16 09:28:26'),
(334,28,'Kabupaten Pasangkayu','2021-04-16 09:28:26'),
(335,28,'Kabupaten Poliwali Mandar','2021-04-16 09:28:26'),
(336,29,'Kabupaten Bantaeng','2021-04-16 09:28:26'),
(337,29,'Kabupaten Barru','2021-04-16 09:28:26'),
(338,29,'Kabupaten Bone','2021-04-16 09:28:26'),
(339,29,'Kabupaten Bulukumba','2021-04-16 09:28:26'),
(340,29,'Kabupaten Enrekang','2021-04-16 09:28:26'),
(341,29,'Kabupaten Gowa','2021-04-16 09:28:26'),
(342,29,'Kabupaten Jeneponto','2021-04-16 09:28:26'),
(343,29,'Kabupaten Kepulauan Selayar','2021-04-16 09:28:26'),
(344,29,'Kabupaten Luwu','2021-04-16 09:28:26'),
(345,29,'Kabupaten Luwu Timur','2021-04-16 09:28:26'),
(346,29,'Kabupaten Luwu Utara','2021-04-16 09:28:26'),
(347,29,'Kabupaten Maros','2021-04-16 09:28:26'),
(348,29,'Kabupaten Pangkajene dan Kepulauan','2021-04-16 09:28:26'),
(349,29,'Kabupaten Pinrang','2021-04-16 09:28:26'),
(350,29,'Kabupaten Sidenreng Rappang','2021-04-16 09:28:26'),
(351,29,'Kabupaten Sinjai','2021-04-16 09:28:26'),
(352,29,'Kabupaten Soppeng','2021-04-16 09:28:26'),
(353,29,'Kabupaten Takalar','2021-04-16 09:28:26'),
(354,29,'Kabupaten Takalar','2021-04-16 09:28:26'),
(355,29,'Kabupaten Toraja Utara','2021-04-16 09:28:26'),
(356,29,'Kabupaten Wajo','2021-04-16 09:28:26'),
(357,30,'Kabupaten Bombana','2021-04-16 09:28:26'),
(358,30,'Kabupaten Buton','2021-04-16 09:28:26'),
(359,30,'Kabupaten Buton Selatan','2021-04-16 09:28:26'),
(360,30,'Kabupaten Buton Tengah','2021-04-16 09:28:26'),
(361,30,'Kabupaten Buton Utara','2021-04-16 09:28:26'),
(362,30,'Kabupaten Kolaka	','2021-04-16 09:28:26'),
(363,30,'Kabupaten Kolaka Timur','2021-04-16 09:28:26'),
(365,30,'Kabupaten Kolaka Utara','2021-04-16 09:28:26'),
(366,30,'Kabupaten Konawe','2021-04-16 09:28:26'),
(367,30,'Kabupaten Konawe Kepulauan','2021-04-16 09:28:26'),
(368,30,'Kabupaten Konawe Selatan','2021-04-16 09:28:26'),
(369,30,'Kabupaten Konawe Utara','2021-04-16 09:28:26'),
(370,30,'Kabupaten Muna','2021-04-16 09:28:26'),
(371,30,'Kabupaten Muna Barat','2021-04-16 09:28:26'),
(372,30,'Kabupaten Wakatobi','2021-04-16 09:28:26'),
(373,31,'Kabupaten Halmahera Barat','2021-04-16 09:28:26'),
(374,31,'Kabupaten Halmahera Selatan','2021-04-16 09:28:26'),
(375,31,'Kabupaten Halmahera Tengah','2021-04-16 09:28:26'),
(376,31,'Kabupaten Halmahera Timur','2021-04-16 09:28:26'),
(377,31,'Kabupaten Halmahera Utara','2021-04-16 09:28:26'),
(378,31,'Kabupaten Kepulauan Sula','2021-04-16 09:28:26'),
(379,31,'Kabupaten Pulau Morotai','2021-04-16 09:28:26'),
(380,31,'Kabupaten Pulau Taliabu','2021-04-16 09:28:26'),
(381,32,'Kabupaten Halmahera Barat','2021-04-16 09:28:26'),
(382,32,'Kabupaten Halmahera Selatan','2021-04-16 09:28:26'),
(383,32,'Kabupaten Halmahera Tengah','2021-04-16 09:28:26'),
(384,32,'Kabupaten Halmahera Timur','2021-04-16 09:28:26'),
(385,32,'Kabupaten Halmahera Utara','2021-04-16 09:28:26'),
(386,32,'Kabupaten Kepulauan Sula','2021-04-16 09:28:26'),
(387,32,'Kabupaten Pulau Morotai','2021-04-16 09:28:26'),
(388,32,'Kabupaten Pulau Taliabu','2021-04-16 09:28:26'),
(389,33,'Kabupaten Fakfak','2021-04-16 09:28:26'),
(390,33,'Kabupaten Kaimana','2021-04-16 09:28:26'),
(391,33,'Kabupaten Manokwari','2021-04-16 09:28:26'),
(392,33,'Kabupaten Manokwari','2021-04-16 09:28:26'),
(393,33,'Kabupaten Manokwari Selatan','2021-04-16 09:28:26'),
(394,33,'Kabupaten Maybrat','2021-04-16 09:28:26'),
(395,33,'Kabupaten Pegunungan Arfak','2021-04-16 09:28:26'),
(396,33,'Kabupaten Raja Ampat','2021-04-16 09:28:26'),
(397,33,'Kabupaten Sorong','2021-04-16 09:28:26'),
(398,33,'Kabupaten Sorong Selatan','2021-04-16 09:28:26'),
(399,33,'Kabupaten Tambrauw','2021-04-16 09:28:26'),
(400,33,'Kabupaten Teluk Bintuni','2021-04-16 09:28:26'),
(401,33,'Kabupaten Teluk Wondama','2021-04-16 09:28:26'),
(402,34,'Kabupaten Asmat','2021-04-16 09:28:26'),
(403,34,'Kabupaten Biak Numfor','2021-04-16 09:28:26'),
(404,34,'Kabupaten Boven Digoel','2021-04-16 09:28:26'),
(405,34,'Kabupaten Deiyai','2021-04-16 09:28:26'),
(406,34,'Kabupaten Dogiyai','2021-04-16 09:28:26'),
(407,34,'Kabupaten Intan Jaya','2021-04-16 09:28:26'),
(408,34,'Kabupaten Jayapura','2021-04-16 09:28:26'),
(409,34,'Kabupaten Jayawijaya','2021-04-16 09:28:26'),
(410,34,'Kabupaten Keerom','2021-04-16 09:28:26'),
(411,34,'Kabupaten Kepulauan Yapen','2021-04-16 09:28:26'),
(412,34,'Kabupaten Lanny Jaya','2021-04-16 09:28:26'),
(413,34,'Kabupaten Mamberamo Raya','2021-04-16 09:28:26'),
(414,34,'Kabupaten Mamberamo Tengah','2021-04-16 09:28:26'),
(415,34,'Kabupaten Mappi','2021-04-16 09:28:26'),
(416,34,'Kabupaten Merauke','2021-04-16 09:28:26'),
(417,34,'Kabupaten Mimika','2021-04-16 09:28:26'),
(418,34,'Kabupaten Nabire','2021-04-16 09:28:26'),
(419,34,'Kabupaten Nduga','2021-04-16 09:28:26'),
(420,34,'Kabupaten Paniai','2021-04-16 09:28:26'),
(421,34,'Kabupaten Pegunungan Bintang','2021-04-16 09:28:26'),
(422,34,'Kabupaten Puncak','2021-04-16 09:28:26'),
(423,34,'Kabupaten Puncak Jaya','2021-04-16 09:28:26'),
(424,34,'Kabupaten Sarmi','2021-04-16 09:28:26'),
(425,34,'Kabupaten Supiori','2021-04-16 09:28:26'),
(426,34,'Kabupaten Tolikara','2021-04-16 09:28:26'),
(427,34,'Kabupaten Waropen','2021-04-16 09:28:26'),
(428,34,'Kabupaten Yahukimo','2021-04-16 09:28:26'),
(429,34,'Kabupaten Yalimo','2021-04-16 09:28:26');

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
  `nik` varchar(255) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `nama_panggilan` varchar(255) NOT NULL,
  `alamat` text DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pegawai` */

insert  into `pegawai`(`id`,`id_kabupaten`,`nik`,`nama_lengkap`,`nama_panggilan`,`alamat`,`nktp`,`nohp`,`jenis_kelamin`,`tempat_lahir`,`tanggal_lahir`,`agama`,`status_perkawinan`,`kewarganegaraan`,`golongan_darah`,`bahasa`,`suku`,`daerah_asal`,`tanggal_mulai_bekerja`,`level`,`divisi`,`seksi`,`bagian`,`status_karyawan`,`tanggal_pengangkatan`,`no_rekening`,`no_bpjs_kesehatan`,`no_bpjs_ketenagakerjaan`,`created_at`) values 
(1,22,'201803186','Mohamad Novriyanto Ali','Rhein',NULL,'7503030711920001','082219193211','Pria','suwawa','1992-11-07','Islam','Kawin','WNI','O','indonesia','gorontalo','gorontalo','2018-03-18','staf','belum berlaku','belum berlaku','it','PKWT','2021-06-25','34123124143','413421321321','542342342342342','2021-04-15 10:29:11');

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
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_telegram` int(11) unsigned DEFAULT NULL,
  `nik` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`id_telegram`,`nik`,`password`,`level`,`created_at`) values 
(1,NULL,'201803186','$2a$04$SFJi9c6HhwtONdhBfQRvbOcq1XBcys1gUi39oo2OQc0sFrN78l1Vm','admin','2021-04-16 08:41:36');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
