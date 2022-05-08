CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__chat (
	chat_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	chat_status TINYINT(1) NOT NULL DEFAULT '0',
	chat_hash VARCHAR(40) NOT NULL,
	time_start INT(11) UNSIGNED NOT NULL,
	time_end INT(11) UNSIGNED NOT NULL,
	last_activity INT(11) UNSIGNED NOT NULL,
	user_typing TINYINT(1) NOT NULL DEFAULT '0',
	operator_typing TINYINT(1) NOT NULL DEFAULT '0',
	ip_address VARCHAR(100) NOT NULL,
	username VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	referer TEXT,
	department_name VARCHAR(100) NOT NULL,
	department_id INT(11) UNSIGNED NOT NULL,
	PRIMARY KEY (chat_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__messages (
	message_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	chat_id INT(11) UNSIGNED NOT NULL,
	message TEXT,
	operator_name VARCHAR(100) NOT NULL,
	time INT(11) UNSIGNED NOT NULL,
	PRIMARY KEY (message_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__operators (
	operator_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT(11) UNSIGNED NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) DEFAULT NULL,
	last_activity INT(11) UNSIGNED NOT NULL,
	hide_online TINYINT(1) NOT NULL,
	PRIMARY KEY (operator_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__departments (
	department_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	department_name VARCHAR(100) NOT NULL,
	department_email VARCHAR(100) NOT NULL,
	PRIMARY KEY (department_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO __TABLE_PREFIX__departments VALUES(1, 'Support', 'email@example.com');

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__department_operators (
	department_id INT(11) UNSIGNED NOT NULL,
	operator_id INT(11) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO __TABLE_PREFIX__department_operators VALUES(1, 1);

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__online_visitors (
	visitor_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	ip_address VARCHAR(100) NOT NULL,
	referer TEXT,
	invitation_message TEXT,
	time INT(11) UNSIGNED NOT NULL,
	PRIMARY KEY (visitor_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__canned_messages (
	message_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	canned_message TEXT,
	PRIMARY KEY (message_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO __TABLE_PREFIX__canned_messages VALUES(1, 'Hello!');
INSERT INTO __TABLE_PREFIX__canned_messages VALUES(2, 'Hello! How may I help you?');

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__options (
	option_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	option_name VARCHAR(64) NOT NULL,
	option_value TEXT,
	PRIMARY KEY (option_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO __TABLE_PREFIX__options VALUES(1, 'site_title', '');
INSERT INTO __TABLE_PREFIX__options VALUES(2, 'absolute_url', '');
INSERT INTO __TABLE_PREFIX__options VALUES(3, 'absolute_path', '');
INSERT INTO __TABLE_PREFIX__options VALUES(4, 'admin_email', '');
INSERT INTO __TABLE_PREFIX__options VALUES(5, 'online_timeout', 60);
INSERT INTO __TABLE_PREFIX__options VALUES(6, 'ip_tracker_url', '');
INSERT INTO __TABLE_PREFIX__options VALUES(7, 'date_format', 'd/m/Y');
INSERT INTO __TABLE_PREFIX__options VALUES(8, 'time_format', 'H.i.s');
INSERT INTO __TABLE_PREFIX__options VALUES(9, 'timezone', 'UTC');
INSERT INTO __TABLE_PREFIX__options VALUES(10, 'max_connections', 2);
INSERT INTO __TABLE_PREFIX__options VALUES(11, 'console_interval', 2);
INSERT INTO __TABLE_PREFIX__options VALUES(12, 'chat_interval', 2);
INSERT INTO __TABLE_PREFIX__options VALUES(13, 'background_color_1', '#5BB75B');
INSERT INTO __TABLE_PREFIX__options VALUES(14, 'background_color_2', '#FFFFFF');
INSERT INTO __TABLE_PREFIX__options VALUES(15, 'color_1', '#FFFFFF');
INSERT INTO __TABLE_PREFIX__options VALUES(16, 'color_2', '#000000');
INSERT INTO __TABLE_PREFIX__options VALUES(17, 'records_per_page', 10);
INSERT INTO __TABLE_PREFIX__options VALUES(18, 'access_logs', 1);
INSERT INTO __TABLE_PREFIX__options VALUES(19, 'user_expire', 1800);
INSERT INTO __TABLE_PREFIX__options VALUES(20, 'secret_word', SUBSTRING(MD5(RAND()) FROM 1 FOR 20));
INSERT INTO __TABLE_PREFIX__options VALUES(21, 'template_extension', '.tpl');
INSERT INTO __TABLE_PREFIX__options VALUES(22, 'chat_expire', 600);
INSERT INTO __TABLE_PREFIX__options VALUES(23, 'charset', 'UTF-8');
INSERT INTO __TABLE_PREFIX__options VALUES(24, 'max_visitors', 15);
INSERT INTO __TABLE_PREFIX__options VALUES(25, 'background_color_3', '#006DCC');
INSERT INTO __TABLE_PREFIX__options VALUES(26, 'color_3', '#FFFFFF');

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__languages (
	language_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	language_name VARCHAR(32) NOT NULL,
	language_iso_code VARCHAR(5) NOT NULL,
	PRIMARY KEY (language_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO __TABLE_PREFIX__languages VALUES(1, 'English', 'en');

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__translations (
	translation_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	language_id INT(11) UNSIGNED NOT NULL,
	translation_key TEXT,
	translation_text TEXT,
	PRIMARY KEY (translation_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO __TABLE_PREFIX__translations VALUES(1, 1, 'Name', 'Name');
INSERT INTO __TABLE_PREFIX__translations VALUES(2, 1, 'Email', 'Email');
INSERT INTO __TABLE_PREFIX__translations VALUES(3, 1, 'Department', 'Department');
INSERT INTO __TABLE_PREFIX__translations VALUES(4, 1, 'Message', 'Message');
INSERT INTO __TABLE_PREFIX__translations VALUES(5, 1, '(Required)', '(Required)');
INSERT INTO __TABLE_PREFIX__translations VALUES(6, 1, '(Offline)', '(Offline)');
INSERT INTO __TABLE_PREFIX__translations VALUES(7, 1, '/', '/');
INSERT INTO __TABLE_PREFIX__translations VALUES(8, 1, 'Home', 'Home');
INSERT INTO __TABLE_PREFIX__translations VALUES(9, 1, 'Access logs', 'Access logs');
INSERT INTO __TABLE_PREFIX__translations VALUES(10, 1, 'Full name', 'Full name');
INSERT INTO __TABLE_PREFIX__translations VALUES(11, 1, 'IP address', 'IP address');
INSERT INTO __TABLE_PREFIX__translations VALUES(12, 1, 'Last login', 'Last login');
INSERT INTO __TABLE_PREFIX__translations VALUES(13, 1, 'Canned messages', 'Canned messages');
INSERT INTO __TABLE_PREFIX__translations VALUES(14, 1, 'Add message', 'Add message');
INSERT INTO __TABLE_PREFIX__translations VALUES(15, 1, 'Select message', 'Select message');
INSERT INTO __TABLE_PREFIX__translations VALUES(16, 1, 'Loading...', 'Loading...');
INSERT INTO __TABLE_PREFIX__translations VALUES(17, 1, 'Online visitors', 'Online visitors');
INSERT INTO __TABLE_PREFIX__translations VALUES(18, 1, 'Departments', 'Departments');
INSERT INTO __TABLE_PREFIX__translations VALUES(19, 1, 'Add department', 'Add department');
INSERT INTO __TABLE_PREFIX__translations VALUES(20, 1, 'Department name', 'Department name');
INSERT INTO __TABLE_PREFIX__translations VALUES(21, 1, 'Department email', 'Department email');
INSERT INTO __TABLE_PREFIX__translations VALUES(22, 1, 'Groups', 'Groups');
INSERT INTO __TABLE_PREFIX__translations VALUES(23, 1, 'Add group', 'Add group');
INSERT INTO __TABLE_PREFIX__translations VALUES(24, 1, 'Group name', 'Group name');
INSERT INTO __TABLE_PREFIX__translations VALUES(25, 1, 'Permissions', 'Permissions');
INSERT INTO __TABLE_PREFIX__translations VALUES(26, 1, 'Languages', 'Languages');
INSERT INTO __TABLE_PREFIX__translations VALUES(27, 1, 'Add language', 'Add language');
INSERT INTO __TABLE_PREFIX__translations VALUES(28, 1, 'Language name', 'Language name');
INSERT INTO __TABLE_PREFIX__translations VALUES(29, 1, 'Language code', 'Language code');
INSERT INTO __TABLE_PREFIX__translations VALUES(30, 1, 'Operators', 'Operators');
INSERT INTO __TABLE_PREFIX__translations VALUES(31, 1, 'Add operator', 'Add operator');
INSERT INTO __TABLE_PREFIX__translations VALUES(32, 1, 'First name', 'First name');
INSERT INTO __TABLE_PREFIX__translations VALUES(33, 1, 'Last name', 'Last name');
INSERT INTO __TABLE_PREFIX__translations VALUES(34, 1, 'Operator email', 'Operator email');
INSERT INTO __TABLE_PREFIX__translations VALUES(35, 1, 'Password', 'Password');
INSERT INTO __TABLE_PREFIX__translations VALUES(36, 1, 'Confirm password', 'Confirm password');
INSERT INTO __TABLE_PREFIX__translations VALUES(37, 1, 'Active', 'Active');
INSERT INTO __TABLE_PREFIX__translations VALUES(38, 1, 'Inactive', 'Inactive');
INSERT INTO __TABLE_PREFIX__translations VALUES(39, 1, 'Hide online', 'Hide online');
INSERT INTO __TABLE_PREFIX__translations VALUES(40, 1, 'Blocked visitors', 'Blocked visitors');
INSERT INTO __TABLE_PREFIX__translations VALUES(41, 1, 'Description', 'Description');
INSERT INTO __TABLE_PREFIX__translations VALUES(42, 1, 'Date', 'Date');
INSERT INTO __TABLE_PREFIX__translations VALUES(43, 1, 'Close', 'Close');
INSERT INTO __TABLE_PREFIX__translations VALUES(44, 1, 'Delete', 'Delete');
INSERT INTO __TABLE_PREFIX__translations VALUES(45, 1, 'Action', 'Action');
INSERT INTO __TABLE_PREFIX__translations VALUES(46, 1, 'Chat history', 'Chat history');
INSERT INTO __TABLE_PREFIX__translations VALUES(47, 1, 'Time in chat', 'Time in chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(48, 1, 'Edit message', 'Edit message');
INSERT INTO __TABLE_PREFIX__translations VALUES(49, 1, 'Edit department', 'Edit department');
INSERT INTO __TABLE_PREFIX__translations VALUES(50, 1, 'Edit group', 'Edit group');
INSERT INTO __TABLE_PREFIX__translations VALUES(51, 1, 'Edit language', 'Edit language');
INSERT INTO __TABLE_PREFIX__translations VALUES(52, 1, 'Edit operator', 'Edit operator');
INSERT INTO __TABLE_PREFIX__translations VALUES(53, 1, 'Edit translation', 'Edit translation');
INSERT INTO __TABLE_PREFIX__translations VALUES(54, 1, 'Translations', 'Translations');
INSERT INTO __TABLE_PREFIX__translations VALUES(55, 1, 'Key', 'Key');
INSERT INTO __TABLE_PREFIX__translations VALUES(56, 1, 'Remember me', 'Remember me');
INSERT INTO __TABLE_PREFIX__translations VALUES(57, 1, 'Reset password', 'Reset password');
INSERT INTO __TABLE_PREFIX__translations VALUES(58, 1, 'Lost your password?', 'Lost your password?');
INSERT INTO __TABLE_PREFIX__translations VALUES(59, 1, 'Login', 'Login');
INSERT INTO __TABLE_PREFIX__translations VALUES(60, 1, 'Settings', 'Settings');
INSERT INTO __TABLE_PREFIX__translations VALUES(61, 1, 'Last activity', 'Last activity');
INSERT INTO __TABLE_PREFIX__translations VALUES(62, 1, 'Status', 'Status');
INSERT INTO __TABLE_PREFIX__translations VALUES(63, 1, 'Total time', 'Total time');
INSERT INTO __TABLE_PREFIX__translations VALUES(64, 1, 'In queue', 'In queue');
INSERT INTO __TABLE_PREFIX__translations VALUES(65, 1, 'In chat', 'In chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(66, 1, 'Block user', 'Block user');
INSERT INTO __TABLE_PREFIX__translations VALUES(67, 1, 'Click to chat', 'Click to chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(68, 1, 'Watch the chat', 'Watch the chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(69, 1, 'Permission denied', 'Permission denied');
INSERT INTO __TABLE_PREFIX__translations VALUES(70, 1, 'General', 'General');
INSERT INTO __TABLE_PREFIX__translations VALUES(71, 1, 'Server', 'Server');
INSERT INTO __TABLE_PREFIX__translations VALUES(72, 1, 'Authentication', 'Authentication');
INSERT INTO __TABLE_PREFIX__translations VALUES(73, 1, 'Style', 'Style');
INSERT INTO __TABLE_PREFIX__translations VALUES(74, 1, 'Site title', 'Site title');
INSERT INTO __TABLE_PREFIX__translations VALUES(75, 1, 'Console interval', 'Console interval');
INSERT INTO __TABLE_PREFIX__translations VALUES(76, 1, '(seconds)', '(seconds)');
INSERT INTO __TABLE_PREFIX__translations VALUES(77, 1, 'IP tracker url', 'IP tracker url');
INSERT INTO __TABLE_PREFIX__translations VALUES(78, 1, 'Chat interval', 'Chat interval');
INSERT INTO __TABLE_PREFIX__translations VALUES(79, 1, 'Chat lifetime', 'Chat lifetime');
INSERT INTO __TABLE_PREFIX__translations VALUES(80, 1, 'Records per page', 'Records per page');
INSERT INTO __TABLE_PREFIX__translations VALUES(81, 1, 'Charset', 'Charset');
INSERT INTO __TABLE_PREFIX__translations VALUES(82, 1, 'Timezone', 'Timezone');
INSERT INTO __TABLE_PREFIX__translations VALUES(83, 1, 'Date format', 'Date format');
INSERT INTO __TABLE_PREFIX__translations VALUES(84, 1, 'Time format', 'Time format');
INSERT INTO __TABLE_PREFIX__translations VALUES(85, 1, 'Session lifetime', 'Session lifetime');
INSERT INTO __TABLE_PREFIX__translations VALUES(86, 1, 'Yes', 'Yes');
INSERT INTO __TABLE_PREFIX__translations VALUES(87, 1, 'No', 'No');
INSERT INTO __TABLE_PREFIX__translations VALUES(88, 1, 'View chat', 'View chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(89, 1, 'Transfer chat', 'Transfer chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(90, 1, 'Header background color', 'Header background color');
INSERT INTO __TABLE_PREFIX__translations VALUES(91, 1, 'Header text color', 'Header text color');
INSERT INTO __TABLE_PREFIX__translations VALUES(92, 1, 'Content background color', 'Content background color');
INSERT INTO __TABLE_PREFIX__translations VALUES(93, 1, 'Content text color', 'Content text color');
INSERT INTO __TABLE_PREFIX__translations VALUES(94, 1, 'Operator time as online', 'Operator time as online');
INSERT INTO __TABLE_PREFIX__translations VALUES(95, 1, 'Number of connections from one address', 'Number of connections from one address');
INSERT INTO __TABLE_PREFIX__translations VALUES(96, 1, 'Referer', 'Referer');
INSERT INTO __TABLE_PREFIX__translations VALUES(97, 1, 'Filter', 'Filter');
INSERT INTO __TABLE_PREFIX__translations VALUES(98, 1, 'Text', 'Text');
INSERT INTO __TABLE_PREFIX__translations VALUES(99, 1, 'Previous', 'Previous');
INSERT INTO __TABLE_PREFIX__translations VALUES(100, 1, 'Next', 'Next');
INSERT INTO __TABLE_PREFIX__translations VALUES(101, 1, 'Embed code', 'Embed code');
INSERT INTO __TABLE_PREFIX__translations VALUES(102, 1, '<p>You have a message from %s:</p><p>%s</p><p>Name: %s<br>Email: %s<br>IP: %s</p><p>Regards,<br><br>%s</p>', '&#60;p&#62;You have a message from %s:&#60;/p&#62;&#60;p&#62;%s&#60;/p&#62;&#60;p&#62;Name: %s&#60;br&#62;Email: %s&#60;br&#62;IP: %s&#60;/p&#62;&#60;p&#62;Regards,&#60;br&#62;&#60;br&#62;%s&#60;/p&#62;');
INSERT INTO __TABLE_PREFIX__translations VALUES(103, 1, '<p>A new password was requested from %s.</p><p>Your new password is:</p><p>%s</p><p><a href="%s" target="_blank">%s</a></p>', '&#60;p&#62;A new password was requested from %s.&#60;/p&#62;&#60;p&#62;Your new password is:&#60;/p&#62;&#60;p&#62;%s&#60;/p&#62;&#60;p&#62;&#60;a href=&#34;%s&#34; target=&#34;_blank&#34;&#62;%s&#60;/a&#62;&#60;/p&#62;');
INSERT INTO __TABLE_PREFIX__translations VALUES(104, 1, 'Question from', 'Question from ');
INSERT INTO __TABLE_PREFIX__translations VALUES(105, 1, 'New Password', 'New Password');
INSERT INTO __TABLE_PREFIX__translations VALUES(106, 1, 'Start chat', 'Start chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(107, 1, 'Send message', 'Send message');
INSERT INTO __TABLE_PREFIX__translations VALUES(108, 1, 'Send', 'Send');
INSERT INTO __TABLE_PREFIX__translations VALUES(109, 1, 'Close chat', 'Close chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(110, 1, 'Save', 'Save');
INSERT INTO __TABLE_PREFIX__translations VALUES(111, 1, 'Invite', 'Invite');
INSERT INTO __TABLE_PREFIX__translations VALUES(112, 1, 'Login', 'Login');
INSERT INTO __TABLE_PREFIX__translations VALUES(113, 1, 'Thank you for contacting us, an operator will be with you shortly.', 'Thank you for contacting us, an operator will be with you shortly.');
INSERT INTO __TABLE_PREFIX__translations VALUES(114, 1, 'At this moment there are no logged members, but you can leave your messages.', 'At this moment there are no logged members, but you can leave your messages.');
INSERT INTO __TABLE_PREFIX__translations VALUES(115, 1, 'Your IP has been banned, please contact us to get more information.', 'Your IP has been banned, please contact us to get more information.');
INSERT INTO __TABLE_PREFIX__translations VALUES(116, 1, 'Message sent successfully!', 'Message sent successfully!');
INSERT INTO __TABLE_PREFIX__translations VALUES(117, 1, 'An error occurred while processing request:', 'An error occurred while processing request:');
INSERT INTO __TABLE_PREFIX__translations VALUES(118, 1, 'Record added successfully!', 'Record added successfully!');
INSERT INTO __TABLE_PREFIX__translations VALUES(119, 1, 'Record edited successfully!', 'Record edited successfully!');
INSERT INTO __TABLE_PREFIX__translations VALUES(120, 1, 'This email address is already taken!', 'This email address is already taken!');
INSERT INTO __TABLE_PREFIX__translations VALUES(121, 1, 'These item(s) will be permanently deleted and cannot be recovered. Are you sure?', 'These item(s) will be permanently deleted and cannot be recovered. Are you sure?');
INSERT INTO __TABLE_PREFIX__translations VALUES(122, 1, 'You do not have permission to access this page, please contact the system administrator.', 'You do not have permission to access this page, please contact the system administrator.');
INSERT INTO __TABLE_PREFIX__translations VALUES(123, 1, 'User has left the chat', 'User has left the chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(124, 1, 'Thanks for contacting us! Please fill out the form below and representative will be with you shortly.', 'Thanks for contacting us! Please fill out the form below and representative will be with you shortly.');
INSERT INTO __TABLE_PREFIX__translations VALUES(125, 1, 'A new password has been sent to your email address!', 'A new password has been sent to your email address!');
INSERT INTO __TABLE_PREFIX__translations VALUES(126, 1, 'Change status to online/offline', 'Change status to online/offline');
INSERT INTO __TABLE_PREFIX__translations VALUES(127, 1, 'Chat transfered to another operator, please wait.', 'Chat transfered to another operator, please wait.');
INSERT INTO __TABLE_PREFIX__translations VALUES(128, 1, 'Too many requests are being made from your IP address.', 'Too many requests are being made from your IP address.');
INSERT INTO __TABLE_PREFIX__translations VALUES(129, 1, 'The list of awaiting visitors is empty.', 'The list of awaiting visitors is empty.');
INSERT INTO __TABLE_PREFIX__translations VALUES(130, 1, 'Operator joined the chat', 'Operator joined the chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(131, 1, 'No visitors.', 'No visitors.');
INSERT INTO __TABLE_PREFIX__translations VALUES(132, 1, 'Operator has left the chat', 'Operator has left the chat');
INSERT INTO __TABLE_PREFIX__translations VALUES(133, 1, 'Operator is typing now...', 'Operator is typing now...');
INSERT INTO __TABLE_PREFIX__translations VALUES(134, 1, 'User is typing now...', 'User is typing now...');
INSERT INTO __TABLE_PREFIX__translations VALUES(135, 1, 'Records not found.', 'Records not found.');
INSERT INTO __TABLE_PREFIX__translations VALUES(136, 1, 'You are offline', 'You are offline');
INSERT INTO __TABLE_PREFIX__translations VALUES(137, 1, 'You are online', 'You are online');
INSERT INTO __TABLE_PREFIX__translations VALUES(138, 1, 'Departments not found', 'Departments not found');
INSERT INTO __TABLE_PREFIX__translations VALUES(139, 1, 'Contact us - Offline', 'Contact us - Offline');
INSERT INTO __TABLE_PREFIX__translations VALUES(140, 1, 'Chat started with -', 'Chat started with - ');
INSERT INTO __TABLE_PREFIX__translations VALUES(141, 1, 'We are online, chat with us!', 'We are online, chat with us!');
INSERT INTO __TABLE_PREFIX__translations VALUES(142, 1, 'Thank you for your message. We will answer your question by email as soon as possible.', 'Thank you for your message. We will answer your question by email as soon as possible.');
INSERT INTO __TABLE_PREFIX__translations VALUES(143, 1, 'Copy and paste the following code on your website pages, just before the closing </body> tag.', 'Copy and paste the following code on your website pages, just before the closing </body> tag.');
INSERT INTO __TABLE_PREFIX__translations VALUES(144, 1, 'Cannot be deleted is currently assigned.', 'Cannot be deleted is currently assigned.');
INSERT INTO __TABLE_PREFIX__translations VALUES(145, 1, 'Please enter a canned message.', 'Please enter a canned message.');
INSERT INTO __TABLE_PREFIX__translations VALUES(146, 1, 'Please enter a department name.', 'Please enter a department name.');
INSERT INTO __TABLE_PREFIX__translations VALUES(147, 1, 'Please enter a department email address.', 'Please enter a department email address.');
INSERT INTO __TABLE_PREFIX__translations VALUES(148, 1, 'Please enter a group name.', 'Please enter a group name.');
INSERT INTO __TABLE_PREFIX__translations VALUES(149, 1, 'Please enter a language name.', 'Please enter a language name.');
INSERT INTO __TABLE_PREFIX__translations VALUES(150, 1, 'Please enter a language code.', 'Please enter a language code.');
INSERT INTO __TABLE_PREFIX__translations VALUES(151, 1, 'Please enter a operator name.', 'Please enter a operator name.');
INSERT INTO __TABLE_PREFIX__translations VALUES(152, 1, 'Email address not valid.', 'Email address not valid.');
INSERT INTO __TABLE_PREFIX__translations VALUES(153, 1, 'Please enter a password.', 'Please enter a password.');
INSERT INTO __TABLE_PREFIX__translations VALUES(154, 1, 'The password field does not match the confirm password field.', 'The password field does not match the confirm password field.');
INSERT INTO __TABLE_PREFIX__translations VALUES(155, 1, 'Please select a department.', 'Please select a department.');
INSERT INTO __TABLE_PREFIX__translations VALUES(156, 1, 'Please select a page.', 'Please select a page.');
INSERT INTO __TABLE_PREFIX__translations VALUES(157, 1, 'Please enter a site title.', 'Please enter a site title.');
INSERT INTO __TABLE_PREFIX__translations VALUES(158, 1, 'Please enter a online timeout.', 'Please enter a online timeout.');
INSERT INTO __TABLE_PREFIX__translations VALUES(159, 1, 'Please enter a console interval.', 'Please enter a console interval.');
INSERT INTO __TABLE_PREFIX__translations VALUES(160, 1, 'Please enter a chat interval.', 'Please enter a chat interval.');
INSERT INTO __TABLE_PREFIX__translations VALUES(161, 1, 'Please enter a number of connections.', 'Please enter a number of connections.');
INSERT INTO __TABLE_PREFIX__translations VALUES(162, 1, 'Please enter a chat expire.', 'Please enter a chat expire.');
INSERT INTO __TABLE_PREFIX__translations VALUES(163, 1, 'Please enter a date format.', 'Please enter a date format.');
INSERT INTO __TABLE_PREFIX__translations VALUES(164, 1, 'Please enter a time format.', 'Please enter a time format.');
INSERT INTO __TABLE_PREFIX__translations VALUES(165, 1, 'Please enter a valid URL.', 'Please enter a valid URL.');
INSERT INTO __TABLE_PREFIX__translations VALUES(166, 1, 'Please enter a user expire.', 'Please enter a user expire.');
INSERT INTO __TABLE_PREFIX__translations VALUES(167, 1, 'Please enter a records per page.', 'Please enter a records per page.');
INSERT INTO __TABLE_PREFIX__translations VALUES(168, 1, 'Please enter a IP address.', 'Please enter a IP address.');
INSERT INTO __TABLE_PREFIX__translations VALUES(169, 1, 'Please enter a description.', 'Please enter a description.');
INSERT INTO __TABLE_PREFIX__translations VALUES(170, 1, 'The Ip address is already in use.', 'The Ip address is already in use.');
INSERT INTO __TABLE_PREFIX__translations VALUES(171, 1, 'The email address or password you entered is incorrect.', 'The email address or password you entered is incorrect.');
INSERT INTO __TABLE_PREFIX__translations VALUES(172, 1, 'The email address was not found in our records, please try again!', 'The email address was not found in our records, please try again!');
INSERT INTO __TABLE_PREFIX__translations VALUES(173, 1, 'Error sending email, try again later.', 'Error sending email, try again later.');
INSERT INTO __TABLE_PREFIX__translations VALUES(174, 1, 'Invalid security token!', 'Invalid security token!');
INSERT INTO __TABLE_PREFIX__translations VALUES(175, 1, 'You can not delete your account!', 'You can not delete your account!');
INSERT INTO __TABLE_PREFIX__translations VALUES(176, 1, 'Number of visitors at one time', 'Number of visitors at one time');
INSERT INTO __TABLE_PREFIX__translations VALUES(177, 1, 'Please enter a number of visitors.', 'Please enter a number of visitors.');
INSERT INTO __TABLE_PREFIX__translations VALUES(178, 1, 'Button background color', 'Button background color');
INSERT INTO __TABLE_PREFIX__translations VALUES(179, 1, 'Button text color', 'Button text color');

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__blocked_visitors (
	blocked_visitor_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	ip_address VARCHAR(100) NOT NULL,
	description VARCHAR(255) NOT NULL,
	time INT(11) UNSIGNED NOT NULL,
	PRIMARY KEY (blocked_visitor_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__users (
	user_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	group_id INT(11) UNSIGNED NOT NULL,
	user_email VARCHAR(100) NOT NULL,
	user_password VARCHAR(40) NOT NULL,
	user_status TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	user_approved TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	user_created INT(11) UNSIGNED NOT NULL,
	last_login INT(11) UNSIGNED NOT NULL,
	last_ip VARCHAR(40) NOT NULL,
	remember_code VARCHAR(40) DEFAULT NULL,
	activation_code VARCHAR(40) DEFAULT NULL,
	PRIMARY KEY (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__user_profiles (
	profile_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT(11) UNSIGNED NOT NULL,
	first_name VARCHAR(50) NOT NULL,  
	last_name VARCHAR(50) DEFAULT NULL, 
	PRIMARY KEY (profile_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__user_groups (
	group_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	group_name VARCHAR(20) NOT NULL,
	group_permissions TEXT,
	PRIMARY KEY (group_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS __TABLE_PREFIX__access_logs (
	log_id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT(11) UNSIGNED NOT NULL,
	log_ip VARCHAR(15) NOT NULL,
	time INT(11) UNSIGNED NOT NULL,
	PRIMARY KEY (log_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
