Return-Path: <linux-pm+bounces-8818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA65901350
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D91D1F219E9
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A8224F0;
	Sat,  8 Jun 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jFlddh0J"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A6208AD;
	Sat,  8 Jun 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717874389; cv=none; b=j0IWTYRKB4xGtS7Clf4dk6xhveYFEBuKxv6n96C8Fh9Ek8kbP3ChyPEWlmwHKCqBW4lkWZ3VNySXixKVaWGg+vmYIcrBe9bbsGvKwVmjSa4Bj+lDmtecPNFOthEgrfWja5lsF1aj8lqpWs0GwbRpWHlv+0yvwe90CYcfR2yEm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717874389; c=relaxed/simple;
	bh=vwWqc2ww6qRY4a64w7AUc9FhU7/PBgP1tS+sCDjXi0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5DZz5mF10/GxxThguhb6VwsOJUBNqCb3UcSIEny2rTuERNU2TTwZXfl9mfRZvBt56AcF9B62/X/a4r0/tYAN4OWBy/i7GVCIkc3/hcuZUFhaUYSyQws7FP5yIq8ZgbdzHd++WgbkwH6MP7MtwGbNZ0c1DKHLjFKKJwd8G0WEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jFlddh0J; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717874384;
	bh=vwWqc2ww6qRY4a64w7AUc9FhU7/PBgP1tS+sCDjXi0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jFlddh0JLs4oPRNL/lsCvgG7qsKCaBKaAahw6N1vzUVG+3fT6A7JqtNjycLkbdIPl
	 8p6YnKGi9XPbmDmp0TlKpuDG3MpgTcfShlwr0utjE8qpR+wMJD3TEEzf+YlY1rLSOK
	 cnSvOtrmJSbEwp4cY/1mD06igv64GmzuAcH17/B0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 21:19:38 +0200
Subject: [PATCH RFC v2 2/5] power: supply: core: avoid iterating properties
 directly
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-power-supply-extensions-v2-2-2dcd35b012ad@weissschuh.net>
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
In-Reply-To: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717874383; l=6729;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vwWqc2ww6qRY4a64w7AUc9FhU7/PBgP1tS+sCDjXi0Y=;
 b=VW14BqJ92RotFV1XpUMaqyibDQMNgk3LXFl+MYVNISu/4xNwQTsR6uHtkN4EJlKRecq07qenP
 TVShvXD2galDq7g3Fqv59+5I95hQnsw4Mb8I1XCWHXpzNEh45dIspMW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

With the introduction of power supply extension, it will not be enough
to iterate the properties on the struct power_supply directly.
Instead introduce a helper power_supply_has_property() which ill handle
properties added by extensions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       |  3 ++
 drivers/power/supply/power_supply_core.c  | 10 +++----
 drivers/power/supply/power_supply_hwmon.c | 48 +++++++++++++++----------------
 drivers/power/supply/power_supply_sysfs.c | 14 +++------
 4 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 3cbafc58bdad..622be1f0a180 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,6 +13,9 @@ struct device;
 struct device_type;
 struct power_supply;
 
+extern bool power_supply_has_property(const struct power_supply_desc *psy_desc,
+				      enum power_supply_property psp);
+
 #ifdef CONFIG_SYSFS
 
 extern void power_supply_init_attrs(void);
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fefe938c9342..d57ecdd966e0 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
+bool power_supply_has_property(const struct power_supply_desc *psy_desc,
+			       enum power_supply_property psp)
 {
 	bool found = false;
 	int i;
@@ -1209,7 +1209,7 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	if (psy_has_property(psy->desc, psp))
+	if (power_supply_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
@@ -1308,7 +1308,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+	if (power_supply_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
@@ -1361,7 +1361,7 @@ __power_supply_register(struct device *parent,
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
-	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
+	if (power_supply_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
 	    (!desc->usb_types || !desc->num_usb_types))
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index c97893d4c25e..2ecbe4a74c25 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -8,6 +8,8 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 
+#include "power_supply.h"
+
 struct power_supply_hwmon {
 	struct power_supply *psy;
 	unsigned long *props;
@@ -324,9 +326,26 @@ static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
 	.info = power_supply_hwmon_info,
 };
 
+static const enum power_supply_property power_supply_hwmon_props[] = {
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 {
-	const struct power_supply_desc *desc = psy->desc;
 	struct power_supply_hwmon *psyhw;
 	struct device *dev = &psy->dev;
 	struct device *hwmon;
@@ -352,30 +371,11 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		goto error;
 	}
 
-	for (i = 0; i < desc->num_properties; i++) {
-		const enum power_supply_property prop = desc->properties[i];
-
-		switch (prop) {
-		case POWER_SUPPLY_PROP_CURRENT_AVG:
-		case POWER_SUPPLY_PROP_CURRENT_MAX:
-		case POWER_SUPPLY_PROP_CURRENT_NOW:
-		case POWER_SUPPLY_PROP_TEMP:
-		case POWER_SUPPLY_PROP_TEMP_MAX:
-		case POWER_SUPPLY_PROP_TEMP_MIN:
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
-		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
-		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
-		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
-		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	for (i = 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
+		const enum power_supply_property prop = power_supply_hwmon_props[i];
+
+		if (power_supply_has_property(psy->desc, prop))
 			set_bit(prop, psyhw->props);
-			break;
-		default:
-			break;
-		}
 	}
 
 	name = psy->desc->name;
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 3e63d165b2f7..abd44ebfe6fe 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -367,7 +367,6 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = dev_get_drvdata(dev);
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
-	int i;
 
 	if (!power_supply_attrs[attrno].prop_name)
 		return 0;
@@ -375,15 +374,10 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	for (i = 0; i < psy->desc->num_properties; i++) {
-		int property = psy->desc->properties[i];
-
-		if (property == attrno) {
-			if (power_supply_property_is_writeable(psy, property) > 0)
-				mode |= S_IWUSR;
-
-			return mode;
-		}
+	if (power_supply_has_property(psy->desc, attrno)) {
+		if (power_supply_property_is_writeable(psy, attrno) > 0)
+			mode |= S_IWUSR;
+		return mode;
 	}
 
 	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))

-- 
2.45.2


