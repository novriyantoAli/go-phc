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

/*Table structure for table `kabupaten` */

DROP TABLE IF EXISTS `kabupaten`;

CREATE TABLE `kabupaten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_provinsi` int(11) NOT NULL,
  `nama_kabupaten` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

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
(68,5,'Kabupaten Bintan'),
(69,5,'Kabupaten Karimun'),
(70,5,'Kabupaten Kepulauan Anambas'),
(71,5,'Kabupaten Lingga'),
(72,5,'Kabupaten Natuna');

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
