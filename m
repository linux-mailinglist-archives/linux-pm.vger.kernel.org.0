Return-Path: <linux-pm+bounces-8817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B0901351
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF2B21596
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A52206E;
	Sat,  8 Jun 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s6cWR5aB"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E3208B8;
	Sat,  8 Jun 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717874389; cv=none; b=tKjK/Jm+VaP9td1OfoaCoIEwLvT5S/uafWSAUkfuHMCjhzaKauuDousPbtoRRMYl8Y240rkWoyj4nKylp3hLDtq5ktUP3+O80KzGW7sda1ZZQXPVFPTr03aMbYBZBulX8TMO1WMSVnpjR8zxQ+q5zqVD1RnsBztGtE5RdVU/T2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717874389; c=relaxed/simple;
	bh=I7LfGy38sJYS8irEYNLCYbak30d/ylA0HUIKIO46Oxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4PyjqYbtu/0Q8fxs5P8acmrpp1TuE0JhAAScW+o4JPc+/B3F2oR/CscITbjB/+Xdg4IB9Cx+/qsBCG7fDd9y5A5NtS+hoRTmsinIoN+M7mk/lJd8/H3xO6FJlSPnF9aYQUnIpXCqUEZJichfLEbDcOG3DSTd2/0IahlQZIepSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s6cWR5aB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717874384;
	bh=I7LfGy38sJYS8irEYNLCYbak30d/ylA0HUIKIO46Oxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s6cWR5aBt7m2YEYhayqqYNSiPy0i9wL2IOWKri9QPZ9ITAVaii+n5nQGcneLXviMR
	 YoOMVC4SGrY9DfeYDtposWe1ttZmSIiF54VEFs1vg3P/1MYccWeFsw7FyqxvZjf0I8
	 6UhaFfyiuq4Yhp7QAvAllKpFB2fB75i4geaLUz1M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 21:19:39 +0200
Subject: [PATCH RFC v2 3/5] power: supply: core: implement extension API
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-power-supply-extensions-v2-3-2dcd35b012ad@weissschuh.net>
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
In-Reply-To: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717874383; l=13126;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=I7LfGy38sJYS8irEYNLCYbak30d/ylA0HUIKIO46Oxc=;
 b=m9H1Ium6YdtLnzoPsRSgCse+HI8g4d8z0bDdRoJEnmvFgASNKiyCa7r5ugUP8yvF7haZ7ruIT
 w+HHAsT50vRD50bD9J78b2HFs3fyxpuFbUeJYO7JZl7AyvVFeLRAYyV
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       |  13 ++-
 drivers/power/supply/power_supply_core.c  | 128 ++++++++++++++++++++++++++++--
 drivers/power/supply/power_supply_hwmon.c |   2 +-
 drivers/power/supply/power_supply_sysfs.c |  37 ++++++++-
 include/linux/power_supply.h              |  26 ++++++
 5 files changed, 192 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 622be1f0a180..686b66161900 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,8 +13,17 @@ struct device;
 struct device_type;
 struct power_supply;
 
-extern bool power_supply_has_property(const struct power_supply_desc *psy_desc,
-				      enum power_supply_property psp);
+struct psy_ext_registration {
+	struct list_head list_head;
+	const struct power_supply_ext *ext;
+};
+
+#define psy_for_each_extension(psy, pos) list_for_each_entry(pos, &(psy)->extensions, list_head)
+
+bool power_supply_has_property(const struct power_supply *psy,
+			       enum power_supply_property psp);
+bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
+				   enum power_supply_property psp);
 
 #ifdef CONFIG_SYSFS
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d57ecdd966e0..fcdfedf3df7c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
 
