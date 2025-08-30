-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2025 at 05:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cultural_sites_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `site_id`) VALUES
(2, 14, 1),
(3, 14, 10),
(4, 14, 17),
(5, 14, 22),
(6, 14, 3),
(7, 10, 1),
(8, 10, 35),
(9, 11, 61),
(10, 11, 69),
(11, 11, 344),
(12, 12, 53),
(13, 12, 54),
(14, 12, 55),
(16, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `site_id`, `text`, `rating`, `created_at`) VALUES
(2, 14, 1, 'Amazing view and architecture!', 5, '2025-06-15 11:42:52'),
(3, 14, 4, 'Great experience but crowded', 3, '2025-06-15 11:43:11'),
(4, 10, 1, 'Historical and magnificent!', 5, '2025-06-15 11:46:03'),
(5, 10, 25, 'good', 4, '2025-06-15 11:46:23'),
(6, 11, 88, 'Nice artwork', 5, '2025-06-15 11:47:39'),
(7, 12, 57, 'bad', 2, '2025-06-15 11:48:25'),
(8, 12, 72, 'not good', 1, '2025-06-15 11:48:44'),
(9, 12, 103, 'nice food service', 5, '2025-06-15 11:49:02'),
(10, 1, 1, 'super', 5, '2025-06-15 13:13:28');

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE `sites` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `tourism` varchar(255) DEFAULT NULL,
  `amenity` varchar(255) DEFAULT NULL,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sites`
--

INSERT INTO `sites` (`id`, `name`, `tourism`, `amenity`, `lat`, `lon`, `website`, `deleted`) VALUES
(1, 'Sächsisches Eisenbahnmuseum', 'museum', '', 50.8621, 12.9677, 'https://www.sem-chemnitz.de/', 0),
(2, 'mensa⁵⁵', '', 'restaurant', 50.8151, 12.9307, NULL, 0),
(3, 'Gasthof \"Goldener Hahn\"', '', 'restaurant', 50.7819, 12.9939, 'http://www.goldener-hahn-chemnitz.de', 0),
(4, 'Gasthof Lehngut', '', 'restaurant', 50.8345, 13.0196, 'http://www.gasthaus-lehngut.de', 0),
(5, 'Kunstsammlungen Chemnitz', 'museum', '', 50.8377, 12.9245, 'https://kunstsammlungen-chemnitz.de/', 0),
(6, 'Opernhaus Chemnitz', '', 'theatre', 50.8384, 12.9242, 'https://www.theater-chemnitz.de/', 0),
(7, 'Heck-Art', '', 'restaurant', 50.8378, 12.9217, 'https://www.restaurant-heck-art.de/', 0),
(8, 'Lehngericht', '', 'restaurant', 50.7624, 12.9387, NULL, 0),
(9, 'Villa Esche', 'museum', '', 50.815, 12.9009, NULL, 0),
(10, 'Lapidarium', 'museum', '', 50.8453, 12.9138, 'https://www.kunstsammlungen-chemnitz.de/haeuser/schlossbergmuseum/', 0),
(11, 'Industriemuseum Chemnitz', 'museum', '', 50.8241, 12.8999, 'https://www.industriemuseum-chemnitz.de/', 0),
(12, 'Galerie Oben', 'artwork', '', 50.8294, 12.9039, NULL, 0),
(13, 'Museum für Sächsische Fahrzeuge Chemnitz', 'museum', '', 50.8263, 12.9083, 'https://www.fahrzeugmuseum-chemnitz.de/', 0),
(14, 'Uhrenmuseum Chemnitz', 'museum', '', 50.8219, 12.8882, 'https://www.uhrenmuseum-chemnitz.de/', 0),
(15, 'Folklorehof Grüna', 'hotel', 'restaurant', 50.8148, 12.7921, 'https://www.folklorehof.de/', 0),
(16, 'Miramar', '', 'restaurant', 50.8442, 12.9143, NULL, 0),
(17, 'Deutsches Spielemuseum', 'museum', '', 50.8206, 12.8926, 'https://www.deutsches-spielemuseum.eu/', 0),
(18, 'Gasthof Kleinolbersdorf', '', 'restaurant', 50.8008, 13.0207, 'https://www.hotel-kleinolbersdorf.de', 0),
(19, 'Pizzeria Ristorante La Rustica', '', 'restaurant', 50.7824, 12.9252, NULL, 0),
(20, 'Zur Turnhalle', '', 'restaurant', 50.8154, 12.9865, 'www.gastro-partyservice-chemnitz.de', 0),
(21, 'Zeisigwaldschänke', '', 'restaurant', 50.8456, 12.9634, NULL, 0),
(22, 'Ola Kala!', '', 'restaurant', 50.7877, 12.9067, 'http://www.taverna-am-harthwald.de/', 0),
(23, 'Chinarestaurant Chi Hu Su', '', 'restaurant', 50.863, 12.8566, NULL, 0),
(24, 'Pension & Gasthaus Nostalgie', '', 'restaurant', 50.8319, 12.8862, NULL, 0),
(25, 'Restaurant Villa Esche', '', 'restaurant', 50.8151, 12.9005, 'http://www.restaurant-villaesche.de/', 0),
(26, 'Waldklause', '', 'restaurant', 50.7657, 12.9795, NULL, 0),
(27, 'Jackis Gartenglück', '', 'restaurant', 50.8171, 12.8922, 'https://gartenglueck-chemnitz.de/?page_id=249', 0),
(28, 'Zur Miene', '', 'restaurant', 50.8139, 12.9566, 'https://www.zur-miene.de/', 0),
(29, 'Ebersdorfer Schulmuseum', 'museum', '', 50.8711, 12.965, 'https://www.schulmuseum-ebersdorf.de/', 0),
(30, 'Marios Kochservice', '', 'restaurant', 50.831, 12.9288, 'https://www.klitscherkloss.de', 0),
(31, 'Gaststätte Blankenburg', '', 'restaurant', 50.8686, 12.901, NULL, 0),
(32, 'Museum Gunzenhauser', 'museum', '', 50.8286, 12.9153, 'https://www.kunstsammlungen-chemnitz.de/', 0),
(33, 'Gasthaus zur Friedenseiche', '', 'restaurant', 50.7638, 12.943, NULL, 0),
(34, 'Hotel Abendroth', 'hotel', 'restaurant', 50.8005, 12.8047, 'https://www.abendroth-hotel.de/', 0),
(35, 'Sto Vasilis', '', 'restaurant', 50.849, 12.8674, NULL, 0),
(36, 'Gartenlokal \"Volksgesundheit\"', '', 'restaurant', 50.8492, 12.8722, NULL, 0),
(37, 'Prince of Punjab', '', 'restaurant', 50.8435, 12.929, NULL, 0),
(38, 'Eichenpub', '', 'restaurant', 50.7937, 12.8799, NULL, 0),
(39, 'Vietnam-Spezi', '', 'restaurant', 50.8189, 12.9273, 'https://www.vietnamspezi.de', 0),
(40, 'Staatliches Museum für Archäologie Chemnitz', 'museum', '', 50.8341, 12.925, NULL, 0),
(41, 'Totenstein-Alm', '', 'restaurant', 50.8249, 12.7785, 'http://www.totenstein-alm.de/', 0),
(42, 'Brettmühle', '', 'restaurant', 50.8874, 12.988, NULL, 0),
(43, 'Gartenheim Pestalozzi', '', 'restaurant', 50.8345, 12.9418, NULL, 0),
(44, 'Keglerheim', '', 'restaurant', 50.7644, 12.9456, NULL, 0),
(45, 'Rosenthal', '', 'restaurant', 50.8645, 12.9184, NULL, 0),
(46, 'Gaststätte Zeisigwaldlehne', '', 'restaurant', 50.8351, 12.9704, 'http://www.kgv-zeisigwaldlehne.de/vereinsheim.htm', 0),
(47, 'MEGA Star Chemnitz', '', 'restaurant', 50.8626, 12.9528, NULL, 0),
(48, 'Café Milchhäuschen Chemnitz - Restaurant und Café am Schlossteich', '', 'restaurant', 50.8424, 12.9128, 'https://cafemilchhaeuschen.de/', 0),
(49, 'Bistro zum Sachsenland', '', 'restaurant', 50.8777, 12.8675, NULL, 0),
(50, 'Pelzmühle', '', 'restaurant', 50.8188, 12.832, NULL, 0),
(51, 'Bistro Klabauter Eck', '', 'restaurant', 50.7867, 12.9011, 'http://www.klabauter-eck.de', 0),
(52, 'Theaterplatz', '', 'theatre', 50.8378, 12.9256, NULL, 0),
(53, 'Onkel Franz', '', 'restaurant', 50.8318, 12.8976, NULL, 0),
(54, 'Espitas Chemnitz', '', 'restaurant', 50.851, 12.8917, NULL, 0),
(55, 'Delphi', '', 'restaurant', 50.8465, 12.9296, NULL, 0),
(56, 'Aiko Sushi & Grill', '', 'restaurant', 50.8186, 12.9442, 'http://aiko-chemnitz.de', 0),
(57, 'Schauspielhaus Chemnitz', '', 'theatre', 50.829, 12.9313, 'https://www.theater-chemnitz.de/', 0),
(58, 'Gasthof Draisdorf \"Athos\"', '', 'restaurant', 50.8825, 12.8996, NULL, 0),
(59, 'Stehpizzeria Napoli', '', 'restaurant', 50.8273, 12.9443, 'http://www.stehpizzeria-napoli.de', 0),
(60, 'Gasthaus „An der Schloßmühle“', '', 'restaurant', 50.8457, 12.9166, 'https://www.gasthaus-schlossmuehle.de/', 0),
(61, 'Fritz Theater', '', 'theatre', 50.8235, 12.8418, 'https://www.fritz-theater.de', 0),
(62, 'Japanisches Restaurant Osaka', '', 'restaurant', 50.8368, 12.9173, 'http://osaka-chemnitz.de/sushi.html', 0),
(63, 'Gaststätte \"Adelsbergturm\"', '', 'restaurant', 50.8113, 13.0156, 'https://www.adelsbergturm.de/', 0),
(64, 'Raststätte Rabensteiner Wald', '', 'restaurant', 50.8215, 12.7656, NULL, 0),
(65, 'Namaste Nepal', '', 'restaurant', 50.8321, 12.9544, NULL, 0),
(66, 'Drei Schwanen', '', 'restaurant', 50.8248, 12.8179, NULL, 0),
(67, 'Gaststätte Sonnenrose', '', 'restaurant', 50.8336, 12.9423, 'https://www.sonnenrose-chemnitz.de/vereinsgastst%C3%A4tte/', 0),
(68, 'Jungborn', '', 'restaurant', 50.8305, 12.9751, NULL, 0),
(69, 'Museum für Naturkunde Chemnitz', 'museum', '', 50.8314, 12.9233, NULL, 0),
(70, 'Griechisches Restaurant Athen', '', 'restaurant', 50.7953, 12.9137, 'https://griechisches-restaurant-athen.de/', 0),
(71, 'Die Winzerstube', '', 'restaurant', 50.8327, 12.8973, NULL, 0),
(72, 'Feel Good Club', '', 'restaurant', 50.8004, 12.9018, 'https://feelgoodclub.de/gastronomie', 0),
(73, 'Restaurant Kellerhaus Chemnitz', '', 'restaurant', 50.8456, 12.9164, NULL, 0),
(74, 'Gasthaus „Speisekammer“', '', 'restaurant', 50.8454, 12.9162, 'https://speisekammer-chemnitz.de/', 0),
(75, 'Ristorante Amore Mio', '', 'restaurant', 50.8452, 12.9166, 'https://amore-mio-chemnitz.de/', 0),
(76, 'Restaurant und Cafe „ankh“', '', 'restaurant', 50.85, 12.9213, NULL, 0),
(77, 'Bab Scharqi', '', 'restaurant', 50.8457, 12.9086, 'https://bab-scharqi.de/', 0),
(78, 'Fabrikküche', '', 'restaurant', 50.8502, 12.9216, 'https://max-louis.de/fabrik-kueche/', 0),
(79, 'Straßenbahnmuseum', 'museum', '', 50.8224, 12.8891, NULL, 0),
(80, 'Syrtaki', '', 'restaurant', 50.8244, 12.907, NULL, 0),
(81, 'Maharadscha Palast', '', 'restaurant', 50.828, 12.927, 'https://maharadschapalast.de', 0),
(82, 'La bouchée', '', 'restaurant', 50.833, 12.9182, NULL, 0),
(83, 'Sushifreunde Chemnitz', '', 'restaurant', 50.8347, 12.9257, 'https://sushifreunde.de/', 0),
(84, 'Brauerei Reichenbrand', '', 'restaurant', 50.8143, 12.8354, 'https://www.reichenbrander.de/', 0),
(85, 'Ronny\'s Restaurant', '', 'restaurant', 50.832, 12.8994, 'https://ronnys-restaurant.de/', 0),
(86, 'Suppkultur', '', 'restaurant', 50.8356, 12.9006, NULL, 0),
(87, 'Side´s', '', 'restaurant', 50.8381, 12.9572, NULL, 0),
(88, 'Chef Ehabs Restaurant', '', 'restaurant', 50.8354, 12.9219, 'https://www.chef-ehab.com/', 0),
(89, '', 'artwork', '', 50.8393, 12.9165, NULL, 0),
(90, 'Gaststätte \"Sternmühle\"', '', 'restaurant', 50.8068, 13.0385, 'https://www.gaststaette-sternmuehle.de', 0),
(91, 'Restaurant Paradise', '', 'restaurant', 50.8358, 12.9217, NULL, 0),
(92, 'Zur Aue', '', 'restaurant', 50.8269, 12.9189, 'http://www.zur-aue-chemnitz.de', 0),
(93, 'Bäckerei-Restaurant Emils 1910', '', 'restaurant', 50.8064, 12.8505, 'https://www.emils-1910.de/', 0),
(94, 'Gartenheim \"Erholung\"', '', 'restaurant', 50.8173, 12.8306, NULL, 0),
(95, 'Al Castello', '', 'restaurant', 50.8442, 12.9111, NULL, 0),
(96, 'Schloßbergmuseum Chemnitz', 'museum', '', 50.8452, 12.915, 'https://www.kunstsammlungen-chemnitz.de/haeuser/schlossbergmuseum/#', 0),
(97, 'Parkgaststätte Rosarium', '', 'restaurant', 50.8026, 12.9018, NULL, 0),
(98, 'Sterzeleanum im Naturkundemuseum', 'museum', '', 50.8312, 12.923, NULL, 0),
(99, 'Neue Sächsische Galerie Chemnitz', 'museum', '', 50.8311, 12.9228, NULL, 0),
(100, 'Janssen', '', 'restaurant', 50.8382, 12.9173, 'http://www.janssen-Restaurant.de', 0),
(101, 'Restaurant Scala', '', 'restaurant', 50.8372, 12.9262, NULL, 0),
(102, 'Euro-Pizza-Service', '', 'restaurant', 50.7708, 12.9739, NULL, 0),
(103, 'Gasthaus \"Zum Braumeister\"', '', 'restaurant', 50.8047, 12.8853, 'http://www.braumeister-chemnitz.de/', 0),
(104, 'Sonnenuhr', 'artwork', 'clock', 50.8338, 12.9359, NULL, 0),
(105, 'Café Südeck', '', 'restaurant', 50.8184, 12.9287, 'https://xn--eiscafe-sdeck-4ob.de/', 0),
(106, '', '', 'theatre', 50.7993, 12.9036, NULL, 0),
(107, 'ZUHAUSE', 'artwork', '', 50.8441, 12.9257, NULL, 0),
(108, 'Diebels Fasskeller', '', 'restaurant', 50.8363, 12.9155, NULL, 0),
(109, 'Sportklause Altenhain', '', 'restaurant', 50.7865, 12.9976, 'http://www.sportklause-altenhain.de', 0),
(110, 'Uferstrand - Paula', '', 'restaurant', 50.8295, 12.9195, NULL, 0),
(111, 'Karsten\'s Gastroservice', '', 'restaurant', 50.7988, 12.8526, 'https://karstens-chemnitz.de/', 0),
(112, 'Skulpturengruppe \"12 Grad 55 Minuten 11 Sekunden Östliche Länge“', 'artwork', '', 50.8347, 12.918, NULL, 0),
(113, 'Restaurant Felsendome', 'guest_house', 'restaurant', 50.8363, 12.8434, 'https://www.felsendome.de/', 0),
(114, 'Kabarettkeller', '', 'theatre', 50.835, 12.9158, NULL, 0),
(115, 'Athos', '', 'restaurant', 50.8528, 12.8831, NULL, 0),
(116, 'Amphitheater & Denkmal mit Skulptur', '', 'theatre', 50.8463, 12.8779, NULL, 0),
(117, 'Palace Athen', '', 'restaurant', 50.836, 12.9051, NULL, 0),
(118, 'Suppenmaxe', '', 'restaurant', 50.8241, 12.8992, 'https://www.industriemuseum-chemnitz.de/gastronomie', 0),
(119, 'Vier Tageszeiten', 'artwork', '', 50.8401, 12.9108, 'https://www.chemnitz.de/chemnitz/de/unsere-stadt/geschichte/geschichte-entdecken/schillingsche_figuren.html', 0),
(120, 'Korn & Käse', '', 'restaurant', 50.842, 12.9242, NULL, 0),
(121, 'Gartenheim \"Kupferbusch\"', '', 'restaurant', 50.8082, 12.8703, NULL, 0),
(122, '50\'s ville Diner', '', 'restaurant', 50.8237, 12.8973, 'https://www.50svillediner.de/', 0),
(123, 'Technikmuseum Seilablaufanlage', 'museum', '', 50.8619, 12.9567, 'http://standort.technikmuseum-seilablaufanlage.de/de/', 0),
(124, 'Ristorante Da Nino', '', 'restaurant', 50.841, 12.9012, NULL, 0),
(125, 'Krystallpalast', '', 'restaurant', 50.7652, 12.9062, NULL, 0),
(126, 'Korfu, Tsolis Spiridon', '', 'restaurant', 50.8205, 12.9406, 'http://www.griechische-speisen.de', 0),
(127, 'Am Waldbach', '', 'restaurant', 50.7574, 12.9034, 'http://www.gartenheim-am-waldbach.de/', 0),
(128, 'Opera', '', 'restaurant', 50.8383, 12.926, NULL, 0),
(129, 'Restaurant Richard', '', 'restaurant', 50.8383, 12.9348, NULL, 0),
(130, 'Al Sham', '', 'restaurant', 50.8299, 12.94, NULL, 0),
(131, 'Namaste India', '', 'restaurant', 50.8341, 12.9179, NULL, 0),
(132, '', 'artwork', '', 50.8383, 12.8848, NULL, 0),
(133, 'Betyar Csarda', '', 'restaurant', 50.8414, 12.8986, NULL, 0),
(134, 'Ristorante Nuova Italia', '', 'restaurant', 50.824, 12.9418, NULL, 0),
(135, 'Küchwaldbühne', '', 'theatre', 50.8497, 12.9086, NULL, 0),
(136, '', '', 'theatre', 50.8476, 12.9099, NULL, 0),
(137, 'ALEX', '', 'restaurant', 50.8335, 12.9203, NULL, 0),
(138, 'Volkshaus Röhrsdorf', '', 'restaurant', 50.8629, 12.8438, NULL, 0),
(139, 'Marquardt\'s', '', 'restaurant', 50.8268, 12.8979, 'http://www.kneipen-in-chemnitz.de/loc/marquardts', 0),
(140, '', 'artwork', '', 50.8097, 12.8929, NULL, 0),
(141, '', 'artwork', '', 50.8096, 12.8869, NULL, 0),
(142, '', 'artwork', '', 50.8099, 12.8875, NULL, 0),
(143, '', 'artwork', '', 50.8435, 12.9416, NULL, 0),
(144, '', 'artwork', '', 50.8251, 12.9209, NULL, 0),
(145, '', 'artwork', '', 50.8252, 12.9232, NULL, 0),
(146, '', 'artwork', '', 50.8429, 12.9226, NULL, 0),
(147, '', 'artwork', '', 50.8429, 12.9227, NULL, 0),
(148, '', 'artwork', '', 50.8429, 12.9228, NULL, 0),
(149, '', 'artwork', '', 50.8429, 12.9227, NULL, 0),
(150, '', 'artwork', '', 50.804, 12.8812, NULL, 0),
(151, '', 'artwork', '', 50.8039, 12.8814, NULL, 0),
(152, '', 'artwork', '', 50.8038, 12.8816, NULL, 0),
(153, '', 'artwork', '', 50.8037, 12.8818, NULL, 0),
(154, '', 'artwork', '', 50.8036, 12.882, NULL, 0),
(155, '', 'artwork', '', 50.8035, 12.8822, NULL, 0),
(156, '', 'artwork', '', 50.8409, 12.9021, NULL, 0),
(157, '', 'artwork', '', 50.8414, 12.9034, NULL, 0),
(158, '', 'artwork', '', 50.8383, 12.9044, NULL, 0),
(159, '', 'artwork', '', 50.8383, 12.9027, NULL, 0),
(160, '', 'artwork', '', 50.819, 12.9649, NULL, 0),
(161, '', 'artwork', '', 50.8398, 12.94, NULL, 0),
(162, 'Mediterraneum', '', 'restaurant', 50.7895, 12.9552, NULL, 0),
(163, 'Gaststätte Reichenhain', '', 'restaurant', 50.7988, 12.959, NULL, 0),
(164, 'Restaurant Farah', '', 'restaurant', 50.8226, 12.9592, 'https://www.restaurant-farah.de/', 0),
(165, '', '', 'restaurant', 50.8383, 12.9077, NULL, 0),
(166, 'ehem. Wandschmuck aus dem \"Forum\"', 'artwork', '', 50.8372, 12.9225, NULL, 0),
(167, 'Buono', '', 'restaurant', 50.835, 12.9187, NULL, 0),
(168, 'Gasthaus Zur Scheune', '', 'restaurant', 50.8769, 12.9763, NULL, 0),
(169, 'A&F Restaurant Ocakbasi', '', 'restaurant', 50.8274, 12.928, NULL, 0),
(170, 'Cafeteria und Gaststätte im Sportforum', '', 'restaurant', 50.806, 12.9327, NULL, 0),
(171, 'Skulptur Bär', 'artwork', '', 50.8318, 12.9144, NULL, 0),
(172, 'Gasthaus Grüner Baum', '', 'restaurant', 50.7923, 12.9259, NULL, 0),
(173, 'Siegert', '', 'restaurant', 50.8333, 12.8164, NULL, 0),
(174, 'Gartenheim „Geibelhöhe“', '', 'restaurant', 50.8177, 12.9629, 'http://www.kneipen-in-chemnitz.de/loc/geibelhoehe', 0),
(175, 'Restaurant \"Long Quan\"', '', 'restaurant', 50.8311, 12.9579, NULL, 0),
(176, 'Gartenheim \"Gesundheit\"', '', 'restaurant', 50.8183, 12.9441, NULL, 0),
(177, 'Megas Alexandros', '', 'restaurant', 50.8181, 12.9556, NULL, 0),
(178, 'Gartenheim \"Zur Froschschänke\"', '', 'restaurant', 50.8259, 12.9514, 'http://www.froschschaenke-chemnitz.de', 0),
(179, 'Taverna Alexandros', '', 'restaurant', 50.8337, 12.951, 'https://www.tavernaalexandros-chemnitz.de', 0),
(180, 'Gaststätte \"Böhmisches Wirtshaus\"', '', 'restaurant', 50.8189, 12.955, NULL, 0),
(181, 'Gaststätte Hilbersdorfer Höhe', '', 'restaurant', 50.8545, 12.9567, 'https://hilbersdorfer-hoehe.de', 0),
(182, 'Oskar', '', 'restaurant', 50.8409, 12.9345, 'https://www.facebook.com/share/1LEWcaWQGp/?mibextid=LQQJ4d', 0),
(183, 'Sushi-Running', '', 'restaurant', 50.8649, 12.8673, NULL, 0),
(184, 'Ernst Thälmann', 'artwork', '', 50.8417, 12.9166, NULL, 0),
(185, 'Gaststätte Höhenluft', '', 'restaurant', 50.8393, 12.9682, NULL, 0),
(186, 'Konzertpavillon', '', 'theatre', 50.8413, 12.913, NULL, 0),
(187, 'Morgenröte', 'artwork', '', 50.8392, 12.91, NULL, 0),
(188, 'Brazil', '', 'restaurant', 50.8346, 12.9181, NULL, 0),
(189, 'Entenhaus', '', 'restaurant', 50.8468, 12.9005, 'http://www.entenhaus-restaurant-chemnitz.de', 0),
(190, 'Michaelis Kaffehaus & Restaurant', '', 'restaurant', 50.8342, 12.9192, 'https://www.michaelis-chemnitz.de/', 0),
(191, 'Asia-Menü Long-Quan', '', 'restaurant', 50.8367, 12.9257, NULL, 0),
(192, 'Bambus Bistro', '', 'restaurant', 50.8322, 12.9222, NULL, 0),
(193, 'Die Chemnitz lebt (Angler)', 'artwork', '', 50.8382, 12.918, NULL, 0),
(194, 'alexxanders', '', 'restaurant', 50.8375, 12.9356, 'https://www.alexxanders.de/', 0),
(195, 'Vereinshaus \"Rapid Kappel\"', '', 'restaurant', 50.814, 12.891, NULL, 0),
(196, 'Skulptur einer Frau', 'artwork', '', 50.8156, 12.9048, NULL, 0),
(197, 'Café & Hotel zur Talsperre', 'hotel', 'restaurant', 50.7718, 12.9769, 'https://www.hotel-einsiedel.de/', 0),
(198, '', 'artwork', '', 50.8346, 12.9343, NULL, 0),
(199, '', 'artwork', '', 50.8345, 12.9343, NULL, 0),
(200, 'Sachsofon', '', 'restaurant', 50.829, 12.9615, 'http://www.sachsofon.de/', 0),
(201, 'Bistro Landgraf', '', 'restaurant', 50.8678, 12.8502, NULL, 0),
(202, 'Gablenz-Eck', '', 'restaurant', 50.8302, 12.9522, 'https://www.gablenz-eck-chemnitz.de', 0),
(203, 'Zur Zeile', '', 'restaurant', 50.8087, 12.9727, 'https://www.freizeitzentrum-adelsberg.de/cms/gaststaette/rundgang.html', 0),
(204, 'Waldeck', '', 'restaurant', 50.8349, 12.8159, NULL, 0),
(205, 'Galerie im Weltecho', 'gallery', '', 50.8283, 12.9201, NULL, 0),
(206, '', 'artwork', '', 50.8172, 12.9304, NULL, 0),
(207, 'Korfu Palace', '', 'restaurant', 50.858, 12.9515, NULL, 0),
(208, '', 'artwork', '', 50.8393, 12.936, NULL, 0),
(209, 'Asia Bistro', '', 'restaurant', 50.8124, 12.7986, NULL, 0),
(210, 'Ann Quan', '', 'restaurant', 50.8162, 12.9515, 'https://ann-quan.de', 0),
(211, '', 'artwork', '', 50.8184, 12.9467, NULL, 0),
(212, '', '', 'theatre', 50.7875, 12.9007, NULL, 0),
(213, 'Gaststube Torwache', '', 'restaurant', 50.7693, 12.8896, 'https://www.schlosshotel-chemnitz.de/restaurants/', 0),
(214, 'Galerie hinten', 'gallery', '', 50.8305, 12.9397, 'https://galeriehinten.de/', 0),
(215, 'Inselwachstum', 'artwork', 'bench', 50.8152, 12.9262, NULL, 0),
(216, 'Gaststube Sachsenperle', '', 'restaurant', 50.8354, 12.9419, NULL, 0),
(217, '', 'artwork', '', 50.845, 12.9378, NULL, 0),
(218, 'Emmi am Zöllnerplatz', 'guest_house', 'restaurant', 50.8464, 12.9272, 'https://www.emmi-chemnitz.de/', 0),
(219, 'Delhi Palast', '', 'restaurant', 50.8296, 12.9154, 'https://delhipalast.com/', 0),
(220, 'Route 66 Chemnitz', '', 'restaurant', 50.8507, 12.9459, 'http://www.route66-chemnitz.de', 0),
(221, 'Die Kantine', '', 'restaurant', 50.8321, 12.9201, 'https://kantine-chemnitz.de/', 0),
(222, 'MyLo - Vietnamese Kitchen', '', 'restaurant', 50.8169, 12.93, 'https://mylo-chemnitz.com/', 0),
(223, 'Hanoi Cuisine', '', 'restaurant', 50.8317, 12.9219, 'https://hanoi-cuisine.eatbu.com/#menu', 0),
(224, 'Mensa', '', 'restaurant', 50.8385, 12.9284, NULL, 0),
(225, 'Kantine Gewerbepark A4', '', 'restaurant', 50.8691, 12.9066, 'https://www.kantine-chemnitz.de', 0),
(226, 'max louis', '', 'restaurant', 50.8501, 12.9226, 'https://www.max-louis.de/', 0),
(227, '', 'artwork', '', 50.7689, 12.8887, NULL, 0),
(228, '', 'artwork', '', 50.7689, 12.8886, NULL, 0),
(229, '', 'artwork', '', 50.7693, 12.8887, NULL, 0),
(230, 'Restaurant Prag am Park', '', 'restaurant', 50.8184, 12.9045, 'https://www.restaurant-prag-am-park.de/', 0),
(231, 'Sushi & Wok Tamagutchi', '', 'restaurant', 50.8341, 12.9197, NULL, 0),
(232, '\"Eselsbrücke\"', 'artwork', '', 50.8377, 12.8261, NULL, 0),
(233, 'Syrisches Restaurant \"Malula\"', '', 'restaurant', 50.8414, 12.9214, 'https://www.malula-chemnitz.de/', 0),
(234, 'Stelen \"Cora\" und \"Mabel\"', 'artwork', '', 50.8394, 12.9262, NULL, 0),
(235, '', 'artwork', '', 50.835, 12.9219, NULL, 0),
(236, 'Folklorehof', '', 'restaurant', 50.8148, 12.7921, 'https://www.folklorehof.de/', 0),
(237, 'Alina Art Galerie', 'gallery', '', 50.8499, 12.9235, NULL, 0),
(238, '', 'artwork', '', 50.8157, 12.9328, NULL, 0),
(239, 'Wenzel Prager Bierstuben', '', 'restaurant', 50.8333, 12.9186, NULL, 0),
(240, 'Suppenmaxe', '', 'restaurant', 50.8316, 12.9181, NULL, 0),
(241, 'Blitz Pizza Service', '', 'restaurant', 50.8237, 12.836, 'https://www.blitzpizzaservice.de', 0),
(242, 'Bellini', '', 'restaurant', 50.8028, 12.8071, NULL, 0),
(243, 'Einsiedler Brauhaus', '', 'restaurant', 50.7649, 12.9746, NULL, 0),
(244, 'Restaurant Armenia', '', 'restaurant', 50.8549, 12.9291, 'https://www.restaurant-armenia.de/', 0),
(245, 'Kaßbergkeller', '', 'restaurant', 50.8337, 12.9144, NULL, 0),
(246, '1923', 'artwork', '', 50.8083, 12.9322, NULL, 0),
(247, 'China-Restaurant Asia-Palast', '', 'restaurant', 50.8118, 12.9127, NULL, 0),
(248, '', 'artwork', '', 50.841, 12.9132, NULL, 0),
(249, '', 'artwork', '', 50.844, 12.9142, NULL, 0),
(250, '', 'artwork', '', 50.8446, 12.9141, NULL, 0),
(251, 'Safran', '', 'restaurant', 50.8395, 12.9148, 'https://www.safran-chemnitz.de/', 0),
(252, 'Shahba Rose', '', 'restaurant', 50.845, 12.9099, 'https://www.shahba-rose.de/', 0),
(253, 'Cortina Restaurant', '', 'restaurant', 50.8342, 12.9234, NULL, 0),
(254, 'Asien-Imbiss Saigon', '', 'restaurant', 50.8263, 12.8323, NULL, 0),
(255, 'Hans im Glück', '', 'restaurant', 50.8342, 12.9182, NULL, 0),
(256, 'Sushi Box', '', 'restaurant', 50.8503, 12.9452, NULL, 0),
(257, 'Kassberg Pizza', '', 'restaurant', 50.8341, 12.8996, NULL, 0),
(258, 'Tadik\'s', '', 'restaurant', 50.8359, 12.9332, NULL, 0),
(259, 'Franklin Hofmann', '', 'restaurant', 50.8289, 12.9629, 'https://pferde-hofmann.de/', 0),
(260, 'Neue Chinaswelt', '', 'restaurant', 50.8458, 12.9312, 'https://www.chinaswelt.online/', 0),
(261, 'VIETNAM! NAM!', '', 'restaurant', 50.8442, 12.9303, 'https://vietnam-nam.de', 0),
(262, 'Lob der Partei', 'artwork', '', 50.8348, 12.9251, NULL, 0),
(263, 'Kampf und Sieg der revolutionären deutschen Arbeiterklasse', 'artwork', '', 50.8343, 12.9266, NULL, 0),
(264, 'Das Döner', '', 'restaurant', 50.8632, 12.8659, NULL, 0),
(265, 'Nudelmacher', '', 'restaurant', 50.8644, 12.8669, 'http://nudelmacher-chemnitz.de', 0),
(266, 'El-Mina Bistro', '', 'restaurant', 50.8353, 12.9177, NULL, 0),
(267, 'Pizzeria Adria', '', 'restaurant', 50.8319, 12.8914, NULL, 0),
(268, 'Bistro im Verwaltungsgericht', '', 'restaurant', 50.8273, 12.9085, NULL, 0),
(269, 'Asiaworld Chemnitz', '', 'restaurant', 50.7954, 12.8989, NULL, 0),
(270, 'Restaurant Sächsischer Hof', '', 'restaurant', 50.8412, 12.924, NULL, 0),
(271, 'Globus Restaurant', '', 'restaurant', 50.8048, 12.8609, NULL, 0),
(272, 'Exil No.5', '', 'restaurant', 50.8284, 12.933, 'https://www.essen-macht-gluecklich.de/', 0),
(273, 'Lob der Dialektik', 'artwork', '', 50.8345, 12.9256, NULL, 0),
(274, 'Lob des Kommunismus', 'artwork', '', 50.8348, 12.9253, NULL, 0),
(275, 'Lob des Revolutionärs', 'artwork', '', 50.8347, 12.9254, 'https://www.stadtbibliothek-chemnitz.de/skulpturen/pmwiki.php?n=Main.Lobgedichte', 0),
(276, '', 'artwork', '', 50.7855, 12.9386, NULL, 0),
(277, 'Street Kitchen', '', 'restaurant', 50.8467, 12.9388, NULL, 0),
(278, 'Zelal Döner', '', 'restaurant', 50.8659, 12.9592, NULL, 0),
(279, 'Junge auf Esel sitzend', 'artwork', '', 50.8307, 12.9261, NULL, 0),
(280, 'Pizzeria Caruso', '', 'restaurant', 50.8336, 12.8947, NULL, 0),
(281, 'Ratsstube Chemnitz', '', 'restaurant', 50.8333, 12.9236, NULL, 0),
(282, '', 'artwork', '', 50.8328, 12.9184, NULL, 0),
(283, 'Liegender', 'artwork', '', 50.8317, 12.9552, NULL, 0),
(284, '', 'artwork', '', 50.8268, 12.9301, NULL, 0),
(285, 'Sinnende', 'artwork', '', 50.8291, 12.9317, NULL, 0),
(286, 'Liebesnest', 'artwork', '', 50.8291, 12.9316, NULL, 0),
(287, '', 'artwork', '', 50.8397, 12.8832, NULL, 0),
(288, 'Golfclub Restaurant \"Birdie\"', '', 'restaurant', 50.7687, 12.8894, NULL, 0),
(289, '', 'museum', '', 50.7691, 12.8887, NULL, 0),
(290, 'Skulptur Sitzende', 'artwork', '', 50.8301, 12.9156, NULL, 0),
(291, 'Skulptur Elefant', 'artwork', '', 50.8307, 12.9152, NULL, 0),
(292, 'Skulptur Schildkröte', 'artwork', '', 50.8308, 12.9148, NULL, 0),
(293, '', 'artwork', '', 50.8317, 12.9176, NULL, 0),
(294, 'Kranichgruppe', 'artwork', '', 50.8175, 12.8364, NULL, 0),
(295, 'Klangbogen', 'artwork', '', 50.8499, 12.8915, NULL, 0),
(296, '', 'artwork', '', 50.8501, 12.8914, NULL, 0),
(297, 'Denk- und Wahrnehmungsmodell zum Phänomen der Farbe', 'artwork', '', 50.8138, 12.9299, NULL, 0),
(298, 'FRESSTheater', '', 'theatre', 50.8104, 12.9501, 'https://www.fresstheater.de/', 0),
(299, 'FRESSTheater', '', 'restaurant', 50.8105, 12.9501, 'https://www.fresstheater.de/', 0),
(300, 'Sächsisches Eisenbahnmuseum Chemnitz', 'museum', '', 50.861, 12.9533, 'https://www.sem-chemnitz.de/', 0),
(301, 'Ebersdorfer Bär', 'artwork', '', 50.8681, 12.9608, NULL, 0),
(302, 'Vereinsgaststätte KGV', '', 'restaurant', 50.8685, 12.901, NULL, 0),
(303, 'Regenschirm', 'artwork', '', 50.8306, 12.9397, NULL, 0),
(304, 'Siegmar Pizza-Kebap-Haus', '', 'restaurant', 50.818, 12.8508, NULL, 0),
(305, 'Eldorado', '', 'restaurant', 50.7869, 12.8856, NULL, 0),
(306, 'The Cook Family', '', 'restaurant', 50.819, 12.9445, 'https://thecookfamily.de/', 0),
(307, 'Schalom', '', 'restaurant', 50.8429, 12.9267, NULL, 0),
(308, '', 'artwork', '', 50.8181, 12.8526, NULL, 0),
(309, '', 'artwork', '', 50.8398, 12.8824, NULL, 0),
(310, 'Reliquie Mensch', 'artwork', '', 50.8343, 12.9276, NULL, 0),
(311, 'Taste of Asia', '', 'restaurant', 50.8345, 12.9305, NULL, 0),
(312, 'KostBar', '', 'restaurant', 50.8346, 12.9177, NULL, 0),
(313, 'Gewölberestaurant', '', 'restaurant', 50.7689, 12.8901, 'https://www.schlosshotel-chemnitz.de/restaurants/', 0),
(314, 'Schmetterling', '', 'restaurant', 50.8333, 12.9169, NULL, 0),
(315, 'Asia Imbiss und Döner Kebap', '', 'restaurant', 50.8388, 12.9031, NULL, 0),
(316, 'Di Sopra', '', 'restaurant', 50.8342, 12.9192, 'https://www.michaelis-chemnitz.de/', 0),
(317, '', 'artwork', '', 50.8215, 12.7982, NULL, 0),
(318, '', 'artwork', '', 50.8447, 12.9141, NULL, 0),
(319, 'Marianne Brandt Haus', 'museum', '', 50.8283, 12.9053, 'https://mariannebrandt-gesellschaft.de/', 0),
(320, 'Alvin - Der größte Räuchermann der Welt.', 'artwork', '', 50.8186, 12.8326, NULL, 0),
(321, 'Euro Frisch Pizza', '', 'restaurant', 50.8404, 12.9031, 'https://www.euro-frisch-pizza.de/', 0),
(322, 'Jassy`s Pizza', '', 'restaurant', 50.8365, 12.8935, 'https://jassyspizza.de/#/cl/index/shop', 0),
(323, 'SUSHIdeluxe', '', 'restaurant', 50.8528, 12.8825, 'https://sushideluxe.de/restaurants/chemnitz/', 0),
(324, 'Sushitaxi Chemnitz', '', 'restaurant', 50.8276, 12.9405, 'https://sushitaxi-online.de', 0),
(325, '40-jähriges Jubiläum der Tischlerei Neubert', 'artwork', '', 50.8914, 12.8904, NULL, 0),
(326, '', 'artwork', '', 50.8391, 12.8771, NULL, 0),
(327, 'Theo\'s', '', 'restaurant', 50.8324, 12.8968, 'https://theos-chemnitz.de/', 0),
(328, '', 'artwork', '', 50.8352, 12.9275, NULL, 0),
(329, '', 'artwork', '', 50.8227, 12.9602, NULL, 0),
(330, 'Neeberger Torso', 'artwork', '', 50.8346, 12.922, NULL, 0),
(331, 'NOMAD', '', 'restaurant', 50.8224, 12.9221, 'https://www.nomad-chemnitz.de/', 0),
(332, 'Peter Pane', '', 'restaurant', 50.8322, 12.9195, 'https://peterpane.de/', 0),
(333, 'Kopf 1973', 'artwork', '', 50.8285, 12.915, NULL, 0),
(334, 'Estela para un amigo', 'artwork', '', 50.8285, 12.9149, NULL, 0),
(335, 'Stele of 4 Lines', 'artwork', '', 50.8284, 12.9148, NULL, 0),
(336, 'Four Lines in a T', 'artwork', '', 50.8283, 12.9148, NULL, 0),
(337, 'Oben-Mit', 'artwork', '', 50.8396, 12.925, NULL, 0),
(338, 'Mon Hanoi', '', 'restaurant', 50.8646, 12.9575, 'http://www.mon-hanoi.de', 0),
(339, 'Dragon Roll Sushi', '', 'restaurant', 50.8361, 12.9368, 'https://dragonroll-sushi.com', 0),
(340, 'Panorama-Restaurant', '', 'restaurant', 50.8362, 12.921, NULL, 0),
(341, '', 'artwork', '', 50.8379, 12.918, NULL, 0),
(342, '', 'artwork', '', 50.8371, 12.9196, NULL, 0),
(343, '', 'artwork', '', 50.8375, 12.9188, NULL, 0),
(344, 'Blei-Zeichnung', 'artwork', '', 50.8374, 12.9205, NULL, 0),
(345, 'Lob des Lernens', 'artwork', '', 50.8345, 12.9255, 'https://www.stadtbibliothek-chemnitz.de/skulpturen/pmwiki.php?n=Main.Lobgedichte', 0),
(346, 'Pizzeria Bella Vista', '', 'restaurant', 50.821, 12.8468, NULL, 0),
(347, 'Kneipchen am Plan', '', 'restaurant', 50.8101, 12.9431, NULL, 0),
(348, 'HOTALO - Vietnamese Restaurant', '', 'restaurant', 50.8222, 12.9319, 'https://hotalo.com/', 0),
(349, 'MIYU Sushi Bar & Fusion', '', 'restaurant', 50.8366, 12.9349, 'https://miyu-sushichemnitz.de/', 0),
(350, 'Sidorenko', '', 'restaurant', 50.8361, 12.9367, 'www.restaurant-sidorenko.com', 0),
(351, 'Restaurant Sidorenko', '', 'restaurant', 50.8361, 12.9368, NULL, 0),
(352, 'Moli Modo', '', 'restaurant', 50.8321, 12.9183, 'https://molimodo.de/', 0),
(353, 'Nomad', '', 'restaurant', 50.8227, 12.9213, NULL, 0),
(354, '', 'artwork', '', 50.8465, 12.9306, NULL, 0),
(355, 'POPEYE Pizza & Burger\'s', '', 'restaurant', 50.8544, 12.9463, NULL, 0),
(356, 'Yuki', '', 'restaurant', 50.8447, 12.9305, 'https://yukirestaurant.de/', 0),
(357, '', 'artwork', '', 50.8242, 12.8994, NULL, 0),
(358, 'Dream of Bollywood', '', 'restaurant', 50.8168, 12.9146, NULL, 0),
(359, '', 'artwork', '', 50.8846, 12.9446, NULL, 0),
(360, 'Wandgemälde eines Zeisigs', 'artwork', '', 50.8456, 12.986, NULL, 0),
(361, '', 'artwork', '', 50.8506, 12.9067, NULL, 0),
(362, 'Döner 23', '', 'restaurant', 50.8254, 12.9414, 'https://www.dner23chemnitz.de/', 0),
(363, 'La Mela', '', 'restaurant', 50.8572, 12.886, 'https://www.lamela-chemnitz.de/', 0),
(364, 'U Brambory', '', 'restaurant', 50.8421, 12.9258, 'https://ubrambory.space/', 0),
(365, 'Ringende', 'artwork', '', 50.8294, 12.9314, NULL, 0),
(366, 'Idee Versuch eines unendlichen Menschen', 'artwork', '', 50.8295, 12.9309, NULL, 0),
(367, 'Lauschende', 'artwork', '', 50.83, 12.9296, NULL, 0),
(368, 'Tänzerin', 'artwork', '', 50.8294, 12.9311, NULL, 0),
(369, 'Hüttenstube', '', 'restaurant', 50.8204, 12.9525, NULL, 0),
(370, '', 'artwork', '', 50.8419, 12.8771, NULL, 0),
(371, 'Pizzeria Italia', '', 'restaurant', 50.8449, 12.9385, NULL, 0),
(372, '', 'artwork', '', 50.8305, 12.915, NULL, 0),
(373, 'Sultan - Schawarma & Steak Döner & Vegan', '', 'restaurant', 50.8402, 12.9279, NULL, 0),
(374, 'L\'Osteria', '', 'restaurant', 50.832, 12.918, 'https://losteria.net/de/', 0),
(375, 'Karl Schmidt-Rottluff Haus', 'museum', '', 50.835, 12.8483, NULL, 0),
(376, 'Blaue Eins Energie Skulptur', 'artwork', '', 50.8483, 12.9326, NULL, 0),
(377, '', 'artwork', '', 50.8424, 12.8768, NULL, 0),
(378, '\"Kennzeichen D\" 1997', 'artwork', '', 50.8459, 12.9261, NULL, 0),
(379, 'Der verrückte Stuhl', 'artwork', '', 50.8453, 12.9261, NULL, 0),
(380, 'Urteil der Paris', 'artwork', '', 50.8427, 12.9247, 'https://chemnitz-rund-und-bunt.de/skulpturen/rundgangB.html', 0),
(381, 'Pusteblume', 'artwork', '', 50.8422, 12.9245, NULL, 0),
(382, 'Wandbild Brühl', 'artwork', '', 50.8414, 12.9237, NULL, 0),
(383, 'Liegende', 'artwork', '', 50.8421, 12.9244, NULL, 0),
(384, 'Abstraktes Wandbild', 'artwork', '', 50.8413, 12.9234, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `is_admin`, `is_deleted`) VALUES
(1, 'admin1', 'admin@gmail.com', '$2b$12$yXo7Zo2EtYDF11V26G1HTen.VOjie.x2YccrtssgHVVRSxVJxksqu', 1, 0),
(10, 'swara', 'swara@gmail.com', '$2b$12$ChnU2kNeAYiud9usl6yLb.me9RHKhiS/iwD5s7Fzlh3fqOOe29whe', 0, 0),
(11, 'sneha', 'sneha@gmail.com', '$2b$12$5dGBv00x33YxtUJd1pSrQeZGq2aGByHcGAo7Z.M6w2TPwwRb3QIRS', 0, 0),
(12, 'komal', 'komal@gmail.com', '$2b$12$Sqd1qbA0eMTJyp1c0PhcJuoPsHGfuOKUbk1VuNG3ML6DYHGOTKEEG', 0, 0),
(13, 'ben', 'ben@gmail.com', '$2b$12$WDS12Hs2F/.5u7uSxk8x4eIrw4bqZi5gIkonDPqMNfzl5L2K3LNeW', 0, 1),
(14, 'tinu', 'tina@gmail.com', '$2b$12$J77R44VHdBTKf1DWidKli.q5dlxSPWtidYdPyr8vSAKqt.lxvKoDe', 0, 0),
(16, 'nish', 'nish@gmail.com', '$2b$12$kqXinWF.qECAzyYOHKdyruNWO5j/W1ipM.CVD02drebroyfGHwZh2', 0, 0),
(17, 'max', 'max@gmail.com', '$2b$12$lT0HDld4jbV7cE62l2FTWO3x8VecmHG9t84qSM9MwusQxadhqaCmK', 0, 1),
(18, 'nishu', 'nishu@gmail.com', '$2b$12$2YrWIOLdRoPFt53hW/r6mu.G2ZeHZQqDHlFzVD8G7R34bsUZJg5.m', 0, 0),
(19, 'preethi', 'preethi@gmail.com', '$2b$12$gwbt6MIrggVDeTchOQKBFeNqdELS1TaUpU9JEDhPQN7f2x2ZDarK6', 0, 0),
(20, 'nis', 'ullamco sint', '$2b$12$jCJXFFS4Lr49lfWVQQXqFeptgHwlHQfYIOlSpwSZHD0vbWZ7YyrtO', 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `site_id` (`site_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `site_id` (`site_id`);

--
-- Indexes for table `sites`
--
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sites`
--
ALTER TABLE `sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=385;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
