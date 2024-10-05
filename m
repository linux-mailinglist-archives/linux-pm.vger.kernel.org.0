Return-Path: <linux-pm+bounces-15191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1689915B1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9871F232FF
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5414B942;
	Sat,  5 Oct 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OwaAcMQf"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD161369BC;
	Sat,  5 Oct 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122690; cv=none; b=rWBPgK4Isu1yOtxDb0u9zV1pnFIQ2Oh5KjxRCVgvCzZwgM41uJctcxSJ1n5NxlgqWAAI5I4sY/FITxtn9BgwzgiL48tiIPXBi+dsFhPsYEd32Z++ZQ0s8v2ow7NE6yiTFS2iPuclZkmqgyvHLFR3DbGjZ8erLec+EvRwTV8bNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122690; c=relaxed/simple;
	bh=vnWYEzhPiz5A5M5J8q/Fl3cT74nVDkwiVz6Uf8mnxDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiOvlTqrDjEFhf/5DkXPR09p2M1OCFB8/BJmMhDzW1jOyU6lM+Qg5d4xz3MJ/V57MuPfBap/FAazhRGCEufn/4MJbYOejbVJii+AUfUm0UqNtSa8oxErnSnSq9AzmmMemsomhq5I4bMDN8AkISAvCn/1VQLVk+a8Zsix89u0qOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OwaAcMQf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122684;
	bh=vnWYEzhPiz5A5M5J8q/Fl3cT74nVDkwiVz6Uf8mnxDk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OwaAcMQfqzTsGFw1+nfHdyHe7S+/qH/mDV/1/UjFYFxDlA4kP91+z+3jPhS+lFuZk
	 LO8j2APotgwrGSoQQXkTVljybvC9l1mxtCGdsNyADwe6iDHBa3011rSXv60RMo89xr
	 6fJ3RG4J4wR4PEBJBrqlWdvJPxxJ9jNtK3an1fys=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:04:21 +0200
Subject: [PATCH 5/7] power: supply: core: constify
 power_supply_battery_info::ocv_table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-battery-const-v1-5-c1f721927048@weissschuh.net>
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122683; l=3599;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vnWYEzhPiz5A5M5J8q/Fl3cT74nVDkwiVz6Uf8mnxDk=;
 b=fNUGfthWMCXploCkKZ9eALkkhKRYRvUbIQAh97b9aWHPKvGzOkYV+TzQnIVUXuXXFl5nUFu1q
 TfbPz9gAdr2CmXT4aF2lXgZBdl/rpQbb2LrupRjOK1inzTfOjN/hs9K
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The power supply core never modifies the ocv table.
Reflect this in the API, so drivers can mark their static tables as
const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 8 ++++----
 include/linux/power_supply.h             | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a01703fa83c0d90ec630782e67aa3c2c406d51dd..5aefba2ddcda12a9f24d096fa361aa8e4ce1a681 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -777,7 +777,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		tab_len = size / (2 * sizeof(__be32));
 		info->ocv_table_size[index] = tab_len;
 
-		table = info->ocv_table[index] =
+		info->ocv_table[index] = table =
 			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
 			power_supply_put_battery_info(psy, info);
@@ -1093,7 +1093,7 @@ EXPORT_SYMBOL_GPL(power_supply_get_maintenance_charging_setting);
  *
  * Return: the battery capacity.
  */
-int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
+int power_supply_ocv2cap_simple(const struct power_supply_battery_ocv_table *table,
 				int table_len, int ocv)
 {
 	int i, high, low;
@@ -1118,7 +1118,7 @@ int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
 }
 EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
 
-struct power_supply_battery_ocv_table *
+const struct power_supply_battery_ocv_table *
 power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 				int temp, int *table_len)
 {
@@ -1149,7 +1149,7 @@ EXPORT_SYMBOL_GPL(power_supply_find_ocv2cap_table);
 int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 				 int ocv, int temp)
 {
-	struct power_supply_battery_ocv_table *table;
+	const struct power_supply_battery_ocv_table *table;
 	int table_len;
 
 	table = power_supply_find_ocv2cap_table(info, temp, &table_len);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9253411c105f27177181f9b0a84285a7b24bc954..4e29ec39c18f26f3e15343e198f74e8a96613e92 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -750,7 +750,7 @@ struct power_supply_battery_info {
 	int temp_alert_max;
 	int temp_min;
 	int temp_max;
-	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
+	const struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	const struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
@@ -797,9 +797,9 @@ extern bool power_supply_battery_info_has_prop(struct power_supply_battery_info
 extern int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,
 					      enum power_supply_property psp,
 					      union power_supply_propval *val);
-extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
+extern int power_supply_ocv2cap_simple(const struct power_supply_battery_ocv_table *table,
 				       int table_len, int ocv);
-extern struct power_supply_battery_ocv_table *
+extern const struct power_supply_battery_ocv_table *
 power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 				int temp, int *table_len);
 extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,

-- 
2.46.2


