Return-Path: <linux-pm+bounces-18375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7459E0B97
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F225280C93
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2F1DED60;
	Mon,  2 Dec 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pMhTNwMG"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10F1DE3CF;
	Mon,  2 Dec 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166143; cv=none; b=CUSqxfTE8+wmEEs0L0SlXz9ETA2taId6SGYEXj9ZkGCgWTPo3tB+IQ6Focpr2eXfO71/HuhYoDM5Q+tiAvXIgraZ0e/Q472v9uqPOryvim1ed+C6A4hi9M1f/HsX7HalLYxNLvU/S460cd4Pe8oIzQ3D74fJ81YDCkfni0AV9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166143; c=relaxed/simple;
	bh=jOCpitkzzO0ZkQxM2OTYcCXJhJbSo/7hpe8pbEOUS/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFsRP7nfv1tJuByuU6+ggpvathbEiQySPez7F17U7Yw0Z40+kcB4qv9pkQ6zUch/r0D9eSMsJQyRgjgzrbHVhpDweS9/eDLQaSPL649cX2d6NRxXSBRtI1R48JK8MZTzqyMbYa/SHNjfMrT07sHm5YgNdx2jZIbOJ6c+JkNTwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pMhTNwMG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166139;
	bh=jOCpitkzzO0ZkQxM2OTYcCXJhJbSo/7hpe8pbEOUS/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMhTNwMGcd/ilN99rbUEdZ1GFfY85DqAFIkt4KTUDTD10e4n7QUuY7FPvI3T0lfMC
	 SIl23eX5IuMsSepuRVX/hl/dJSUoE8xE+VtcRJsQEzLA5+0PmsFQMbzpn+x0fc7X3r
	 k5QrHnbU5q0YQ6OcszrLGJRi7fmjUpHGoMURb/3s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:21 +0100
Subject: [PATCH 3/4] power: supply: ds2781: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-psy-v1-3-f846430b8b66@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166139; l=3692;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jOCpitkzzO0ZkQxM2OTYcCXJhJbSo/7hpe8pbEOUS/c=;
 b=Vc8hxHsAvqJhhRvrlBH1eS0fbtbZdUrId1HlnxcERzGIYwnb8lWlDfpU380pSVO/G+fbvvott
 TXaFyfrPknDDcpar24fr7+w5s3AJOujWtX+DBbO+zSUacF8KMaLenJD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ds2781_battery.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index c4f8ccc687f919f58c85bae83d308b83297fc074..8a1f1f9835e09598dd9f9426e0b63a0c5a3b4cc1 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -623,7 +623,7 @@ static ssize_t ds2781_set_pio_pin(struct device *dev,
 
 static ssize_t ds2781_read_param_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -636,7 +636,7 @@ static ssize_t ds2781_read_param_eeprom_bin(struct file *filp,
 
 static ssize_t ds2781_write_param_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -656,19 +656,19 @@ static ssize_t ds2781_write_param_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2781_param_eeprom_bin_attr = {
+static const struct bin_attribute ds2781_param_eeprom_bin_attr = {
 	.attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
 	},
 	.size = DS2781_PARAM_EEPROM_SIZE,
-	.read = ds2781_read_param_eeprom_bin,
-	.write = ds2781_write_param_eeprom_bin,
+	.read_new = ds2781_read_param_eeprom_bin,
+	.write_new = ds2781_write_param_eeprom_bin,
 };
 
 static ssize_t ds2781_read_user_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -682,7 +682,7 @@ static ssize_t ds2781_read_user_eeprom_bin(struct file *filp,
 
 static ssize_t ds2781_write_user_eeprom_bin(struct file *filp,
 				struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -702,14 +702,14 @@ static ssize_t ds2781_write_user_eeprom_bin(struct file *filp,
 	return count;
 }
 
-static struct bin_attribute ds2781_user_eeprom_bin_attr = {
+static const struct bin_attribute ds2781_user_eeprom_bin_attr = {
 	.attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
 	},
 	.size = DS2781_USER_EEPROM_SIZE,
-	.read = ds2781_read_user_eeprom_bin,
-	.write = ds2781_write_user_eeprom_bin,
+	.read_new = ds2781_read_user_eeprom_bin,
+	.write_new = ds2781_write_user_eeprom_bin,
 };
 
 static DEVICE_ATTR(pmod_enabled, S_IRUGO | S_IWUSR, ds2781_get_pmod_enabled,
@@ -729,7 +729,7 @@ static struct attribute *ds2781_sysfs_attrs[] = {
 	NULL
 };
 
-static struct bin_attribute *ds2781_sysfs_bin_attrs[] = {
+static const struct bin_attribute *const ds2781_sysfs_bin_attrs[] = {
 	&ds2781_param_eeprom_bin_attr,
 	&ds2781_user_eeprom_bin_attr,
 	NULL,
@@ -737,7 +737,7 @@ static struct bin_attribute *ds2781_sysfs_bin_attrs[] = {
 
 static const struct attribute_group ds2781_sysfs_group = {
 	.attrs = ds2781_sysfs_attrs,
-	.bin_attrs = ds2781_sysfs_bin_attrs,
+	.bin_attrs_new = ds2781_sysfs_bin_attrs,
 
 };
 

-- 
2.47.1


