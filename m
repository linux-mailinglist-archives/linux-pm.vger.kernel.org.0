Return-Path: <linux-pm+bounces-18376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E89E0B9C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AEE2813DD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A451DEFE3;
	Mon,  2 Dec 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DnWALlZl"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024901DE3D5;
	Mon,  2 Dec 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166144; cv=none; b=TPt3ysl+ZjZOUsrlVM2QsOmDo3cAQwmlx6XcYXj3Lc4MeFMDgJ2pwtyT67ffBcj4HsDuaNwcUqG1vo+FUKhlfWF3L5SH+vWaUgLdm46HknFb2AK1AY7fJdTZn7AXGvZJ1bSvgeVqFgPXlkq+qZ8UyLwXdKuJEgZFJTz34qtDKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166144; c=relaxed/simple;
	bh=Z0h4ZU5IdA8MLG7R/DevJ7HuP4dynhwfphEzIsEpgUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMrGfFNdtAGxS7b/u/qf3derzZcLa4aPYwiN8ZlH9dKcj/wie5eFKCdjPiD9Iy6oc9MY1To6E418y1kmmHzGei6L9SAwa1sxKR2MSfXvRoECPEyhC7v4PMdRq/xqXh4c7JnYSWoQfpT0JPrrkdPf2CNCjL0BiEtBLdK9UJdyCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DnWALlZl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166139;
	bh=Z0h4ZU5IdA8MLG7R/DevJ7HuP4dynhwfphEzIsEpgUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DnWALlZlflbrMuJygvQRNC1ziGST2Zo9fMRojnXzCabB+tglAvqABG9/EDZmfVVza
	 Zta2HnH6SEywXShidZGOLnwgnPUvnymJmRrpc6JQt3sCemLxH8gnE1Z4jQhCxJuidk
	 q++R7xR5dJoH9MY0Hut0IhpwmhmsZ4Y+R/k6WScs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:20 +0100
Subject: [PATCH 2/4] power: supply: ds2780: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-psy-v1-2-f846430b8b66@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166139; l=3753;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Z0h4ZU5IdA8MLG7R/DevJ7HuP4dynhwfphEzIsEpgUE=;
 b=IlF5wI4owF498zfnb+j16PVNeEG8Qvr5mIy1b4ojXCInXQQhBXtRNMlKDuilGbPZpv583U5yr
 9cItBx43RJxAaWXkbTNMjeavqGXcmEbdcXUL42dB7KsZeXap1q7pbNG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ds2780_battery.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 1e7f297f6cb181e6ab7dc8e47b638aa43db8db97..dd9ac7a3296716d8ab72db56c1d9c0e439c3b2a9 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -621,7 +621,7 @@ static ssize_t ds2780_set_pio_pin(struct device *dev,
 
 static ssize_t ds2780_read_param_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -634,7 +634,7 @@ static ssize_t ds2780_read_param_eeprom_bin(struct file *filp,
 
 static ssize_t ds2780_write_param_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -654,19 +654,19 @@ static ssize_t ds2780_write_param_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2780_param_eeprom_bin_attr = {
+static const struct bin_attribute ds2780_param_eeprom_bin_attr = {
 	.attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
 	},
 	.size = DS2780_PARAM_EEPROM_SIZE,
-	.read = ds2780_read_param_eeprom_bin,
-	.write = ds2780_write_param_eeprom_bin,
+	.read_new = ds2780_read_param_eeprom_bin,
+	.write_new = ds2780_write_param_eeprom_bin,
 };
 
 static ssize_t ds2780_read_user_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -679,7 +679,7 @@ static ssize_t ds2780_read_user_eeprom_bin(struct file *filp,
 
 static ssize_t ds2780_write_user_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -699,14 +699,14 @@ static ssize_t ds2780_write_user_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2780_user_eeprom_bin_attr = {
+static const struct bin_attribute ds2780_user_eeprom_bin_attr = {
 	.attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
 	},
 	.size = DS2780_USER_EEPROM_SIZE,
-	.read = ds2780_read_user_eeprom_bin,
-	.write = ds2780_write_user_eeprom_bin,
+	.read_new = ds2780_read_user_eeprom_bin,
+	.write_new = ds2780_write_user_eeprom_bin,
 };
 
 static DEVICE_ATTR(pmod_enabled, S_IRUGO | S_IWUSR, ds2780_get_pmod_enabled,
@@ -726,7 +726,7 @@ static struct attribute *ds2780_sysfs_attrs[] = {
 	NULL
 };
 
-static struct bin_attribute *ds2780_sysfs_bin_attrs[] = {
+static const struct bin_attribute *const ds2780_sysfs_bin_attrs[] = {
 	&ds2780_param_eeprom_bin_attr,
 	&ds2780_user_eeprom_bin_attr,
 	NULL
@@ -734,7 +734,7 @@ static struct bin_attribute *ds2780_sysfs_bin_attrs[] = {
 
 static const struct attribute_group ds2780_sysfs_group = {
 	.attrs = ds2780_sysfs_attrs,
-	.bin_attrs = ds2780_sysfs_bin_attrs,
+	.bin_attrs_new = ds2780_sysfs_bin_attrs,
 };
 
 static const struct attribute_group *ds2780_sysfs_groups[] = {

-- 
2.47.1


