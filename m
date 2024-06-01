Return-Path: <linux-pm+bounces-8495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC868D7084
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 17:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3FB283148
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF815251D;
	Sat,  1 Jun 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JY4lvHhN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A31CD3D;
	Sat,  1 Jun 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254051; cv=none; b=uA7Mgs3E/QRH1eTbmYk4P3DaxhURz+DAEc+78iXBY4UX8lUF2bb6uMacLtkhavwANqm1LOYB8HUYKFxdp2XiIY2gAwWzvXHxwsqBAdNs3PfR5gklMs0LgI495xz1Cy5VYvsjPEyCFRglddHrXVLOVPfDiUMK1F8vLzTx5Bt+Ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254051; c=relaxed/simple;
	bh=cpDMvVIdLPhR5zy2zCBjOcNpO7WYB4YNI6UM9U7l+y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2Ob7mqzYX5IgcYMD2kVpQI4ikJleMWWAQSuWe1RX3N+WgJ2xgNVXNlLcICjo5G2ci06GazuoHyODbjb/0NVJ8ehpmEz7eA8+iSP3IRruNKfkNhXPCAoUpomoT8TOfk96iB7OF4uUIWp6ZmC0xNEglxPVHr7JMb2Ts5/O6NGrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JY4lvHhN; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id DQDisz5ua13tqDQDpsovaD; Sat, 01 Jun 2024 17:00:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717254041;
	bh=jIblfMwtliNUcxjvHa+qfP3YXi+49by7T+Qpw7+AkQ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JY4lvHhNoh9sABZn7VeIG7ThlFCIA1L1eh0wpizfGsh6Wb3qy6AXQLDMQeIsJ2NcD
	 zqQN1pSPj2TUPB7EeJUcF19B9FLSECKUyzSwhAtH0Yz8EO1ykp6qMWZkQEGrULQ0Ol
	 XsoImMCDv8Y9vmGbFsGAoMIYpBXkqiSbtspP1SjG1XscF9NISKcFMKBg6AzhgqLMrx
	 Y7GKXFbh4lCYd0OTUnrRykQwvhOyR9Yo11PJkfgULfnQJ4WpuIPYqZsH8vDGptOCio
	 VCw9/q/lo56y/VQ2fg6OhFyTTVkap57zEmUmmj8FC2RVL8HCpLco/N4IoTRR3Q/n7b
	 AoHi3+BBGaNEw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 Jun 2024 17:00:41 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: samsung-sdi-battery: Constify struct power_supply_maintenance_charge_table
Date: Sat,  1 Jun 2024 17:00:29 +0200
Message-ID: <02c6ad69a3ace192c9d609b7336a681a8fc7ba94.1717253900.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717253900.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717253900.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct power_supply_maintenance_charge_table' is not modified in this
driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, some code also needs to be adjusted to this new const
qualifier.

On a x86_64, with allmodconfig:
Before:
======
$ size drivers/power/supply/samsung-sdi-battery.o
   text	   data	    bss	    dec	    hex	filename
   4055	   4584	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-battery.o

After:
=====
$ size drivers/power/supply/samsung-sdi-battery.o
   text	   data	    bss	    dec	    hex	filename
   4087	   4552	      0	   8639	   21bf	drivers/power/supply/samsung-sdi-battery.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/power/supply/power_supply_core.c   | 2 +-
 drivers/power/supply/samsung-sdi-battery.c | 2 +-
 include/linux/power_supply.h               | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 022d0e4bf621..8f6025acd10a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1072,7 +1072,7 @@ int power_supply_vbat2ri(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_vbat2ri);
 
-struct power_supply_maintenance_charge_table *
+const struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info,
 					      int index)
 {
diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index 725fbe09379e..b63fd2758c2f 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -613,7 +613,7 @@ static struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157lu[] = {
 	{ .ocv = 3300000, .capacity = 0},
 };
 
-static struct power_supply_maintenance_charge_table samsung_maint_charge_table[] = {
+static const struct power_supply_maintenance_charge_table samsung_maint_charge_table[] = {
 	{
 		/* Maintenance charging phase A, 60 hours */
 		.charge_current_max_ua = 600000,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3ccf7d47f502..6f983720c146 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -741,7 +741,7 @@ struct power_supply_battery_info {
 	int overvoltage_limit_uv;
 	int constant_charge_current_max_ua;
 	int constant_charge_voltage_max_uv;
-	struct power_supply_maintenance_charge_table *maintenance_charge;
+	const struct power_supply_maintenance_charge_table *maintenance_charge;
 	int maintenance_charge_size;
 	int alert_low_temp_charge_current_ua;
 	int alert_low_temp_charge_voltage_uv;
@@ -815,7 +815,7 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern int power_supply_vbat2ri(struct power_supply_battery_info *info,
 				int vbat_uv, bool charging);
-extern struct power_supply_maintenance_charge_table *
+extern const struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
 extern bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 					      int resistance);
@@ -829,7 +829,7 @@ extern int power_supply_set_battery_charged(struct power_supply *psy);
 static inline bool
 power_supply_supports_maintenance_charging(struct power_supply_battery_info *info)
 {
-	struct power_supply_maintenance_charge_table *mt;
+	const struct power_supply_maintenance_charge_table *mt;
 
 	mt = power_supply_get_maintenance_charging_setting(info, 0);
 
-- 
2.45.1


