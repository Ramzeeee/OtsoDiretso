-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 08:02 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `thesis_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `conversation_id` char(36) DEFAULT NULL,
  `guest_session_token` varchar(255) DEFAULT NULL,
  `role` enum('user','bot') NOT NULL,
  `message` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `user_id`, `conversation_id`, `guest_session_token`, `role`, `message`, `created_at`, `updated_at`) VALUES
(11, 7, NULL, NULL, 'user', 'Hello', '2026-04-30 10:20:30', '2026-04-30 10:20:30'),
(12, 7, NULL, NULL, 'bot', 'You said: Hello', '2026-04-30 10:20:33', '2026-04-30 10:20:33'),
(13, 7, NULL, NULL, 'user', 'How are you doing', '2026-04-30 10:20:39', '2026-04-30 10:20:39'),
(14, 7, NULL, NULL, 'bot', 'You said: How are you doing', '2026-04-30 10:20:39', '2026-04-30 10:20:39'),
(15, 7, NULL, NULL, 'user', 'hello', '2026-04-30 10:25:30', '2026-04-30 10:25:30'),
(16, 7, NULL, NULL, 'bot', 'You said: hello', '2026-04-30 10:25:30', '2026-04-30 10:25:30'),
(17, 7, NULL, NULL, 'user', 'yes', '2026-04-30 10:25:31', '2026-04-30 10:25:31'),
(18, 7, NULL, NULL, 'bot', 'You said: yes', '2026-04-30 10:25:31', '2026-04-30 10:25:31'),
(19, 7, NULL, NULL, 'user', 'hello', '2026-04-30 10:27:20', '2026-04-30 10:27:20'),
(20, 7, NULL, NULL, 'bot', 'You said: hello', '2026-04-30 10:27:20', '2026-04-30 10:27:20'),
(21, 7, NULL, NULL, 'user', 'hi', '2026-04-30 10:29:59', '2026-04-30 10:29:59'),
(22, 7, NULL, NULL, 'bot', 'You said: hi', '2026-04-30 10:29:59', '2026-04-30 10:29:59'),
(23, 7, NULL, NULL, 'user', 'hi', '2026-04-30 10:30:02', '2026-04-30 10:30:02'),
(24, 7, NULL, NULL, 'bot', 'You said: hi', '2026-04-30 10:30:02', '2026-04-30 10:30:02'),
(25, 7, NULL, NULL, 'user', 'hello', '2026-04-30 10:32:30', '2026-04-30 10:32:30'),
(26, 7, NULL, NULL, 'bot', 'You said: hello', '2026-04-30 10:32:30', '2026-04-30 10:32:30'),
(27, 7, NULL, NULL, 'user', 'hi', '2026-04-30 10:32:31', '2026-04-30 10:32:31'),
(28, 7, NULL, NULL, 'bot', 'You said: hi', '2026-04-30 10:32:31', '2026-04-30 10:32:31'),
(29, 7, NULL, NULL, 'user', 'hi', '2026-04-30 10:46:31', '2026-04-30 10:46:31'),
(30, 7, NULL, NULL, 'bot', 'You said: hi', '2026-04-30 10:46:32', '2026-04-30 10:46:32'),
(31, 7, NULL, NULL, 'user', 'hi', '2026-04-30 10:51:11', '2026-04-30 10:51:11'),
(32, 7, NULL, NULL, 'bot', 'You said: hi', '2026-04-30 10:51:11', '2026-04-30 10:51:11');

-- --------------------------------------------------------

--
-- Table structure for table `disclaimer_acknowledgments`
--

CREATE TABLE `disclaimer_acknowledgments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `guest_session_token` varchar(255) DEFAULT NULL,
  `acknowledged_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guest_sessions`
--

CREATE TABLE `guest_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotlines`
--

