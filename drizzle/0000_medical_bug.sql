CREATE TABLE `audit` (
	`id` text PRIMARY KEY NOT NULL,
	`record` text NOT NULL,
	`owner` text NOT NULL,
	`actor` text NOT NULL,
	`action` text NOT NULL,
	`details` text NOT NULL,
	`date` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `idx_audit_record` ON `audit` (`record`);--> statement-breakpoint
CREATE TABLE `config` (
	`id` text PRIMARY KEY NOT NULL,
	`data` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `documents` (
	`id` text PRIMARY KEY NOT NULL,
	`booking` text NOT NULL,
	`name` text NOT NULL,
	`type` text NOT NULL,
	`personal` integer NOT NULL,
	`size` integer NOT NULL,
	`created` text NOT NULL,
	FOREIGN KEY (`booking`) REFERENCES `records`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `employees` (
	`id` text PRIMARY KEY NOT NULL,
	`auth_id` text,
	`email` text NOT NULL,
	`name` text NOT NULL,
	`role` text NOT NULL,
	`active` integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `employees_auth_id_unique` ON `employees` (`auth_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `employees_email_unique` ON `employees` (`email`);--> statement-breakpoint
CREATE TABLE `records` (
	`id` text PRIMARY KEY NOT NULL,
	`kind` text NOT NULL,
	`owner` text NOT NULL,
	`parent` text,
	`client` text,
	`phone` text,
	`email` text,
	`data` text NOT NULL,
	`version` integer DEFAULT 1 NOT NULL,
	`token` text NOT NULL,
	`created` text NOT NULL,
	FOREIGN KEY (`owner`) REFERENCES `employees`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `records_phone_unique` ON `records` (`phone`);--> statement-breakpoint
CREATE UNIQUE INDEX `records_email_unique` ON `records` (`email`);--> statement-breakpoint
CREATE INDEX `idx_records_owner_kind` ON `records` (`owner`,`kind`);--> statement-breakpoint
CREATE INDEX `idx_records_parent` ON `records` (`parent`);--> statement-breakpoint
CREATE INDEX `idx_records_client` ON `records` (`client`);