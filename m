Return-Path: <linux-pm+bounces-8723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FC8FF0C4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CDFB2D700
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F11A2FA0;
	Thu,  6 Jun 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eovFnlwp"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9A1A2550;
	Thu,  6 Jun 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685470; cv=none; b=I3GWlLNiOJjjsIgC4QGDZLsIgFTBHjUEP2KcNkuD5M/RvOeJtltZO7EZUd5/PhpCqcPHg6SeoMDiR2yHdeJ+D2+Ug945EaoHWFrgCOk849ucI4qxHXA48V3rXex6AdZYFfp1AHHQujeHuyTppX99T7wftvgHimgUPzbFV8+4gMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685470; c=relaxed/simple;
	bh=AWI2uk7badd/hUC4297caKc5NtjQlqqUKCxfXKFVIU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxRDglt9ebC5xkCAO7Ljj4If5ZCSgDRkJfo8ke25Nko6pmudTkN3/m1KhgmYHdm2ercu4xKon3O0qoJTlVtOTqQpBs8mPmxed4HhSsC5xpOwJTBvoqN/CX8yGCSq6YZwlssCmDaTZ6fM2+jlheJw2HKDO24wMQnDwaDGZ8beyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eovFnlwp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717685463;
	bh=AWI2uk7badd/hUC4297caKc5NtjQlqqUKCxfXKFVIU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eovFnlwpvI6uwrpTB8a2qkDcxOr0KglMSmQoXNoMme3dNdamlwCsKIrGzU0EKA3Ms
	 gPWuTWXJWXYATI/dSetER3HkxbANlCrbv5mWli2txy+6rMgco0mfBW79e683GLFZN+
	 HfUKiO53BmhR9D14vWihNXdUULLEq00AzXTX9PSw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Jun 2024 16:50:58 +0200
Subject: [PATCH RFC 4/6] power: supply: core: add locking around extension
 access
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-power-supply-extensions-v1-4-b45669290bdc@weissschuh.net>
References: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
In-Reply-To: <20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Jeremy Soller <jeremy@system76.com>, 
 System76 Product Development <productdev@system76.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717685463; l=8061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AWI2uk7badd/hUC4297caKc5NtjQlqqUKCxfXKFVIU8=;
 b=II7dmk6ur4eLxXY6hNllwIAjb77cbZIJkV0I0YZAC9hBQ9d+uPQcXMuNagnqJ+Ht8Y2aSN7JM
 KreRqpzlw1zDRK6npalNgY50gDr+4cBB0w2oar49k9cBfyqwx/rJcmW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       |  6 ++-
 drivers/power/supply/power_supply_core.c  | 65 +++++++++++++++++++++++++------
 drivers/power/supply/power_supply_sysfs.c | 22 ++++++-----
 include/linux/power_supply.h              |  2 +
 4 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 7f9e139064cc..b469a9719045 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,10 +13,14 @@ struct device;
 struct device_type;
 struct power_supply;
 
-bool power_supply_has_property(const struct power_supply *psy,
+bool power_supply_has_property(struct power_supply *psy,
 			       enum power_supply_property psp);
+bool power_supply_has_property_nolock(struct power_supply *psy,
+				      enum power_supply_property psp);
 bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
 				   enum power_supply_property psp);
+int power_supply_property_is_writeable_nolock(struct power_supply *psy,
+					      enum power_supply_property psp);
 
 #ifdef CONFIG_SYSFS
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index b32bbca9a848..ded9748be550 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1218,14 +1218,26 @@ bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
 	return found;
 }
 
-bool power_supply_has_property(const struct power_supply *psy,
-			       enum power_supply_property psp)
+bool power_supply_has_property_nolock(struct power_supply *psy,
+				      enum power_supply_property psp)
 {
+	lockdep_assert_held(&psy->ext_lock);
+
 	if (power_supply_ext_has_property(psy->ext, psp))
 		return true;
 	return psy_desc_has_property(psy->desc, psp);
 }
 