CREATE TABLE `hotlines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_02_23_044129_create_personal_access_tokens_table', 1),
(5, '2026_02_23_044340_create_guest_sessions_table', 1),
(6, '2026_02_23_044350_create_disclaimer_acknowledgments_table', 1),
(7, '2026_03_09_155144_create_chat_messages_table', 1),
(8, '2026_03_10_130221_create_hotlines_table', 1),
(9, '2026_04_29_034325_create_password_resets_table', 2),
(10, '2026_04_29_044115_create_password_resets_table', 3),
(11, '2026_04_30_175658_add_conversation_id_to_chat_messages', 4);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'b76d91904c422d2bf92dccedb324b403373cefe9d24f9de83b5f8fb5c3cc4687', '[\"*\"]', NULL, NULL, '2026-04-22 08:15:51', '2026-04-22 08:15:51'),
(2, 'App\\Models\\User', 1, 'auth_token', '7edf93f4d006d79b0eb831a824223187d8fc7c57994ffd21b8f7ef2012b39676', '[\"*\"]', NULL, NULL, '2026-04-22 08:16:10', '2026-04-22 08:16:10'),
(3, 'App\\Models\\User', 2, 'auth_token', '63d8b070a29d9b9d78566462bed51f5a3eb34b01d7640b0c3729b481b4a3d4b5', '[\"*\"]', NULL, NULL, '2026-04-22 08:19:11', '2026-04-22 08:19:11'),
(4, 'App\\Models\\User', 2, 'auth_token', 'c6431091b1400e54c4117601f88601df1df43f7b99331583c31df814801fcbc9', '[\"*\"]', NULL, NULL, '2026-04-22 08:23:03', '2026-04-22 08:23:03'),
(5, 'App\\Models\\User', 2, 'auth_token', '4271e5c0f94a8caef4f8a61b8136e354823e28c3b68487c333f8022ab8cada50', '[\"*\"]', NULL, NULL, '2026-04-22 08:23:18', '2026-04-22 08:23:18'),
(6, 'App\\Models\\User', 1, 'auth_token', 'b56314797202045c88024be40c971aa210f55ab17f6a7a0c1771209db686fc57', '[\"*\"]', NULL, NULL, '2026-04-22 08:26:42', '2026-04-22 08:26:42'),
(7, 'App\\Models\\User', 1, 'auth_token', '835f28feb2a6f8f1f5279a0a37c8e795f53a97883ee64bdac41acadbdf85463d', '[\"*\"]', NULL, NULL, '2026-04-22 08:33:28', '2026-04-22 08:33:28'),
(8, 'App\\Models\\User', 1, 'auth_token', '83ea200439d2207fc8d97d03e1721d10a05152418837a9325c3da0ce67abe8e6', '[\"*\"]', NULL, NULL, '2026-04-22 08:47:26', '2026-04-22 08:47:26'),
(9, 'App\\Models\\User', 4, 'auth_token', '750ff5d7da97a6fd2e10a2085cbee24a23095f05331fe2bc49c6e2faf4cfa256', '[\"*\"]', NULL, NULL, '2026-04-22 09:07:41', '2026-04-22 09:07:41'),
(10, 'App\\Models\\User', 1, 'auth_token', 'fa05715133d758591a50d72e3a6edc36153736c663fd8331aa7258422a861f34', '[\"*\"]', NULL, NULL, '2026-04-22 09:08:42', '2026-04-22 09:08:42'),
(11, 'App\\Models\\User', 5, 'auth_token', 'fd6b646200c8da89910825fee94909436977cb50e83510dcea73734745e7f51a', '[\"*\"]', '2026-04-22 09:09:49', NULL, '2026-04-22 09:09:43', '2026-04-22 09:09:49'),
(12, 'App\\Models\\User', 6, 'auth_token', '073a8a0824594d6888e7204e2f4fbe56ff2e8947af0c5757471b216787484fcb', '[\"*\"]', NULL, NULL, '2026-04-28 18:02:46', '2026-04-28 18:02:46'),
(13, 'App\\Models\\User', 6, 'auth_token', '335c4ae77d4efd0351f46d38c7a31c09d650ae26cc30f38fb400c2f58b0dfe52', '[\"*\"]', NULL, NULL, '2026-04-28 18:05:11', '2026-04-28 18:05:11'),
(14, 'App\\Models\\User', 6, 'auth_token', '741b6e4ffab95468677e3c3bcb2f7e992e6d94c862c5a071b6b830da5ddd0c64', '[\"*\"]', NULL, NULL, '2026-04-28 18:10:29', '2026-04-28 18:10:29'),
(15, 'App\\Models\\User', 6, 'auth_token', '4df15f340409af33a432939891ff0216db6b5c8a230384f91409aa038fd7f196', '[\"*\"]', NULL, NULL, '2026-04-28 18:12:43', '2026-04-28 18:12:43'),
(16, 'App\\Models\\User', 6, 'auth_token', 'ecc9a3acc3380cd8cf49f2b87e77668ebeaa11e47fb974eec27e733eb9c0c7f0', '[\"*\"]', NULL, NULL, '2026-04-28 18:15:11', '2026-04-28 18:15:11'),
(17, 'App\\Models\\User', 6, 'auth_token', '22566bd05de1a5ae91f4c2975492f933c3ea22ed45090947dcf3c2cde68b3361', '[\"*\"]', NULL, NULL, '2026-04-28 18:25:38', '2026-04-28 18:25:38'),
(18, 'App\\Models\\User', 7, 'auth_token', 'b62e1c3edc7d56375aaae8dc427cec1251e6d539f2092aab3748d72ea8b5b01f', '[\"*\"]', NULL, NULL, '2026-04-28 21:00:44', '2026-04-28 21:00:44'),
(19, 'App\\Models\\User', 7, 'auth_token', '0f221f73fa943db0b31b05eba75db2d37face73784bd0e2b96f02d269c0b386b', '[\"*\"]', '2026-04-29 00:39:50', NULL, '2026-04-29 00:17:46', '2026-04-29 00:39:50'),
(20, 'App\\Models\\User', 7, 'auth_token', '3cafee0834ece262ae75c612a6dc679e6eb8a775d98c822928d20cb4cbc6d914', '[\"*\"]', NULL, NULL, '2026-04-30 08:47:16', '2026-04-30 08:47:16'),
(21, 'App\\Models\\User', 6, 'auth_token', '0fd4ca3c0b0ed921768849a0f1386d776bef54feed68c04ba17a6cc615dfa659', '[\"*\"]', NULL, NULL, '2026-04-30 09:03:03', '2026-04-30 09:03:03'),
(22, 'App\\Models\\User', 6, 'auth_token', '4cbedd2a645de72416b991c8c86c129e95296352bf8e2ea7a7da6993c025b11c', '[\"*\"]', NULL, NULL, '2026-04-30 09:34:29', '2026-04-30 09:34:29'),
(23, 'App\\Models\\User', 6, 'auth_token', 'f2b78e406d70a9fb37ecdc645a2d4e442197d3a6a9e07c8f3a6080c761e84d8d', '[\"*\"]', NULL, NULL, '2026-04-30 09:39:51', '2026-04-30 09:39:51'),
(24, 'App\\Models\\User', 6, 'auth_token', '1fab54c7933d4a02064388232fa4062ab113a32e459da8635cec3543af49de8b', '[\"*\"]', NULL, NULL, '2026-04-30 09:45:53', '2026-04-30 09:45:53'),
(25, 'App\\Models\\User', 6, 'auth_token', '8a4c63a430c8fdbbafc9db6f72f06714d291d99294eefeae3090ff5b8745ee33', '[\"*\"]', NULL, NULL, '2026-04-30 09:46:19', '2026-04-30 09:46:19'),
(26, 'App\\Models\\User', 7, 'auth_token', 'a6b82bd6f763e0c300136c09f5e5c12aad34ee48f0136e27cd61af9530361464', '[\"*\"]', NULL, NULL, '2026-04-30 09:48:03', '2026-04-30 09:48:03'),
(27, 'App\\Models\\User', 7, 'auth_token', '911a7cd35c4d04382151165054db943148020b68f19862aba7c5cce572ffe51c', '[\"*\"]', '2026-04-30 10:20:39', NULL, '2026-04-30 10:20:19', '2026-04-30 10:20:39'),
(28, 'App\\Models\\User', 7, 'auth_token', '82c80c95a44730f9c09c26962131cb881b825e318d3384a214370013abdf9d49', '[\"*\"]', '2026-04-30 10:30:02', NULL, '2026-04-30 10:25:27', '2026-04-30 10:30:02'),
(29, 'App\\Models\\User', 7, 'auth_token', '13c49dbd71385b01189fa434dc7583826752adbee1a762d4b4b5e3adf01188ca', '[\"*\"]', '2026-04-30 10:32:31', NULL, '2026-04-30 10:32:26', '2026-04-30 10:32:31'),
(30, 'App\\Models\\User', 7, 'auth_token', '6ec4cccd8c9f9404795e4acf133fd644c43fc46a8e031d35d222bcf472de84c6', '[\"*\"]', '2026-04-30 10:37:41', NULL, '2026-04-30 10:37:37', '2026-04-30 10:37:41'),
(31, 'App\\Models\\User', 7, 'auth_token', 'f57e65af11abaa587c724f2c48f6cabfc7f3b4fea8b93eb9be30c85b25544fb6', '[\"*\"]', '2026-04-30 10:46:31', NULL, '2026-04-30 10:42:40', '2026-04-30 10:46:31'),
(32, 'App\\Models\\User', 6, 'auth_token', '032381e317a9dd0b84f851b6455cd1563504080dd0675381ab3bb6efa7b2f7b4', '[\"*\"]', NULL, NULL, '2026-04-30 10:49:11', '2026-04-30 10:49:11'),
(33, 'App\\Models\\User', 7, 'auth_token', '2564d732defa93fa17d49e5f6e4e20ff2df1630838ea1ca5c2fa892e249c8bc5', '[\"*\"]', '2026-04-30 10:51:11', NULL, '2026-04-30 10:51:07', '2026-04-30 10:51:11'),
(34, 'App\\Models\\User', 10, 'auth_token', '2e5f7497c36f606c562af527c19f99f73b598febbf8adbe69d76465634cd0b7f', '[\"*\"]', NULL, NULL, '2026-05-03 09:32:36', '2026-05-03 09:32:36'),
(35, 'App\\Models\\User', 10, 'auth_token', 'a06214545b05471cc3c42c40420dbdf3557067be4a3b752ce4027e09ecca718c', '[\"*\"]', NULL, NULL, '2026-05-03 09:45:59', '2026-05-03 09:45:59'),
(36, 'App\\Models\\User', 15, 'auth_token', '373e33b1032120561a0d05c82fbe4620ae6fc8a60314ead87b31aed7df25f832', '[\"*\"]', NULL, NULL, '2026-05-03 09:59:15', '2026-05-03 09:59:15'),
(37, 'App\\Models\\User', 7, 'auth_token', '04a5c988360b54c7824354a98b63714ff8076824bf4394048f2882adb4f633a7', '[\"*\"]', NULL, NULL, '2026-05-03 10:01:15', '2026-05-03 10:01:15');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `school_id` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'client',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `school_id`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(6, 'Admin', 'User', '000001', 'admin01@slu.edu.ph', '$2y$12$NHukupB4xLUNwJ3Oljv4HOLrwqfbhGrRhBHmDtawk0PDUiNMxJ8pm', 'admin', '2026-04-28 17:52:22', '2026-04-28 17:52:22'),
(7, 'ADRIAN', 'ORDONIO', '2232690', '2232690@slu.edu.ph', '$2y$12$i2GhBTX3kw9o.yEkj5tzzOMUC5zWhGGegqTv1VpmMC/Kdq4fQGDFq', 'client', '2026-04-28 18:05:47', '2026-05-03 10:00:52'),
(10, 'Thesis', 'Admin', '000002', 'thesisadmin@gmail.com', '$2y$12$eyyUpkSCuLKjibECpMfTqeIDFnqvnuJNJrwI8HGUoFFf20A/xmX8C', 'admin', '2026-04-28 19:39:58', '2026-04-28 19:39:58'),
(15, 'Jermaine', 'Pascual', '2233130', '2233130@slu.edu.ph', '$2y$12$xFIseiYWK0LBeFaJ7KpQOOr.amyP0Dln6yz46G92rFHQ5QF3w4pei', 'admin', '2026-04-30 10:49:54', '2026-05-03 09:58:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_messages_user_id_foreign` (`user_id`);

--
-- Indexes for table `disclaimer_acknowledgments`
--
ALTER TABLE `disclaimer_acknowledgments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `disclaimer_acknowledgments_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `guest_sessions`
--
ALTER TABLE `guest_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guest_sessions_session_token_unique` (`session_token`);

--
-- Indexes for table `hotlines`
--
ALTER TABLE `hotlines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_school_id_unique` (`school_id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `disclaimer_acknowledgments`
--
ALTER TABLE `disclaimer_acknowledgments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guest_sessions`
--
ALTER TABLE `guest_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotlines`
--
ALTER TABLE `hotlines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `disclaimer_acknowledgments`
--
ALTER TABLE `disclaimer_acknowledgments`
  ADD CONSTRAINT `disclaimer_acknowledgments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
