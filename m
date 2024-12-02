Return-Path: <linux-pm+bounces-18372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A39E0D50
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB71B66559
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F91DE4C4;
	Mon,  2 Dec 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WWDfbsFE"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082681DE3D6;
	Mon,  2 Dec 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166142; cv=none; b=oWkGknCaLR+rxaI7bQfI7OYpO7Gmxop8HvCzIfVUvQr6BD+UwlVwHVE6kN0RVL7nOXrNZsfU7BjumGLitCmv2YnXyvvVh5scs6A8gfoU9WiSf9A4XMIijdEh9WECcAc1yQGe83Yj0f6q4QglB2DFeLXjUaTXCAEvDpwUsfcpGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166142; c=relaxed/simple;
	bh=A/SStIoFKy8kbXNZOyVWGy/f5MASnx/GCLKsixaNTdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MU69b38tNgFE22p7XRZ6x86IqEwhjAW2QXiAwkOGHDLqWRvmlQKaEK9bTFkIDboAdMoqmdNpo/ZQelXugwR3HRY5jINzwLn09ruJ/mqWTfCLFvgCh8UV+RW5DeDLOxHiCv972lBEA2iQ/tC750Jauq7UZma5uYczgSJMEnhyK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WWDfbsFE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166139;
	bh=A/SStIoFKy8kbXNZOyVWGy/f5MASnx/GCLKsixaNTdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WWDfbsFECbI5pH2MbvT8xeRBe7ZXOgSN9Q+EMIv464oqwsMZLyZ3JAXHyq2qlbIj1
	 sG2RBqiaow0zHSGHvEIuKWr5b7gKmEvcj1CqHQtyGpcQXaQM02i3b7AWY+RItOIDhm
	 z8MSZDTIU/QK2wun8gQfSjzsi7a5f4iKzXU6mZIw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:22 +0100
Subject: [PATCH 4/4] power: supply: olpc_battery: constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-psy-v1-4-f846430b8b66@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166139; l=2026;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=A/SStIoFKy8kbXNZOyVWGy/f5MASnx/GCLKsixaNTdk=;
 b=FxrGRdi3lo6HqtQ+teIFEkVolU18SzAS9SKr08rAliQyG1mmV84tBdGLhCdtxwdOknZ3hu0BU
 /jd8ttqcCmFBxOg+V7nHbNOv/vgA45DPv/YUSJ/BxSVw3TTf+6Gg3ir
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/olpc_battery.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 9f60094a5599edd995588b2a7c3d753aaf8dd6ec..849f63e89ba09047bba30813723512780b9cdeb0 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -527,7 +527,7 @@ static enum power_supply_property olpc_xo15_bat_props[] = {
 #define EEPROM_SIZE	(EEPROM_END - EEPROM_START)
 
 static ssize_t olpc_bat_eeprom_read(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+		const struct bin_attribute *attr, char *buf, loff_t off, size_t count)
 {
 	uint8_t ec_byte;
 	int ret;
@@ -547,13 +547,13 @@ static ssize_t olpc_bat_eeprom_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute olpc_bat_eeprom = {
+static const struct bin_attribute olpc_bat_eeprom = {
 	.attr = {
 		.name = "eeprom",
 		.mode = S_IRUGO,
 	},
 	.size = EEPROM_SIZE,
-	.read = olpc_bat_eeprom_read,
+	.read_new = olpc_bat_eeprom_read,
 };
 
 /* Allow userspace to see the specific error value pulled from the EC */
@@ -584,15 +584,14 @@ static struct attribute *olpc_bat_sysfs_attrs[] = {
 	NULL
 };
 
-static struct bin_attribute *olpc_bat_sysfs_bin_attrs[] = {
+static const struct bin_attribute *const olpc_bat_sysfs_bin_attrs[] = {
 	&olpc_bat_eeprom,
 	NULL
 };
 
 static const struct attribute_group olpc_bat_sysfs_group = {
 	.attrs = olpc_bat_sysfs_attrs,
-	.bin_attrs = olpc_bat_sysfs_bin_attrs,
-
+	.bin_attrs_new = olpc_bat_sysfs_bin_attrs,
 };
 
 static const struct attribute_group *olpc_bat_sysfs_groups[] = {

-- 
2.47.1