+bool power_supply_has_property(struct power_supply *psy,
+			       enum power_supply_property psp)
+{
+	scoped_guard(rwsem_read, &psy->ext_lock) {
+		if (power_supply_ext_has_property(psy->ext, psp))
+			return true;
+	}
+	return psy_desc_has_property(psy->desc, psp);
+}
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
@@ -1236,9 +1248,12 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	if (power_supply_ext_has_property(psy->ext, psp))
-		return psy->ext->get_property(psy, psp, val);
-	else if (psy_desc_has_property(psy->desc, psp))
+	scoped_guard(rwsem_read, &psy->ext_lock) {
+		if (power_supply_ext_has_property(psy->ext, psp))
+			return psy->ext->get_property(psy, psp, val);
+	}
+
+	if (psy_desc_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
@@ -1254,11 +1269,13 @@ int power_supply_set_property(struct power_supply *psy,
 	if (atomic_read(&psy->use_cnt) <= 0)
 		return -ENODEV;
 
-	if (power_supply_ext_has_property(psy->ext, psp)) {
-		if (psy->ext->set_property)
-			return psy->ext->set_property(psy, psp, val);
-		else
-			return -ENODEV;
+	scoped_guard(rwsem_read, &psy->ext_lock) {
+		if (power_supply_ext_has_property(psy->ext, psp)) {
+			if (psy->ext->set_property)
+				return psy->ext->set_property(psy, psp, val);
+			else
+				return -ENODEV;
+		}
 	}
 
 	if (!psy->desc->set_property)
@@ -1274,6 +1291,28 @@ int power_supply_property_is_writeable(struct power_supply *psy,
 	if (atomic_read(&psy->use_cnt) <= 0)
 		return -ENODEV;
 
+	scoped_guard(rwsem_read, &psy->ext_lock) {
+		if (power_supply_ext_has_property(psy->ext, psp)) {
+			if (psy->ext->property_is_writeable)
+				return psy->ext->property_is_writeable(psy, psp);
+			else
+				return -ENODEV;
+		}
+	}
+
+	if (!psy->desc->property_is_writeable)
+		return -ENODEV;
+
+	return psy->desc->property_is_writeable(psy, psp);
+}
+EXPORT_SYMBOL_GPL(power_supply_property_is_writeable);
+
+int power_supply_property_is_writeable_nolock(struct power_supply *psy,
+					      enum power_supply_property psp)
+{
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
 	if (power_supply_ext_has_property(psy->ext, psp)) {
 		if (psy->ext->property_is_writeable)
 			return psy->ext->property_is_writeable(psy, psp);
@@ -1286,7 +1325,6 @@ int power_supply_property_is_writeable(struct power_supply *psy,
 
 	return psy->desc->property_is_writeable(psy, psp);
 }
-EXPORT_SYMBOL_GPL(power_supply_property_is_writeable);
 
 void power_supply_external_power_changed(struct power_supply *psy)
 {
@@ -1315,6 +1353,8 @@ static int power_supply_update_groups(struct power_supply *psy)
 
 int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext)
 {
+	guard(rwsem_write)(&psy->ext_lock);
+
 	if (psy->ext)
 		return -EEXIST;
 
@@ -1325,6 +1365,8 @@ EXPORT_SYMBOL_GPL(power_supply_register_extension);
 
 void power_supply_unregister_extension(struct power_supply *psy, const struct power_supply_ext *ext)
 {
+	guard(rwsem_write)(&psy->ext_lock);
+
 	if (psy->ext != ext)
 		dev_warn(&psy->dev, "Trying to unregister invalid extension");
 
@@ -1492,6 +1534,7 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	init_rwsem(&psy->ext_lock);
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 3487f161e9bf..d47804cbb500 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -378,8 +378,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	if (power_supply_has_property(psy, attrno)) {
-		if (power_supply_property_is_writeable(psy, attrno) > 0)
+	if (power_supply_has_property_nolock(psy, attrno)) {
+		if (power_supply_property_is_writeable_nolock(psy, attrno) > 0)
 			mode |= S_IWUSR;
 		return mode;
 	}
@@ -458,7 +458,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
 
 int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	const struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_get_drvdata(dev);
 	const enum power_supply_property *battery_props =
 		power_supply_battery_info_properties;
 	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
@@ -490,13 +490,15 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (ret)
 		goto out;
 
-	if (psy->ext) {
-		for (j = 0; j < psy->ext->num_properties; j++) {
-			set_bit(psy->ext->properties[j], psy_drv_properties);
-			ret = add_prop_uevent(dev, env, psy->ext->properties[j],
-					      prop_buf);
-			if (ret)
-				goto out;
+	scoped_guard(rwsem_read, &psy->ext_lock) {
+		if (psy->ext) {
+			for (j = 0; j < psy->ext->num_properties; j++) {
+				set_bit(psy->ext->properties[j], psy_drv_properties);
+				ret = add_prop_uevent(dev, env, psy->ext->properties[j],
+						      prop_buf);
+				if (ret)
+					goto out;
+			}
 		}
 	}
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0c1e23081d2a..6bba7e6ab161 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/leds.h>
+#include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 
@@ -306,6 +307,7 @@ struct power_supply {
 	size_t num_supplies;
 	struct device_node *of_node;
 
+	struct rw_semaphore ext_lock;
 	const struct power_supply_ext *ext;
 
 	/* Driver private data */

-- 
2.45.2


