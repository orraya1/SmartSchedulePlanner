-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Oct 09, 2026 at 09:00 AM
-- Server version: 8.0.46
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `study_scheduler`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_sessions`
--

CREATE TABLE `auth_sessions` (
  `token_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_sessions`
--

INSERT INTO `auth_sessions` (`token_hash`, `user_id`, `expires_at`, `created_at`) VALUES
('780b808bf30f43c7bcc5f62ebee0727ffb94cf545d2e8cdc60b2bba356864d31', 41, '2026-10-09 18:46:41', '2026-10-02 11:46:41'),
('7a19e618d7ff01f5b91314aff41e557f116fcde17916936a8abd26c0d5e5524a', 48, '2026-10-11 18:35:43', '2026-10-04 11:35:43'),
('8d6b3013cb2497809f6c99a8dfc80d3ae72b61868f5ddd1481a86a73bb6f9dcb', 2, '2026-10-13 16:23:02', '2026-10-06 09:23:01'),
('9f8df32e26ed80e3eacd5081c6e5e3f1e9b7d0c03451df918fca331c08c27818', 41, '2026-10-09 20:42:44', '2026-10-02 13:42:43'),
('ccf3015e07e14b367a5fb1d24f8a06cba63172996583a2c8c6df7cf3300e9787', 41, '2026-10-09 18:25:11', '2026-10-02 11:25:10'),
('fedcddd750ac6dc6c7047a1d8bc53b4b872b48368026436dcb4e08242ec84159', 3, '2026-10-15 17:14:36', '2026-10-08 10:14:36');

-- --------------------------------------------------------

--
-- Table structure for table `manual_study_blocks`
--

CREATE TABLE `manual_study_blocks` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `subject_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day_index` tinyint UNSIGNED NOT NULL,
  `start_time` time NOT NULL,
  `duration_minutes` smallint UNSIGNED NOT NULL,
  `block_type` enum('study','review','understanding','planning') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'study',
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manual_study_blocks`
--

INSERT INTO `manual_study_blocks` (`id`, `user_id`, `category_id`, `subject_key`, `day_index`, `start_time`, `duration_minutes`, `block_type`, `is_completed`, `created_at`) VALUES
(15, 46, 59, 'custom_f1c50c8cd31e23aed775519f', 5, '08:00:00', 60, 'review', 1, '2026-10-04 09:54:31'),
(16, 47, 62, 'custom_09f7ac850f3e7ff42e0ad836', 5, '08:00:00', 120, 'review', 1, '2026-10-04 10:54:36'),
(17, 48, 64, 'custom_fb4e8e4463c41cebdda2c656', 5, '08:00:00', 120, 'review', 0, '2026-10-04 11:41:18');

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `week_start_date` date NOT NULL,
  `days_per_week` tinyint UNSIGNED NOT NULL,
  `sessions_per_day` tinyint UNSIGNED NOT NULL,
  `start_time` time NOT NULL DEFAULT '20:00:00',
  `end_time` time NOT NULL DEFAULT '22:00:00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `user_id`, `category_id`, `week_start_date`, `days_per_week`, `sessions_per_day`, `start_time`, `end_time`, `created_at`) VALUES