-bool power_supply_has_property(const struct power_supply_desc *psy_desc,
-			       enum power_supply_property psp)
+static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
+				  enum power_supply_property psp)
 {
 	bool found = false;
 	int i;
@@ -1199,17 +1199,55 @@ bool power_supply_has_property(const struct power_supply_desc *psy_desc,
 	return found;
 }
 
+bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
+				   enum power_supply_property psp)
+{
+	bool found = false;
+	int i;
+
+	if (!psy_ext)
+		return false;
+
+	for (i = 0; i < psy_ext->num_properties; i++) {
+		if (psy_ext->properties[i] == psp) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
+bool power_supply_has_property(const struct power_supply *psy,
+			       enum power_supply_property psp)
+{
+	struct psy_ext_registration *reg;
+
+	psy_for_each_extension(psy, reg)
+		if (power_supply_ext_has_property(reg->ext, psp))
+			return true;
+
+	return psy_desc_has_property(psy->desc, psp);
+}
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
+	struct psy_ext_registration *reg;
+
 	if (atomic_read(&psy->use_cnt) <= 0) {
 		if (!psy->initialized)
 			return -EAGAIN;
 		return -ENODEV;
 	}
 
-	if (power_supply_has_property(psy->desc, psp))
+	psy_for_each_extension(psy, reg) {
+		if (power_supply_ext_has_property(reg->ext, psp))
+			return reg->ext->get_property(psy, reg->ext, psp, val);
+	}
+
+	if (psy_desc_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
@@ -1222,7 +1260,21 @@ int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 || !psy->desc->set_property)
+	struct psy_ext_registration *reg;
+
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	psy_for_each_extension(psy, reg) {
+		if (power_supply_ext_has_property(reg->ext, psp)) {
+			if (reg->ext->set_property)
+				return reg->ext->set_property(psy, reg->ext, psp, val);
+			else
+				return -ENODEV;
+		}
+	}
+
+	if (!psy->desc->set_property)
 		return -ENODEV;
 
 	return psy->desc->set_property(psy, psp, val);
@@ -1232,8 +1284,21 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
 int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 ||
-			!psy->desc->property_is_writeable)
+	struct psy_ext_registration *reg;
+
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	psy_for_each_extension(psy, reg) {
+		if (power_supply_ext_has_property(reg->ext, psp)) {
+			if (reg->ext->property_is_writeable)
+				return reg->ext->property_is_writeable(psy, reg->ext, psp);
+			else
+				return -ENODEV;
+		}
+	}
+
+	if (!psy->desc->property_is_writeable)
 		return -ENODEV;
 
 	return psy->desc->property_is_writeable(psy, psp);
@@ -1256,6 +1321,52 @@ int power_supply_powers(struct power_supply *psy, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(power_supply_powers);
 
+static int power_supply_update_groups(struct power_supply *psy)
+{
+	int ret;
+
+	ret = sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.groups);
+	power_supply_changed(psy);
+	return ret;
+}
+
+int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext)
+{
+	struct psy_ext_registration *reg;
+	size_t i;
+
+	for (i = 0; i < ext->num_properties; i++) {
+		if (power_supply_has_property(psy, ext->properties[i]))
+			return -EEXIST;
+	}
+
+	reg = devm_kmalloc(&psy->dev, sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	reg->ext = ext;
+	list_add(&reg->list_head, &psy->extensions);
+
+	return power_supply_update_groups(psy);
+}
+EXPORT_SYMBOL_GPL(power_supply_register_extension);
+
+void power_supply_unregister_extension(struct power_supply *psy, const struct power_supply_ext *ext)
+{
+	struct psy_ext_registration *reg;
+
+	psy_for_each_extension(psy, reg) {
+		if (reg->ext == ext) {
+			list_del(&reg->list_head);
+			power_supply_update_groups(psy);
+			return;
+		}
+	}
+
+	dev_warn(&psy->dev, "Trying to unregister invalid extension");
+}
+EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
+
 static void power_supply_dev_release(struct device *dev)
 {
 	struct power_supply *psy = to_power_supply(dev);
@@ -1308,7 +1419,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (power_supply_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
@@ -1361,7 +1472,7 @@ __power_supply_register(struct device *parent,
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
-	if (power_supply_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
+	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
 	    (!desc->usb_types || !desc->num_usb_types))
 		return ERR_PTR(-EINVAL);
 
@@ -1415,6 +1526,7 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	INIT_LIST_HEAD(&psy->extensions);
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 2ecbe4a74c25..8cb852a734b1 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -374,7 +374,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 	for (i = 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
 		const enum power_supply_property prop = power_supply_hwmon_props[i];
 
-		if (power_supply_has_property(psy->desc, prop))
+		if (power_supply_has_property(psy, prop))
 			set_bit(prop, psyhw->props);
 	}
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index abd44ebfe6fe..8f29ddea08d0 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 	return count;
 }
 
+static ssize_t power_supply_show_charge_behaviour(struct device *dev,
+						  struct power_supply *psy,
+						  union power_supply_propval *value,
+						  char *buf)
+{
+	struct psy_ext_registration *reg;
+
+	psy_for_each_extension(psy, reg) {
+		if (power_supply_ext_has_property(reg->ext, POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR))
+			return power_supply_charge_behaviour_show(dev, reg->ext->charge_behaviours,
+								  value->intval, buf);
+	}
+
+	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
+						  value->intval, buf);
+}
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -304,8 +321,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
-		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
-							 value.intval, buf);
+		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
@@ -374,7 +390,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	if (power_supply_has_property(psy->desc, attrno)) {
+	if (power_supply_has_property(psy, attrno)) {
 		if (power_supply_property_is_writeable(psy, attrno) > 0)
 			mode |= S_IWUSR;
 		return mode;
@@ -459,6 +475,7 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 		power_supply_battery_info_properties;
 	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
 					 sizeof(unsigned long) + 1] = {0};
+	struct psy_ext_registration *ext;
 	int ret = 0, j;
 	char *prop_buf;
 
@@ -486,7 +503,21 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (ret)
 		goto out;
 
+	psy_for_each_extension(psy, ext) {
+		for (j = 0; j < ext->ext->num_properties; j++) {
+			if (test_bit(ext->ext->properties[j], psy_drv_properties))
+				continue;
+			set_bit(ext->ext->properties[j], psy_drv_properties);
+			ret = add_prop_uevent(dev, env, ext->ext->properties[j],
+					      prop_buf);
+			if (ret)
+				goto out;
+		}
+	}
+
 	for (j = 0; j < psy->desc->num_properties; j++) {
+		if (test_bit(psy->desc->properties[j], psy_drv_properties))
+			continue;
 		set_bit(psy->desc->properties[j], psy_drv_properties);
 		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
 				      prop_buf);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8e5705a56b85..128e7a67f268 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/leds.h>
+#include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 
@@ -280,6 +281,25 @@ struct power_supply_desc {
 	int use_for_apm;
 };
 
+struct power_supply_ext {
+	u8 charge_behaviours;
+	const enum power_supply_property *properties;
+	size_t num_properties;
+
+	int (*get_property)(struct power_supply *psy,
+			    const struct power_supply_ext *ext,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val);
+	int (*set_property)(struct power_supply *psy,
+			    const struct power_supply_ext *ext,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val);
+
+	int (*property_is_writeable)(struct power_supply *psy,
+				     const struct power_supply_ext *ext,
+				     enum power_supply_property psp);
+};
+
 struct power_supply {
 	const struct power_supply_desc *desc;
 
@@ -303,6 +323,7 @@ struct power_supply {
 	bool removing;
 	atomic_t use_cnt;
 	struct power_supply_battery_info *battery_info;
+	struct list_head extensions;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
 	struct thermal_cooling_device *tcd;
@@ -892,6 +913,11 @@ devm_power_supply_register_no_ws(struct device *parent,
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
+extern int power_supply_register_extension(struct power_supply *psy,
+					   const struct power_supply_ext *ext);
+extern void power_supply_unregister_extension(struct power_supply *psy,
+					      const struct power_supply_ext *ext);
+
 #define to_power_supply(device) container_of(device, struct power_supply, dev)
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);

-- 
2.45.2