(114, 45, 52, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 09:35:58'),
(115, 45, 52, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 09:36:50'),
(116, 45, 52, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 09:37:16'),
(117, 45, 52, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 09:37:49'),
(118, 45, 52, '2026-09-28', 5, 9, '09:00:00', '22:00:00', '2026-10-04 09:38:19'),
(120, 46, 59, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 09:49:21'),
(121, 46, 59, '2026-09-28', 5, 10, '08:00:00', '22:00:00', '2026-10-04 09:51:09'),
(122, 46, 59, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 09:53:37'),
(123, 47, 62, '2026-09-28', 2, 10, '08:00:00', '22:00:00', '2026-10-04 10:52:40'),
(124, 47, 62, '2026-09-28', 2, 10, '08:00:00', '22:00:00', '2026-10-04 10:53:40'),
(125, 47, 62, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 10:55:00'),
(126, 48, 64, '2026-09-28', 5, 10, '08:00:00', '22:00:00', '2026-10-04 11:37:51'),
(127, 48, 63, '2026-09-28', 5, 10, '08:00:00', '22:00:00', '2026-10-04 11:44:12'),
(128, 48, 63, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 11:52:36'),
(129, 48, 63, '2026-09-28', 5, 2, '20:00:00', '22:00:00', '2026-10-04 11:55:44'),
(146, 3, 70, '2026-10-05', 5, 5, '08:00:00', '16:00:00', '2026-10-08 10:57:38'),
(147, 3, 70, '2026-10-05', 5, 5, '08:00:00', '16:00:00', '2026-10-09 06:46:12'),
(148, 3, 70, '2026-10-05', 5, 5, '08:00:00', '16:00:00', '2026-10-09 06:46:25');

-- --------------------------------------------------------

--
-- Table structure for table `study_activities`
--

CREATE TABLE `study_activities` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `activity_type` enum('study','homework','project','review') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course_key` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_subject_key` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `weight` tinyint UNSIGNED NOT NULL DEFAULT '20',
  `duration_hours` decimal(5,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_activities`
--

INSERT INTO `study_activities` (`id`, `user_id`, `category_id`, `activity_type`, `course_key`, `activity_subject_key`, `title`, `details`, `weight`, `duration_hours`, `start_date`, `end_date`, `start_time`, `end_time`, `is_completed`, `created_at`) VALUES
(18, 41, 49, 'study', NULL, 'custom_b9645e05da5446d54a9c0527', 'อ่านหนังสือ', '----', 30, 3.00, '2026-10-03', '2026-10-03', '08:46:00', '16:46:00', 1, '2026-10-03 15:46:50'),
(21, 46, 59, 'homework', 'custom_3441b96581e040c11730c1e8', 'custom_2f98658a6554216071b64dd6', 'ทำการบ้าน', 'ขขขข', 30, 4.00, '2026-10-04', '2026-10-04', '08:00:00', '16:00:00', 1, '2026-10-04 09:53:07'),
(22, 48, 64, 'homework', NULL, 'custom_b23d825fbc392ae8e58e2745', 'ทำการบ้าน', NULL, 30, 2.00, '2026-10-04', '2026-10-10', '08:00:00', '19:00:00', 0, '2026-10-04 11:39:34');

-- --------------------------------------------------------

--
-- Table structure for table `study_categories`
--

CREATE TABLE `study_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `future_note` text COLLATE utf8mb4_unicode_ci,
  `lecture_notes` text COLLATE utf8mb4_unicode_ci,
  `schedule_mode` enum('genetic','manual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'genetic',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_categories`
--

INSERT INTO `study_categories` (`id`, `user_id`, `name`, `future_note`, `lecture_notes`, `schedule_mode`, `created_at`) VALUES
(49, 41, 'อ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-02 11:49:06'),
(52, 45, 'แผนการอ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-04 09:00:27'),
(59, 46, 'แผนการอ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-04 09:23:11'),
(62, 47, 'แผนการอ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-04 10:49:08'),
(63, 48, 'แผนการอ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-04 11:35:43'),
(64, 48, 'อ่านสอบ', NULL, NULL, 'genetic', '2026-10-04 11:36:12'),
(66, 2, 'แผนการอ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-06 07:50:23'),
(70, 3, 'แผนการอ่านหนังสือ', NULL, NULL, 'genetic', '2026-10-08 10:14:36');

-- --------------------------------------------------------

--
-- Table structure for table `study_schedule_events`
--

CREATE TABLE `study_schedule_events` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `schedule_id` bigint UNSIGNED DEFAULT NULL,
  `event_type` enum('ga_generated','session_customized','session_completed','manual_block_added','manual_block_completed','manual_block_removed','mode_changed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_schedule_events`
--

INSERT INTO `study_schedule_events` (`id`, `user_id`, `category_id`, `schedule_id`, `event_type`, `details`, `created_at`) VALUES
(17, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"physics\", \"custom_322029818c3c2e6eeff5c052\", \"custom_11ed4311f152984cff3b7d99\", \"custom_e70ab14bc5f9f893e794bfde\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 65}', '2026-10-03 10:42:31'),
(18, 41, 49, NULL, 'manual_block_added', '{\"blockId\": 10, \"dayIndex\": 5, \"blockType\": \"study\", \"startTime\": \"08:00\", \"subjectKey\": \"physics\", \"durationMinutes\": 30}', '2026-10-03 10:44:49'),
(19, 41, 49, NULL, 'manual_block_completed', '{\"blockId\": 10, \"dayIndex\": 5, \"startTime\": \"08:00\", \"subjectKey\": \"physics\", \"durationMinutes\": 30}', '2026-10-03 10:44:52'),
(20, 41, 49, NULL, 'manual_block_completed', '{\"blockId\": 10, \"dayIndex\": 5, \"startTime\": \"08:00\", \"subjectKey\": \"physics\", \"durationMinutes\": 30}', '2026-10-03 10:44:56'),
(21, 41, 49, NULL, 'manual_block_removed', '{\"blockId\": 10, \"dayIndex\": 5, \"blockType\": \"study\", \"startTime\": \"08:00\", \"subjectKey\": \"physics\", \"wasCompleted\": false, \"durationMinutes\": 30}', '2026-10-03 10:44:59'),
(22, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"physics\", \"custom_322029818c3c2e6eeff5c052\", \"custom_11ed4311f152984cff3b7d99\", \"custom_e70ab14bc5f9f893e794bfde\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-03 11:00:00'),
(23, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"custom_322029818c3c2e6eeff5c052\", \"custom_25801c886f72504fdace208e\", \"custom_7feb05a0e82f64aad64a0681\", \"custom_a43a54b7166c8c453841b936\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-03 11:06:05'),
(24, 41, 49, NULL, 'manual_block_added', '{\"blockId\": 11, \"dayIndex\": 5, \"blockType\": \"understanding\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"durationMinutes\": 30}', '2026-10-03 11:08:06'),
(25, 41, 49, NULL, 'manual_block_completed', '{\"blockId\": 11, \"dayIndex\": 5, \"startTime\": \"08:00\", \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"durationMinutes\": 30}', '2026-10-03 11:08:07'),
(26, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"custom_322029818c3c2e6eeff5c052\", \"custom_25801c886f72504fdace208e\", \"custom_7feb05a0e82f64aad64a0681\", \"custom_a43a54b7166c8c453841b936\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-03 11:08:19'),
(27, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"custom_322029818c3c2e6eeff5c052\", \"custom_25801c886f72504fdace208e\", \"custom_7feb05a0e82f64aad64a0681\", \"custom_a43a54b7166c8c453841b936\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-03 11:08:22'),
(28, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"custom_322029818c3c2e6eeff5c052\", \"custom_25801c886f72504fdace208e\", \"custom_7feb05a0e82f64aad64a0681\", \"custom_a43a54b7166c8c453841b936\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-03 11:08:23'),
(29, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5116, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 0}', '2026-10-03 11:08:43'),
(30, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5136, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 0}', '2026-10-03 11:08:44'),
(31, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5126, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 0}', '2026-10-03 11:08:44'),
(32, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5146, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 0}', '2026-10-03 11:08:45'),
(33, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5156, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 0}', '2026-10-03 11:08:46'),
(34, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5127, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 1}', '2026-10-03 11:08:47'),
(35, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5117, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 1}', '2026-10-03 11:08:48'),
(36, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5137, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 1}', '2026-10-03 11:08:49'),
(37, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5147, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 1}', '2026-10-03 11:08:50'),
(38, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5157, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 1}', '2026-10-03 11:08:51'),
(39, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5128, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 2}', '2026-10-03 11:08:58'),
(40, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5118, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 2}', '2026-10-03 11:08:58'),
(41, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5138, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 2}', '2026-10-03 11:08:59'),
(42, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5148, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 2}', '2026-10-03 11:09:00'),
(43, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5158, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 2}', '2026-10-03 11:09:00'),
(44, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5159, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 3}', '2026-10-03 11:09:02'),
(45, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5149, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 3}', '2026-10-03 11:09:02'),
(46, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5139, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 3}', '2026-10-03 11:09:03'),
(47, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5129, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 3}', '2026-10-03 11:09:03'),
(48, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5119, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 3}', '2026-10-03 11:09:04'),
(49, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5120, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 4}', '2026-10-03 11:09:05'),
(50, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5130, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 4}', '2026-10-03 11:09:05'),
(51, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5140, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 4}', '2026-10-03 11:09:06'),
(52, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5150, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 4}', '2026-10-03 11:09:07'),
(53, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5160, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 4}', '2026-10-03 11:09:07'),
(54, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5161, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 5}', '2026-10-03 11:09:08'),
(55, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5151, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 5}', '2026-10-03 11:09:09'),
(56, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5141, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 5}', '2026-10-03 11:09:10'),
(57, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5131, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 5}', '2026-10-03 11:09:10'),
(58, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5121, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 5}', '2026-10-03 11:09:11'),
(59, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5132, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 6}', '2026-10-03 11:09:13'),
(60, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5122, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 6}', '2026-10-03 11:09:13'),
(61, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5142, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 6}', '2026-10-03 11:09:14'),
(62, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5152, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 6}', '2026-10-03 11:09:15'),
(63, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5162, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 6}', '2026-10-03 11:09:16'),
(64, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5163, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 7}', '2026-10-03 11:09:17'),
(65, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5153, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 7}', '2026-10-03 11:09:18'),
(66, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5143, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 7}', '2026-10-03 11:09:18'),
(67, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5133, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 7}', '2026-10-03 11:09:19'),
(68, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5123, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 7}', '2026-10-03 11:09:20'),
(69, 41, 49, NULL, 'manual_block_completed', '{\"blockId\": 11, \"dayIndex\": 5, \"startTime\": \"08:00\", \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"durationMinutes\": 30}', '2026-10-03 11:28:29'),
(70, 41, 49, NULL, 'manual_block_added', '{\"blockId\": 12, \"dayIndex\": 6, \"blockType\": \"review\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"durationMinutes\": 60}', '2026-10-03 11:28:40'),
(71, 41, 49, NULL, 'manual_block_completed', '{\"blockId\": 12, \"dayIndex\": 6, \"startTime\": \"08:00\", \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"durationMinutes\": 60}', '2026-10-03 11:28:41'),
(72, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5124, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 8}', '2026-10-03 11:29:43'),
(73, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5134, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 8}', '2026-10-03 11:29:43'),
(74, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5144, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 8}', '2026-10-03 11:29:44'),
(75, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5154, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 8}', '2026-10-03 11:29:44'),
(76, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5164, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 8}', '2026-10-03 11:29:45'),
(77, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5125, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 9}', '2026-10-03 11:29:46'),
(78, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5135, \"subjectKey\": \"custom_25801c886f72504fdace208e\", \"sessionIndex\": 9}', '2026-10-03 11:29:47'),
(79, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5145, \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"sessionIndex\": 9}', '2026-10-03 11:29:48'),
(80, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5155, \"subjectKey\": \"custom_a43a54b7166c8c453841b936\", \"sessionIndex\": 9}', '2026-10-03 11:29:49'),
(81, 41, 49, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5165, \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"sessionIndex\": 9}', '2026-10-03 11:29:49'),
(82, 41, 49, NULL, 'manual_block_removed', '{\"blockId\": 11, \"dayIndex\": 5, \"blockType\": \"understanding\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_322029818c3c2e6eeff5c052\", \"wasCompleted\": true, \"durationMinutes\": 30}', '2026-10-03 11:31:30'),
(83, 41, 49, NULL, 'manual_block_removed', '{\"blockId\": 12, \"dayIndex\": 6, \"blockType\": \"review\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_7feb05a0e82f64aad64a0681\", \"wasCompleted\": true, \"durationMinutes\": 60}', '2026-10-03 11:31:31'),
(84, 41, 49, NULL, 'manual_block_added', '{\"blockId\": 13, \"dayIndex\": 0, \"blockType\": \"study\", \"startTime\": \"06:00\", \"subjectKey\": \"custom_8bdb62e175af5ec75ec30d95\", \"durationMinutes\": 30}', '2026-10-03 13:54:31'),
(85, 41, 49, NULL, 'manual_block_completed', '{\"blockId\": 13, \"dayIndex\": 0, \"startTime\": \"06:00\", \"subjectKey\": \"custom_8bdb62e175af5ec75ec30d95\", \"durationMinutes\": 30}', '2026-10-03 13:54:33'),
(86, 41, 49, NULL, 'ga_generated', '{\"subjects\": [\"custom_322029818c3c2e6eeff5c052\", \"custom_25801c886f72504fdace208e\", \"custom_94682ff2e7a6021e9d5fe680\", \"custom_a43a54b7166c8c453841b936\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-03 14:33:31'),
(87, 45, 52, NULL, 'manual_block_added', '{\"blockId\": 14, \"dayIndex\": 0, \"blockType\": \"study\", \"startTime\": \"18:00\", \"subjectKey\": \"custom_eef43e3c78eebc67d1c62e1b\", \"durationMinutes\": 45}', '2026-10-04 09:01:20'),
(88, 45, 52, NULL, 'manual_block_removed', '{\"blockId\": 14, \"dayIndex\": 0, \"blockType\": \"study\", \"startTime\": \"18:00\", \"subjectKey\": \"custom_eef43e3c78eebc67d1c62e1b\", \"wasCompleted\": false, \"durationMinutes\": 45}', '2026-10-04 09:01:26'),
(95, 45, 52, 114, 'ga_generated', '{\"subjects\": [\"custom_95c1c7aef8fa1e6bb04aa87d\", \"custom_9eb1d8698ea8ac9a298e237e\", \"custom_359454e8b5bb568c7f92c25b\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:35:58'),
(96, 45, 52, 115, 'ga_generated', '{\"subjects\": [\"custom_06a7bf6cdf97844c8e2324ca\", \"custom_95c1c7aef8fa1e6bb04aa87d\", \"custom_9eb1d8698ea8ac9a298e237e\", \"custom_c466ffc5454d46b810a0f550\", \"custom_359454e8b5bb568c7f92c25b\", \"custom_cbd0116aaae19fee4b97147e\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:36:50'),
(97, 45, 52, 116, 'ga_generated', '{\"subjects\": [\"custom_06a7bf6cdf97844c8e2324ca\", \"custom_95c1c7aef8fa1e6bb04aa87d\", \"custom_9eb1d8698ea8ac9a298e237e\", \"custom_c466ffc5454d46b810a0f550\", \"custom_359454e8b5bb568c7f92c25b\", \"custom_cbd0116aaae19fee4b97147e\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:37:16'),
(98, 45, 52, 117, 'ga_generated', '{\"subjects\": [\"custom_06a7bf6cdf97844c8e2324ca\", \"custom_95c1c7aef8fa1e6bb04aa87d\", \"custom_9eb1d8698ea8ac9a298e237e\", \"custom_c466ffc5454d46b810a0f550\", \"custom_359454e8b5bb568c7f92c25b\", \"custom_cbd0116aaae19fee4b97147e\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:37:49'),
(99, 45, 52, 118, 'ga_generated', '{\"subjects\": [\"custom_06a7bf6cdf97844c8e2324ca\", \"custom_95c1c7aef8fa1e6bb04aa87d\", \"custom_9eb1d8698ea8ac9a298e237e\", \"custom_c466ffc5454d46b810a0f550\", \"custom_359454e8b5bb568c7f92c25b\", \"custom_cbd0116aaae19fee4b97147e\"], \"startTime\": \"09:00\", \"daysPerWeek\": 5, \"sessionCount\": 45}', '2026-10-04 09:38:19'),
(100, 46, 59, NULL, 'ga_generated', '{\"subjects\": [\"custom_f05bee1848eea6d938180f8c\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:43:53'),
(101, 46, 59, 120, 'ga_generated', '{\"subjects\": [\"custom_3441b96581e040c11730c1e8\", \"custom_f1c50c8cd31e23aed775519f\", \"custom_7db8ffee6fe3163bc68b7831\", \"custom_b6ed7968bff3b6e03df5735e\", \"custom_c3d3e71f8604837424b25ab3\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:49:21'),
(102, 46, 59, 120, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5371, \"subjectKey\": \"custom_c3d3e71f8604837424b25ab3\", \"sessionIndex\": 0}', '2026-10-04 09:50:57'),
(103, 46, 59, 120, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5373, \"subjectKey\": \"custom_f1c50c8cd31e23aed775519f\", \"sessionIndex\": 0}', '2026-10-04 09:50:58'),
(104, 46, 59, 120, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5375, \"subjectKey\": \"custom_b6ed7968bff3b6e03df5735e\", \"sessionIndex\": 0}', '2026-10-04 09:50:59'),
(105, 46, 59, 120, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5377, \"subjectKey\": \"custom_3441b96581e040c11730c1e8\", \"sessionIndex\": 0}', '2026-10-04 09:50:59'),
(106, 46, 59, 120, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5379, \"subjectKey\": \"custom_7db8ffee6fe3163bc68b7831\", \"sessionIndex\": 0}', '2026-10-04 09:51:00'),
(107, 46, 59, 120, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5372, \"subjectKey\": \"custom_f1c50c8cd31e23aed775519f\", \"sessionIndex\": 1}', '2026-10-04 09:51:01'),
(108, 46, 59, 120, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5374, \"subjectKey\": \"custom_c3d3e71f8604837424b25ab3\", \"sessionIndex\": 1}', '2026-10-04 09:51:02'),
(109, 46, 59, 120, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5376, \"subjectKey\": \"custom_3441b96581e040c11730c1e8\", \"sessionIndex\": 1}', '2026-10-04 09:51:03'),
(110, 46, 59, 120, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5378, \"subjectKey\": \"custom_7db8ffee6fe3163bc68b7831\", \"sessionIndex\": 1}', '2026-10-04 09:51:03'),
(111, 46, 59, 120, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5380, \"subjectKey\": \"custom_b6ed7968bff3b6e03df5735e\", \"sessionIndex\": 1}', '2026-10-04 09:51:04'),
(112, 46, 59, 121, 'ga_generated', '{\"subjects\": [\"custom_3441b96581e040c11730c1e8\", \"custom_f1c50c8cd31e23aed775519f\", \"custom_7db8ffee6fe3163bc68b7831\", \"custom_b6ed7968bff3b6e03df5735e\", \"custom_c3d3e71f8604837424b25ab3\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-04 09:51:09'),
(113, 46, 59, 121, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5383, \"subjectKey\": \"custom_7db8ffee6fe3163bc68b7831\", \"sessionIndex\": 2}', '2026-10-04 09:51:12'),
(114, 46, 59, 121, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5393, \"subjectKey\": \"custom_b6ed7968bff3b6e03df5735e\", \"sessionIndex\": 2}', '2026-10-04 09:51:12'),
(115, 46, 59, 121, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5413, \"subjectKey\": \"custom_3441b96581e040c11730c1e8\", \"sessionIndex\": 2}', '2026-10-04 09:51:13'),
(116, 46, 59, 121, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5403, \"subjectKey\": \"custom_f1c50c8cd31e23aed775519f\", \"sessionIndex\": 2}', '2026-10-04 09:51:14'),
(117, 46, 59, 121, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5423, \"subjectKey\": \"custom_f1c50c8cd31e23aed775519f\", \"sessionIndex\": 2}', '2026-10-04 09:51:15'),
(118, 46, 59, 122, 'ga_generated', '{\"subjects\": [\"custom_3441b96581e040c11730c1e8\", \"custom_f1c50c8cd31e23aed775519f\", \"custom_7db8ffee6fe3163bc68b7831\", \"custom_b6ed7968bff3b6e03df5735e\", \"custom_c3d3e71f8604837424b25ab3\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 09:53:37'),
(119, 46, 59, NULL, 'manual_block_added', '{\"blockId\": 15, \"dayIndex\": 5, \"blockType\": \"review\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_f1c50c8cd31e23aed775519f\", \"durationMinutes\": 60}', '2026-10-04 09:54:31'),
(120, 46, 59, NULL, 'manual_block_completed', '{\"blockId\": 15, \"dayIndex\": 5, \"startTime\": \"08:00\", \"subjectKey\": \"custom_f1c50c8cd31e23aed775519f\", \"durationMinutes\": 60}', '2026-10-04 09:55:06'),
(121, 47, 62, 123, 'ga_generated', '{\"subjects\": [\"custom_09f7ac850f3e7ff42e0ad836\", \"custom_e8a18ed851e28d1a814b9b34\"], \"startTime\": \"08:00\", \"daysPerWeek\": 2, \"sessionCount\": 20}', '2026-10-04 10:52:40'),
(122, 47, 62, 124, 'ga_generated', '{\"subjects\": [\"custom_09f7ac850f3e7ff42e0ad836\", \"custom_e8a18ed851e28d1a814b9b34\"], \"startTime\": \"08:00\", \"daysPerWeek\": 2, \"sessionCount\": 20}', '2026-10-04 10:53:40'),
(123, 47, 62, NULL, 'manual_block_added', '{\"blockId\": 16, \"dayIndex\": 5, \"blockType\": \"review\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_09f7ac850f3e7ff42e0ad836\", \"durationMinutes\": 120}', '2026-10-04 10:54:36'),
(124, 47, 62, NULL, 'manual_block_completed', '{\"blockId\": 16, \"dayIndex\": 5, \"startTime\": \"08:00\", \"subjectKey\": \"custom_09f7ac850f3e7ff42e0ad836\", \"durationMinutes\": 120}', '2026-10-04 10:54:49'),
(125, 47, 62, 125, 'ga_generated', '{\"subjects\": [\"custom_09f7ac850f3e7ff42e0ad836\", \"custom_e8a18ed851e28d1a814b9b34\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 10:55:00'),
(126, 48, 64, 126, 'ga_generated', '{\"subjects\": [\"custom_8a390a70d28052493f6b2cfb\", \"custom_fb4e8e4463c41cebdda2c656\", \"custom_32440e4bb1f4c93a8c1d443d\", \"custom_4d0609d50e4d46b690303cc8\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-04 11:37:51'),
(127, 48, 64, NULL, 'manual_block_added', '{\"blockId\": 17, \"dayIndex\": 5, \"blockType\": \"review\", \"startTime\": \"08:00\", \"subjectKey\": \"custom_fb4e8e4463c41cebdda2c656\", \"durationMinutes\": 120}', '2026-10-04 11:41:18'),
(128, 48, 63, 127, 'ga_generated', '{\"subjects\": [\"custom_2b975a0e1ba12338536d26b2\", \"custom_b667e2aec4a8bdd7fe7d1585\", \"custom_2345b019b7c1fd9b4d2cfaec\", \"custom_a1bbdc3491a53f65c89275a9\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-04 11:44:12'),
(129, 48, 63, 128, 'ga_generated', '{\"subjects\": [\"custom_2b975a0e1ba12338536d26b2\", \"custom_b667e2aec4a8bdd7fe7d1585\", \"custom_2345b019b7c1fd9b4d2cfaec\", \"custom_a1bbdc3491a53f65c89275a9\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 11:52:36'),
(130, 48, 63, 129, 'ga_generated', '{\"subjects\": [\"custom_2b975a0e1ba12338536d26b2\", \"custom_b667e2aec4a8bdd7fe7d1585\", \"custom_2345b019b7c1fd9b4d2cfaec\", \"custom_a1bbdc3491a53f65c89275a9\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-04 11:55:44'),
(132, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_358f549bb0644ec7b250dfdd\", \"custom_4363f56742460ee66f9f8460\", \"custom_df4d6c879d2f6bc8f1c9df49\", \"custom_cfad716a8d241e3e807fcc2c\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-06 09:29:21'),
(133, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5661, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 0}', '2026-10-06 09:29:54'),
(134, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5671, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 0}', '2026-10-06 09:30:02'),
(135, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5681, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 0}', '2026-10-06 09:30:04'),
(136, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5691, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 0}', '2026-10-06 09:30:04'),
(137, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5701, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 0}', '2026-10-06 09:30:06'),
(138, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5662, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 1}', '2026-10-06 09:30:07'),
(139, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5672, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 1}', '2026-10-06 09:30:07'),
(140, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5682, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 1}', '2026-10-06 09:30:08'),
(141, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5692, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 1}', '2026-10-06 09:30:08'),
(142, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5702, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 1}', '2026-10-06 09:30:09'),
(143, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5663, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 2}', '2026-10-06 09:30:11'),
(144, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5673, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 2}', '2026-10-06 09:30:12'),
(145, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5683, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 2}', '2026-10-06 09:30:12'),
(146, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5693, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 2}', '2026-10-06 09:30:13'),
(147, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5703, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 2}', '2026-10-06 09:30:14'),
(148, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5704, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 3}', '2026-10-06 09:30:15'),
(149, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5694, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 3}', '2026-10-06 09:30:15'),
(150, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5684, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 3}', '2026-10-06 09:30:16'),
(151, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5674, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 3}', '2026-10-06 09:30:17'),
(152, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5664, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 3}', '2026-10-06 09:30:17'),
(153, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5665, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 4}', '2026-10-06 09:30:20'),
(154, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5675, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 4}', '2026-10-06 09:30:21'),
(155, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5685, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 4}', '2026-10-06 09:30:21'),
(156, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5695, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 4}', '2026-10-06 09:30:21'),
(157, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5705, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 4}', '2026-10-06 09:30:22'),
(158, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5696, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 5}', '2026-10-06 09:30:24'),
(159, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5706, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 5}', '2026-10-06 09:30:25'),
(160, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5686, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 5}', '2026-10-06 09:30:26'),
(161, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5676, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 5}', '2026-10-06 09:30:26'),
(162, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5666, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 5}', '2026-10-06 09:30:27'),
(163, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5667, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 6}', '2026-10-06 09:30:29'),
(164, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5677, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 6}', '2026-10-06 09:30:29'),
(165, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5687, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 6}', '2026-10-06 09:30:30'),
(166, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5697, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 6}', '2026-10-06 09:30:30'),
(167, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5707, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 6}', '2026-10-06 09:30:30'),
(168, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5698, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 7}', '2026-10-06 09:30:32'),
(169, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5708, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 7}', '2026-10-06 09:30:33'),
(170, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5688, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 7}', '2026-10-06 09:30:33'),
(171, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5678, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 7}', '2026-10-06 09:30:34'),
(172, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5668, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 7}', '2026-10-06 09:30:34'),
(173, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5669, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 8}', '2026-10-06 09:30:35'),
(174, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5670, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 9}', '2026-10-06 09:30:37'),
(175, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5679, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 8}', '2026-10-06 09:30:38'),
(176, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 5680, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 9}', '2026-10-06 09:30:38'),
(177, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5689, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 8}', '2026-10-06 09:30:39'),
(178, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 5690, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 9}', '2026-10-06 09:30:39'),
(179, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5699, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 8}', '2026-10-06 09:30:40'),
(180, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5700, \"subjectKey\": \"custom_df4d6c879d2f6bc8f1c9df49\", \"sessionIndex\": 9}', '2026-10-06 09:30:41'),
(181, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5709, \"subjectKey\": \"custom_358f549bb0644ec7b250dfdd\", \"sessionIndex\": 8}', '2026-10-06 09:30:41'),
(182, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 5710, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 9}', '2026-10-06 09:30:42'),
(183, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 5661, \"subjectKey\": \"custom_cfad716a8d241e3e807fcc2c\", \"sessionIndex\": 0}', '2026-10-06 09:31:02'),
(184, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 5691, \"subjectKey\": \"custom_4363f56742460ee66f9f8460\", \"sessionIndex\": 0}', '2026-10-06 09:31:11'),
(185, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_358f549bb0644ec7b250dfdd\", \"custom_4363f56742460ee66f9f8460\", \"custom_df4d6c879d2f6bc8f1c9df49\", \"custom_cfad716a8d241e3e807fcc2c\"], \"startTime\": \"08:00\", \"daysPerWeek\": 1, \"sessionCount\": 10}', '2026-10-06 09:41:44'),
(186, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_358f549bb0644ec7b250dfdd\", \"custom_4363f56742460ee66f9f8460\", \"custom_df4d6c879d2f6bc8f1c9df49\", \"custom_cfad716a8d241e3e807fcc2c\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-06 09:42:09'),
(187, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_358f549bb0644ec7b250dfdd\", \"custom_4363f56742460ee66f9f8460\", \"custom_df4d6c879d2f6bc8f1c9df49\"], \"startTime\": \"20:00\", \"daysPerWeek\": 5, \"sessionCount\": 10}', '2026-10-06 09:45:07'),
(195, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_33dd1d7a489535e9d2a67178\", \"custom_acab48a3604d1e7102b44f75\", \"custom_2a1d0a26e3daaeba54c9ac26\", \"custom_fa5e8552ef58e703dfc97148\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-06 12:15:20'),
(196, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_39aefc5d01df098134d66147\", \"custom_bee9f6e224177886f2d1a98f\", \"custom_bb60e0b8d1525c86f00891dc\", \"custom_6b40d04f5242272a0f982da4\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 50}', '2026-10-08 09:33:36'),
(197, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_39aefc5d01df098134d66147\", \"custom_bee9f6e224177886f2d1a98f\", \"custom_bb60e0b8d1525c86f00891dc\", \"custom_6b40d04f5242272a0f982da4\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 25}', '2026-10-08 10:00:28'),
(198, 2, 66, NULL, 'ga_generated', '{\"subjects\": [\"custom_39aefc5d01df098134d66147\", \"custom_bee9f6e224177886f2d1a98f\", \"custom_bb60e0b8d1525c86f00891dc\", \"custom_6b40d04f5242272a0f982da4\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 30}', '2026-10-08 10:00:56'),
(199, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 6216, \"subjectKey\": \"custom_39aefc5d01df098134d66147\", \"sessionIndex\": 0}', '2026-10-08 10:07:22'),
(200, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 6222, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 0}', '2026-10-08 10:07:23'),
(201, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 6234, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 0}', '2026-10-08 10:07:24'),
(202, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 6228, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 0}', '2026-10-08 10:07:24'),
(203, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 6240, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 0}', '2026-10-08 10:07:25'),
(204, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 6241, \"subjectKey\": \"custom_39aefc5d01df098134d66147\", \"sessionIndex\": 1}', '2026-10-08 10:07:26'),
(205, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 6235, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 1}', '2026-10-08 10:07:26'),
(206, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 6229, \"subjectKey\": \"custom_6b40d04f5242272a0f982da4\", \"sessionIndex\": 1}', '2026-10-08 10:07:26'),
(207, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 6223, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 1}', '2026-10-08 10:07:27'),
(208, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 6217, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 1}', '2026-10-08 10:07:27'),
(209, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 6218, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 2}', '2026-10-08 10:07:28'),
(210, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 6224, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 2}', '2026-10-08 10:07:29'),
(211, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 6230, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 2}', '2026-10-08 10:07:30'),
(212, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 6242, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 2}', '2026-10-08 10:07:30'),
(213, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 6236, \"subjectKey\": \"custom_6b40d04f5242272a0f982da4\", \"sessionIndex\": 2}', '2026-10-08 10:07:31'),
(214, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 6243, \"subjectKey\": \"custom_39aefc5d01df098134d66147\", \"sessionIndex\": 3}', '2026-10-08 10:07:34'),
(215, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 6237, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 3}', '2026-10-08 10:07:35'),
(216, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 6231, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 3}', '2026-10-08 10:07:35'),
(217, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 6225, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 3}', '2026-10-08 10:07:35'),
(218, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 6219, \"subjectKey\": \"custom_39aefc5d01df098134d66147\", \"sessionIndex\": 3}', '2026-10-08 10:07:36'),
(219, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 6244, \"subjectKey\": \"custom_6b40d04f5242272a0f982da4\", \"sessionIndex\": 4}', '2026-10-08 10:07:37'),
(220, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 6238, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 4}', '2026-10-08 10:07:37'),
(221, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 6232, \"subjectKey\": \"custom_6b40d04f5242272a0f982da4\", \"sessionIndex\": 4}', '2026-10-08 10:07:38'),
(222, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 6226, \"subjectKey\": \"custom_39aefc5d01df098134d66147\", \"sessionIndex\": 4}', '2026-10-08 10:07:38'),
(223, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 6220, \"subjectKey\": \"custom_6b40d04f5242272a0f982da4\", \"sessionIndex\": 4}', '2026-10-08 10:07:38'),
(224, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 4, \"sessionId\": 6245, \"subjectKey\": \"custom_bb60e0b8d1525c86f00891dc\", \"sessionIndex\": 5}', '2026-10-08 10:07:42'),
(225, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 3, \"sessionId\": 6239, \"subjectKey\": \"custom_39aefc5d01df098134d66147\", \"sessionIndex\": 5}', '2026-10-08 10:07:42'),
(226, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 2, \"sessionId\": 6233, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 5}', '2026-10-08 10:07:43'),
(227, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 1, \"sessionId\": 6227, \"subjectKey\": \"custom_6b40d04f5242272a0f982da4\", \"sessionIndex\": 5}', '2026-10-08 10:07:43'),
(228, 2, 66, NULL, 'session_completed', '{\"dayIndex\": 0, \"sessionId\": 6221, \"subjectKey\": \"custom_bee9f6e224177886f2d1a98f\", \"sessionIndex\": 5}', '2026-10-08 10:07:44'),
(229, 3, 70, 146, 'ga_generated', '{\"subjects\": [\"custom_278024dd7fd761ad14b7310c\", \"custom_6dbb60d8c471e9fd0a56fffa\", \"custom_1ae2c96b59901dee8ab28f49\", \"custom_e7ca41b9cdfeac485d355318\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 25}', '2026-10-08 10:57:38'),
(230, 3, 70, 147, 'ga_generated', '{\"subjects\": [\"custom_278024dd7fd761ad14b7310c\", \"custom_6dbb60d8c471e9fd0a56fffa\", \"custom_1ae2c96b59901dee8ab28f49\", \"custom_e7ca41b9cdfeac485d355318\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 25}', '2026-10-09 06:46:12'),
(231, 3, 70, 148, 'ga_generated', '{\"subjects\": [\"custom_278024dd7fd761ad14b7310c\", \"custom_6dbb60d8c471e9fd0a56fffa\", \"custom_1ae2c96b59901dee8ab28f49\", \"custom_e7ca41b9cdfeac485d355318\"], \"startTime\": \"08:00\", \"daysPerWeek\": 5, \"sessionCount\": 25}', '2026-10-09 06:46:25');

-- --------------------------------------------------------

--
-- Table structure for table `study_sessions`
--

CREATE TABLE `study_sessions` (
  `id` bigint UNSIGNED NOT NULL,
  `schedule_id` bigint UNSIGNED NOT NULL,
  `day_index` tinyint UNSIGNED NOT NULL,
  `session_index` tinyint UNSIGNED NOT NULL,
  `subject_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `future_note` text COLLATE utf8mb4_unicode_ci,
  `lecture_notes` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_sessions`
--

INSERT INTO `study_sessions` (`id`, `schedule_id`, `day_index`, `session_index`, `subject_key`, `is_completed`, `future_note`, `lecture_notes`) VALUES
(5276, 114, 0, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5277, 114, 0, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5278, 114, 1, 0, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5279, 114, 1, 1, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5280, 114, 2, 0, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5281, 114, 2, 1, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5282, 114, 3, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5283, 114, 3, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5284, 114, 4, 0, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5285, 114, 4, 1, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5286, 115, 0, 0, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5287, 115, 0, 1, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5288, 115, 1, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5289, 115, 1, 1, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5290, 115, 2, 0, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5291, 115, 2, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5292, 115, 3, 0, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5293, 115, 3, 1, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5294, 115, 4, 0, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5295, 115, 4, 1, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5296, 116, 0, 0, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5297, 116, 0, 1, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5298, 116, 1, 0, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5299, 116, 1, 1, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5300, 116, 2, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5301, 116, 2, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5302, 116, 3, 0, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5303, 116, 3, 1, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5304, 116, 4, 0, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5305, 116, 4, 1, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5306, 117, 0, 0, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5307, 117, 0, 1, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5308, 117, 1, 0, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5309, 117, 1, 1, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5310, 117, 2, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5311, 117, 2, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5312, 117, 3, 0, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5313, 117, 3, 1, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5314, 117, 4, 0, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5315, 117, 4, 1, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5316, 118, 0, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5317, 118, 0, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5318, 118, 0, 2, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5319, 118, 0, 3, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5320, 118, 0, 4, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5321, 118, 0, 5, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5322, 118, 0, 6, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5323, 118, 0, 7, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5324, 118, 0, 8, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5325, 118, 1, 0, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5326, 118, 1, 1, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5327, 118, 1, 2, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5328, 118, 1, 3, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5329, 118, 1, 4, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5330, 118, 1, 5, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5331, 118, 1, 6, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5332, 118, 1, 7, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5333, 118, 1, 8, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5334, 118, 2, 0, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5335, 118, 2, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5336, 118, 2, 2, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5337, 118, 2, 3, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5338, 118, 2, 4, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5339, 118, 2, 5, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5340, 118, 2, 6, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5341, 118, 2, 7, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5342, 118, 2, 8, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5343, 118, 3, 0, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5344, 118, 3, 1, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5345, 118, 3, 2, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5346, 118, 3, 3, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5347, 118, 3, 4, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5348, 118, 3, 5, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5349, 118, 3, 6, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5350, 118, 3, 7, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5351, 118, 3, 8, 'custom_cbd0116aaae19fee4b97147e', 0, '', ''),
(5352, 118, 4, 0, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5353, 118, 4, 1, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5354, 118, 4, 2, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5355, 118, 4, 3, 'custom_359454e8b5bb568c7f92c25b', 0, '', ''),
(5356, 118, 4, 4, 'custom_c466ffc5454d46b810a0f550', 0, '', ''),
(5357, 118, 4, 5, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5358, 118, 4, 6, 'custom_95c1c7aef8fa1e6bb04aa87d', 0, '', ''),
(5359, 118, 4, 7, 'custom_06a7bf6cdf97844c8e2324ca', 0, '', ''),
(5360, 118, 4, 8, 'custom_9eb1d8698ea8ac9a298e237e', 0, '', ''),
(5371, 120, 0, 0, 'custom_c3d3e71f8604837424b25ab3', 1, '', ''),
(5372, 120, 0, 1, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5373, 120, 1, 0, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5374, 120, 1, 1, 'custom_c3d3e71f8604837424b25ab3', 1, '', ''),
(5375, 120, 2, 0, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5376, 120, 2, 1, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5377, 120, 3, 0, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5378, 120, 3, 1, 'custom_7db8ffee6fe3163bc68b7831', 1, '', ''),
(5379, 120, 4, 0, 'custom_7db8ffee6fe3163bc68b7831', 1, '', ''),
(5380, 120, 4, 1, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5381, 121, 0, 0, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5382, 121, 0, 1, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5383, 121, 0, 2, 'custom_7db8ffee6fe3163bc68b7831', 1, '', ''),
(5384, 121, 0, 3, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5385, 121, 0, 4, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5386, 121, 0, 5, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5387, 121, 0, 6, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5388, 121, 0, 7, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5389, 121, 0, 8, 'custom_f1c50c8cd31e23aed775519f', 0, '', ''),
(5390, 121, 0, 9, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5391, 121, 1, 0, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5392, 121, 1, 1, 'custom_c3d3e71f8604837424b25ab3', 1, '', ''),
(5393, 121, 1, 2, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5394, 121, 1, 3, 'custom_f1c50c8cd31e23aed775519f', 0, '', ''),
(5395, 121, 1, 4, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5396, 121, 1, 5, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5397, 121, 1, 6, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5398, 121, 1, 7, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5399, 121, 1, 8, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5400, 121, 1, 9, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5401, 121, 2, 0, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5402, 121, 2, 1, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5403, 121, 2, 2, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5404, 121, 2, 3, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5405, 121, 2, 4, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5406, 121, 2, 5, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5407, 121, 2, 6, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5408, 121, 2, 7, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5409, 121, 2, 8, 'custom_f1c50c8cd31e23aed775519f', 0, '', ''),
(5410, 121, 2, 9, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5411, 121, 3, 0, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5412, 121, 3, 1, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5413, 121, 3, 2, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5414, 121, 3, 3, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5415, 121, 3, 4, 'custom_f1c50c8cd31e23aed775519f', 0, '', ''),
(5416, 121, 3, 5, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5417, 121, 3, 6, 'custom_f1c50c8cd31e23aed775519f', 0, '', ''),
(5418, 121, 3, 7, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5419, 121, 3, 8, 'custom_b6ed7968bff3b6e03df5735e', 0, '', ''),
(5420, 121, 3, 9, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5421, 121, 4, 0, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5422, 121, 4, 1, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5423, 121, 4, 2, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5424, 121, 4, 3, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5425, 121, 4, 4, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5426, 121, 4, 5, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5427, 121, 4, 6, 'custom_3441b96581e040c11730c1e8', 0, '', ''),
(5428, 121, 4, 7, 'custom_f1c50c8cd31e23aed775519f', 0, '', ''),
(5429, 121, 4, 8, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5430, 121, 4, 9, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5431, 122, 0, 0, 'custom_c3d3e71f8604837424b25ab3', 0, '', ''),
(5432, 122, 0, 1, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5433, 122, 1, 0, 'custom_f1c50c8cd31e23aed775519f', 1, '', ''),
(5434, 122, 1, 1, 'custom_c3d3e71f8604837424b25ab3', 1, '', ''),
(5435, 122, 2, 0, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5436, 122, 2, 1, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5437, 122, 3, 0, 'custom_3441b96581e040c11730c1e8', 1, '', ''),
(5438, 122, 3, 1, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5439, 122, 4, 0, 'custom_7db8ffee6fe3163bc68b7831', 0, '', ''),
(5440, 122, 4, 1, 'custom_b6ed7968bff3b6e03df5735e', 1, '', ''),
(5441, 123, 0, 0, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5442, 123, 0, 1, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5443, 123, 0, 2, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5444, 123, 0, 3, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5445, 123, 0, 4, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5446, 123, 0, 5, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5447, 123, 0, 6, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5448, 123, 0, 7, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5449, 123, 0, 8, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5450, 123, 0, 9, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5451, 123, 1, 0, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5452, 123, 1, 1, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5453, 123, 1, 2, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5454, 123, 1, 3, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5455, 123, 1, 4, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5456, 123, 1, 5, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5457, 123, 1, 6, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5458, 123, 1, 7, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5459, 123, 1, 8, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5460, 123, 1, 9, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5461, 124, 0, 0, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5462, 124, 0, 1, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5463, 124, 0, 2, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5464, 124, 0, 3, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5465, 124, 0, 4, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5466, 124, 0, 5, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5467, 124, 0, 6, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5468, 124, 0, 7, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5469, 124, 0, 8, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5470, 124, 0, 9, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5471, 124, 1, 0, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5472, 124, 1, 1, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5473, 124, 1, 2, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5474, 124, 1, 3, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5475, 124, 1, 4, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5476, 124, 1, 5, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5477, 124, 1, 6, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5478, 124, 1, 7, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5479, 124, 1, 8, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5480, 124, 1, 9, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5481, 125, 0, 0, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5482, 125, 0, 1, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5483, 125, 1, 0, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5484, 125, 1, 1, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5485, 125, 2, 0, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5486, 125, 2, 1, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5487, 125, 3, 0, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5488, 125, 3, 1, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5489, 125, 4, 0, 'custom_09f7ac850f3e7ff42e0ad836', 0, '', ''),
(5490, 125, 4, 1, 'custom_e8a18ed851e28d1a814b9b34', 0, '', ''),
(5491, 126, 0, 0, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5492, 126, 0, 1, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5493, 126, 0, 2, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5494, 126, 0, 3, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5495, 126, 0, 4, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5496, 126, 0, 5, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5497, 126, 0, 6, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5498, 126, 0, 7, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5499, 126, 0, 8, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5500, 126, 0, 9, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5501, 126, 1, 0, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5502, 126, 1, 1, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5503, 126, 1, 2, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5504, 126, 1, 3, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5505, 126, 1, 4, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5506, 126, 1, 5, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5507, 126, 1, 6, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5508, 126, 1, 7, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5509, 126, 1, 8, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5510, 126, 1, 9, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5511, 126, 2, 0, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5512, 126, 2, 1, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5513, 126, 2, 2, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5514, 126, 2, 3, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5515, 126, 2, 4, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5516, 126, 2, 5, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5517, 126, 2, 6, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5518, 126, 2, 7, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5519, 126, 2, 8, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5520, 126, 2, 9, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5521, 126, 3, 0, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5522, 126, 3, 1, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5523, 126, 3, 2, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5524, 126, 3, 3, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5525, 126, 3, 4, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5526, 126, 3, 5, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5527, 126, 3, 6, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5528, 126, 3, 7, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5529, 126, 3, 8, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5530, 126, 3, 9, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5531, 126, 4, 0, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5532, 126, 4, 1, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5533, 126, 4, 2, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5534, 126, 4, 3, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5535, 126, 4, 4, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5536, 126, 4, 5, 'custom_4d0609d50e4d46b690303cc8', 0, '', ''),
(5537, 126, 4, 6, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5538, 126, 4, 7, 'custom_32440e4bb1f4c93a8c1d443d', 0, '', ''),
(5539, 126, 4, 8, 'custom_fb4e8e4463c41cebdda2c656', 0, '', ''),
(5540, 126, 4, 9, 'custom_8a390a70d28052493f6b2cfb', 0, '', ''),
(5541, 127, 0, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5542, 127, 0, 1, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5543, 127, 0, 2, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5544, 127, 0, 3, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5545, 127, 0, 4, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5546, 127, 0, 5, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5547, 127, 0, 6, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5548, 127, 0, 7, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5549, 127, 0, 8, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5550, 127, 0, 9, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5551, 127, 1, 0, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5552, 127, 1, 1, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5553, 127, 1, 2, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5554, 127, 1, 3, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5555, 127, 1, 4, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5556, 127, 1, 5, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5557, 127, 1, 6, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5558, 127, 1, 7, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5559, 127, 1, 8, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5560, 127, 1, 9, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5561, 127, 2, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5562, 127, 2, 1, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5563, 127, 2, 2, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5564, 127, 2, 3, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5565, 127, 2, 4, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5566, 127, 2, 5, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5567, 127, 2, 6, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5568, 127, 2, 7, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5569, 127, 2, 8, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5570, 127, 2, 9, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5571, 127, 3, 0, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5572, 127, 3, 1, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5573, 127, 3, 2, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5574, 127, 3, 3, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5575, 127, 3, 4, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5576, 127, 3, 5, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5577, 127, 3, 6, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5578, 127, 3, 7, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5579, 127, 3, 8, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5580, 127, 3, 9, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5581, 127, 4, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5582, 127, 4, 1, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5583, 127, 4, 2, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5584, 127, 4, 3, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5585, 127, 4, 4, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5586, 127, 4, 5, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5587, 127, 4, 6, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5588, 127, 4, 7, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5589, 127, 4, 8, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5590, 127, 4, 9, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5591, 128, 0, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5592, 128, 0, 1, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5593, 128, 1, 0, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5594, 128, 1, 1, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5595, 128, 2, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5596, 128, 2, 1, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5597, 128, 3, 0, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5598, 128, 3, 1, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5599, 128, 4, 0, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5600, 128, 4, 1, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5601, 129, 0, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5602, 129, 0, 1, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5603, 129, 1, 0, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5604, 129, 1, 1, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5605, 129, 2, 0, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(5606, 129, 2, 1, 'custom_2b975a0e1ba12338536d26b2', 0, '', ''),
(5607, 129, 3, 0, 'custom_a1bbdc3491a53f65c89275a9', 0, '', ''),
(5608, 129, 3, 1, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5609, 129, 4, 0, 'custom_2345b019b7c1fd9b4d2cfaec', 0, '', ''),
(5610, 129, 4, 1, 'custom_b667e2aec4a8bdd7fe7d1585', 0, '', ''),
(6246, 146, 0, 0, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6247, 146, 0, 1, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6248, 146, 0, 2, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6249, 146, 0, 3, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6250, 146, 0, 4, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6251, 146, 1, 0, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6252, 146, 1, 1, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6253, 146, 1, 2, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6254, 146, 1, 3, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6255, 146, 1, 4, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6256, 146, 2, 0, 'custom_e7ca41b9cdfeac485d355318', 0, '', ''),
(6257, 146, 2, 1, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6258, 146, 2, 2, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6259, 146, 2, 3, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6260, 146, 2, 4, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6261, 146, 3, 0, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6262, 146, 3, 1, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6263, 146, 3, 2, 'custom_e7ca41b9cdfeac485d355318', 0, '', ''),
(6264, 146, 3, 3, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6265, 146, 3, 4, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6266, 146, 4, 0, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6267, 146, 4, 1, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6268, 146, 4, 2, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6269, 146, 4, 3, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6270, 146, 4, 4, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6271, 147, 0, 0, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6272, 147, 0, 1, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6273, 147, 0, 2, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6274, 147, 0, 3, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6275, 147, 0, 4, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6276, 147, 1, 0, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6277, 147, 1, 1, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6278, 147, 1, 2, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6279, 147, 1, 3, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6280, 147, 1, 4, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6281, 147, 2, 0, 'custom_e7ca41b9cdfeac485d355318', 0, '', ''),
(6282, 147, 2, 1, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6283, 147, 2, 2, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6284, 147, 2, 3, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6285, 147, 2, 4, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6286, 147, 3, 0, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6287, 147, 3, 1, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6288, 147, 3, 2, 'custom_e7ca41b9cdfeac485d355318', 0, '', ''),
(6289, 147, 3, 3, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6290, 147, 3, 4, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6291, 147, 4, 0, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6292, 147, 4, 1, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6293, 147, 4, 2, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6294, 147, 4, 3, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6295, 147, 4, 4, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6296, 148, 0, 0, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6297, 148, 0, 1, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6298, 148, 0, 2, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6299, 148, 0, 3, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6300, 148, 0, 4, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6301, 148, 1, 0, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6302, 148, 1, 1, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6303, 148, 1, 2, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6304, 148, 1, 3, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6305, 148, 1, 4, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6306, 148, 2, 0, 'custom_e7ca41b9cdfeac485d355318', 0, '', ''),
(6307, 148, 2, 1, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6308, 148, 2, 2, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6309, 148, 2, 3, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6310, 148, 2, 4, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6311, 148, 3, 0, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6312, 148, 3, 1, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6313, 148, 3, 2, 'custom_e7ca41b9cdfeac485d355318', 0, '', ''),
(6314, 148, 3, 3, 'custom_1ae2c96b59901dee8ab28f49', 0, '', ''),
(6315, 148, 3, 4, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6316, 148, 4, 0, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6317, 148, 4, 1, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6318, 148, 4, 2, 'custom_278024dd7fd761ad14b7310c', 0, '', ''),
(6319, 148, 4, 3, 'custom_6dbb60d8c471e9fd0a56fffa', 0, '', ''),
(6320, 148, 4, 4, 'custom_1ae2c96b59901dee8ab28f49', 0, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `kind` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'subject',
  `label` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#64756d',
  `weight` tinyint UNSIGNED NOT NULL DEFAULT '20',
  `future_note` text COLLATE utf8mb4_unicode_ci,
  `lecture_notes` text COLLATE utf8mb4_unicode_ci,
  `activity_details` text COLLATE utf8mb4_unicode_ci,
  `activity_duration_hours` decimal(5,2) DEFAULT NULL,
  `activity_start_date` date DEFAULT NULL,
  `activity_end_date` date DEFAULT NULL,
  `activity_start_time` time DEFAULT NULL,
  `activity_end_time` time DEFAULT NULL,
  `activity_course_key` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_key`, `user_id`, `category_id`, `kind`, `label`, `color`, `weight`, `future_note`, `lecture_notes`, `activity_details`, `activity_duration_hours`, `activity_start_date`, `activity_end_date`, `activity_start_time`, `activity_end_time`, `activity_course_key`, `sort_order`) VALUES
('biology', NULL, NULL, 'subject', 'ชีวะ', '#a25d74', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
('custom_06a7bf6cdf97844c8e2324ca', 45, 52, 'subject', 'คอม', '#548b68', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_09f7ac850f3e7ff42e0ad836', 47, 62, 'subject', 'เคมี', '#d07842', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_1ae2c96b59901dee8ab28f49', 3, 70, 'subject', 'เคมี', '#3979a8', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_2345b019b7c1fd9b4d2cfaec', 48, 63, 'subject', 'เคมี', '#a25d74', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_278024dd7fd761ad14b7310c', 3, 70, 'subject', 'ชีวะ', '#8064a2', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_2b975a0e1ba12338536d26b2', 48, 63, 'subject', 'ชีวะ', '#64756d', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_2f98658a6554216071b64dd6', 46, 59, 'activity', 'ทำการบ้าน', '#bd7950', 30, NULL, NULL, 'ขขขข', 4.00, '2026-10-04', '2026-10-04', '08:00:00', '16:00:00', 'custom_3441b96581e040c11730c1e8', 100),
('custom_32440e4bb1f4c93a8c1d443d', 48, 64, 'subject', 'เคมี', '#28735b', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_3441b96581e040c11730c1e8', 46, 59, 'subject', 'คณิต', '#64756d', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_359454e8b5bb568c7f92c25b', 45, 52, 'subject', 'เคมี', '#8064a2', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_3ff33f7bf8675abf6cca73cd', 41, 49, 'activity', 'ภาษาไทย', '#bd7950', 30, NULL, NULL, NULL, 3.00, '2026-10-01', '2026-10-03', '08:00:00', '16:00:00', NULL, 100),
('custom_4d0609d50e4d46b690303cc8', 48, 64, 'subject', 'ไทย', '#c28a2c', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_6dbb60d8c471e9fd0a56fffa', 3, 70, 'subject', 'ฟิสิกส์', '#28735b', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_7db8ffee6fe3163bc68b7831', 46, 59, 'subject', 'ฟิสิก', '#a25d74', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_8a390a70d28052493f6b2cfb', 48, 64, 'subject', 'ฟิสิก', '#3979a8', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_95c1c7aef8fa1e6bb04aa87d', 45, 52, 'subject', 'ชีวะ', '#28735b', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_9eb1d8698ea8ac9a298e237e', 45, 52, 'subject', 'ฟิสิก', '#d07842', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_a1bbdc3491a53f65c89275a9', 48, 63, 'subject', 'ไทย', '#c28a2c', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_b23d825fbc392ae8e58e2745', 48, 64, 'activity', 'ทำการบ้าน', '#bd7950', 30, NULL, NULL, NULL, 2.00, '2026-10-04', '2026-10-10', '08:00:00', '19:00:00', NULL, 100),
('custom_b667e2aec4a8bdd7fe7d1585', 48, 63, 'subject', 'ฟิสิกส์', '#3979a8', 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_b6ed7968bff3b6e03df5735e', 46, 59, 'subject', 'เคมี', '#8064a2', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_b9645e05da5446d54a9c0527', 41, 49, 'activity', 'อ่านหนังสือ', '#bd7950', 30, NULL, NULL, '----', 3.00, '2026-10-03', '2026-10-03', '08:46:00', '16:46:00', NULL, 100),
('custom_c3d3e71f8604837424b25ab3', 46, 59, 'subject', 'ไทย', '#28735b', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_c466ffc5454d46b810a0f550', 45, 52, 'subject', 'สังคม', '#c28a2c', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_cbd0116aaae19fee4b97147e', 45, 52, 'subject', 'ไทย', '#3979a8', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_e70ab14bc5f9f893e794bfde', 41, 49, 'subject', 'สังคม', '#5479a8', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_e7ca41b9cdfeac485d355318', 3, 70, 'subject', 'ไทย', '#318b88', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_e8a18ed851e28d1a814b9b34', 47, 62, 'subject', 'ไทย', '#28735b', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_f1c50c8cd31e23aed775519f', 46, 59, 'subject', 'ชีวะ', '#c28a2c', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('custom_f8ed80af74ccd21e8567641f', 41, 49, 'activity', 'สังคม', '#bd7950', 30, NULL, NULL, NULL, 2.00, '2026-10-01', '2026-10-04', '08:00:00', '16:00:00', NULL, 100),
('custom_fb4e8e4463c41cebdda2c656', 48, 64, 'subject', 'อังกฤษ', '#8064a2', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100),
('english', NULL, NULL, 'subject', 'อังกฤษ', '#3979a8', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
('math', NULL, NULL, 'subject', 'คณิต', '#548b68', 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
('physics', NULL, NULL, 'subject', 'ฟิสิกส์', '#d07842', 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('user','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `active`, `created_at`) VALUES
(2, 'kittipod', 'kittipodlui@gmail.com', 'scrypt$1a3a89ed357d0aa9308a879b4ff2aa7f$81a86d46e3487c1ba9f2dced7d16462366155e424fc56ae029e4143ef0a308a5927e62333ed653b4a8f4088fa24d152afb6c2bd27fa507951a0d6206092fdc6c', 'user', 1, '2026-10-06 07:50:23'),
(3, 'test', 'test@gmail.com', 'scrypt$c3f495c994cd4cce21f411a092faaa44$bbc899274c0ca4a53f005c79bf7b54433cc488d97f3a2203297d44ee91e25c34070c346dd995694160980b11dcb1ac0d94c51dc354cba88fac9f94780c069fd0', 'user', 1, '2026-10-08 10:14:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_subject_preferences`
--

CREATE TABLE `user_subject_preferences` (
  `user_id` bigint UNSIGNED NOT NULL,
  `subject_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` tinyint UNSIGNED NOT NULL DEFAULT '20',
  `is_added` tinyint(1) NOT NULL DEFAULT '0',
  `future_note` text COLLATE utf8mb4_unicode_ci,
  `lecture_notes` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_subject_preferences`
--

INSERT INTO `user_subject_preferences` (`user_id`, `subject_key`, `weight`, `is_added`, `future_note`, `lecture_notes`) VALUES
(3, 'custom_1ae2c96b59901dee8ab28f49', 30, 1, NULL, NULL),
(3, 'custom_278024dd7fd761ad14b7310c', 30, 1, NULL, NULL),
(3, 'custom_6dbb60d8c471e9fd0a56fffa', 30, 1, NULL, NULL),
(3, 'custom_e7ca41b9cdfeac485d355318', 10, 1, NULL, NULL),
(41, 'custom_3ff33f7bf8675abf6cca73cd', 30, 0, NULL, NULL),
(41, 'custom_b9645e05da5446d54a9c0527', 30, 0, NULL, NULL),
(41, 'custom_e70ab14bc5f9f893e794bfde', 20, 0, NULL, NULL),
(41, 'custom_f8ed80af74ccd21e8567641f', 30, 0, NULL, NULL),
(41, 'physics', 30, 1, NULL, NULL),
(45, 'custom_06a7bf6cdf97844c8e2324ca', 10, 1, NULL, NULL),
(45, 'custom_359454e8b5bb568c7f92c25b', 30, 1, NULL, NULL),
(45, 'custom_95c1c7aef8fa1e6bb04aa87d', 25, 1, NULL, NULL),
(45, 'custom_9eb1d8698ea8ac9a298e237e', 30, 1, NULL, NULL),
(45, 'custom_c466ffc5454d46b810a0f550', 10, 1, NULL, NULL),
(45, 'custom_cbd0116aaae19fee4b97147e', 20, 1, NULL, NULL),
(46, 'custom_2f98658a6554216071b64dd6', 30, 1, NULL, NULL),
(46, 'custom_3441b96581e040c11730c1e8', 20, 1, NULL, NULL),
(46, 'custom_7db8ffee6fe3163bc68b7831', 20, 1, NULL, NULL),
(46, 'custom_b6ed7968bff3b6e03df5735e', 20, 1, NULL, NULL),
(46, 'custom_c3d3e71f8604837424b25ab3', 20, 1, NULL, NULL),
(46, 'custom_f1c50c8cd31e23aed775519f', 20, 1, NULL, NULL),
(47, 'custom_09f7ac850f3e7ff42e0ad836', 30, 1, NULL, NULL),
(47, 'custom_e8a18ed851e28d1a814b9b34', 20, 1, NULL, NULL),
(48, 'custom_2345b019b7c1fd9b4d2cfaec', 30, 1, NULL, NULL),
(48, 'custom_2b975a0e1ba12338536d26b2', 20, 1, NULL, NULL),
(48, 'custom_32440e4bb1f4c93a8c1d443d', 20, 1, NULL, NULL),
(48, 'custom_4d0609d50e4d46b690303cc8', 10, 1, NULL, NULL),
(48, 'custom_8a390a70d28052493f6b2cfb', 30, 1, NULL, NULL),
(48, 'custom_a1bbdc3491a53f65c89275a9', 20, 1, NULL, NULL),
(48, 'custom_b23d825fbc392ae8e58e2745', 30, 1, NULL, NULL),
(48, 'custom_b667e2aec4a8bdd7fe7d1585', 30, 1, NULL, NULL),
(48, 'custom_fb4e8e4463c41cebdda2c656', 20, 1, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_sessions`
--
ALTER TABLE `auth_sessions`
  ADD PRIMARY KEY (`token_hash`),
  ADD KEY `idx_auth_sessions_user` (`user_id`);

--
-- Indexes for table `manual_study_blocks`
--
ALTER TABLE `manual_study_blocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_manual_blocks_category_day` (`user_id`,`category_id`,`day_index`),
  ADD KEY `fk_manual_block_category` (`category_id`),
  ADD KEY `fk_manual_block_subject` (`subject_key`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_schedules_user` (`user_id`),
  ADD KEY `idx_schedule_category` (`category_id`),
  ADD KEY `idx_schedule_user_category_week` (`user_id`,`category_id`,`week_start_date`,`id`);

--
-- Indexes for table `study_activities`
--
ALTER TABLE `study_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_study_activities_owner` (`user_id`,`category_id`,`start_date`),
  ADD KEY `idx_study_activities_course` (`course_key`),
  ADD KEY `fk_study_activity_category` (`category_id`);

--
-- Indexes for table `study_categories`
--
ALTER TABLE `study_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_category` (`user_id`,`name`);

--
-- Indexes for table `study_schedule_events`
--
ALTER TABLE `study_schedule_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_schedule_events_owner` (`user_id`,`category_id`,`created_at`),
  ADD KEY `fk_schedule_event_category` (`category_id`),
  ADD KEY `fk_schedule_event_schedule` (`schedule_id`);

--
-- Indexes for table `study_sessions`
--
ALTER TABLE `study_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `one_subject_per_slot` (`schedule_id`,`day_index`,`session_index`),
  ADD KEY `fk_session_subject` (`subject_key`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_key`),
  ADD KEY `idx_subject_owner` (`user_id`),
  ADD KEY `idx_subject_category` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `unique_user_email` (`email`);

--
-- Indexes for table `user_subject_preferences`
--
ALTER TABLE `user_subject_preferences`
  ADD PRIMARY KEY (`user_id`,`subject_key`),
  ADD KEY `fk_preference_subject` (`subject_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `manual_study_blocks`
--
ALTER TABLE `manual_study_blocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `study_activities`
--
ALTER TABLE `study_activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `study_categories`
--
ALTER TABLE `study_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `study_schedule_events`
--
ALTER TABLE `study_schedule_events`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT for table `study_sessions`
--
ALTER TABLE `study_sessions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6321;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_sessions`
--
ALTER TABLE `auth_sessions`
  ADD CONSTRAINT `fk_auth_session_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `manual_study_blocks`
--
ALTER TABLE `manual_study_blocks`
  ADD CONSTRAINT `fk_manual_block_category` FOREIGN KEY (`category_id`) REFERENCES `study_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_manual_block_subject` FOREIGN KEY (`subject_key`) REFERENCES `subjects` (`subject_key`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_manual_block_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `fk_schedule_category` FOREIGN KEY (`category_id`) REFERENCES `study_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_schedule_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `study_activities`
--
ALTER TABLE `study_activities`
  ADD CONSTRAINT `fk_study_activity_category` FOREIGN KEY (`category_id`) REFERENCES `study_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_study_activity_course` FOREIGN KEY (`course_key`) REFERENCES `subjects` (`subject_key`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_study_activity_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `study_categories`
--
ALTER TABLE `study_categories`
  ADD CONSTRAINT `fk_category_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `study_schedule_events`
--
ALTER TABLE `study_schedule_events`
  ADD CONSTRAINT `fk_schedule_event_category` FOREIGN KEY (`category_id`) REFERENCES `study_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_schedule_event_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_schedule_event_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `study_sessions`
--
ALTER TABLE `study_sessions`
  ADD CONSTRAINT `fk_session_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_session_subject` FOREIGN KEY (`subject_key`) REFERENCES `subjects` (`subject_key`);

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `fk_subject_category` FOREIGN KEY (`category_id`) REFERENCES `study_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subject_owner` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_subject_preferences`
--
ALTER TABLE `user_subject_preferences`
  ADD CONSTRAINT `fk_preference_subject` FOREIGN KEY (`subject_key`) REFERENCES `subjects` (`subject_key`),
  ADD CONSTRAINT `fk_preference_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
