Return-Path: <linux-pm+bounces-8721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CA88FF01E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DCB28A877
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA91A2573;
	Thu,  6 Jun 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZC/+0ufS"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FB1A254C;
	Thu,  6 Jun 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685468; cv=none; b=C1PdPnttPuUsGaeM2BJ/gmJtXTFO3YnxpbF5LXtw9iC0BRCu39hg1QPMa88MLCSetnb3J50hT8I1ZTKTdcP2+gbBu17BykoN5nSuMisv5B+SCiM4sZdYmv0qUCNEhl9prNkQvI34votN6qSnQRdtR7o4akcosH6H/L/MGI5W6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685468; c=relaxed/simple;
	bh=/m4iyYTbnF7Xxg6MP0Zi26UwXuOjb4EQbmnW0m/H6qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpPA12IpVtQgDK7ZcgCetROByxpmNtQ9bKhkqk/rsGa6pr7yTsQKnIDzkREMat0X5W8/KD/IRh5oSUwnCKCIjvTn86yOr1Pu6r3sx1+pwGo0VI+ZJSnkFPwJYLJ9hGovTbExLSmeGixJLRsfIg4h3Fq0aX9VFG14vUmB3mBp290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZC/+0ufS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717685463;
	bh=/m4iyYTbnF7Xxg6MP0Zi26UwXuOjb4EQbmnW0m/H6qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZC/+0ufSx2OLdxgwjD5ER23JTbzk3QM3+mPKZXyYerua2lmKDQC8KMeH4gelDZDji
	 Jpw1U1NIURKj38+Z9WY8zsXNQfhbp2gzNmfKyAG5NF1iudxvYV+ymEkpM/75blp3Qo
	 ezhLBzoKkBgW6wVYsnelGr5+2WfjiBZSYu08gJvE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Jun 2024 16:50:57 +0200
Subject: [PATCH RFC 3/6] power: supply: core: implement extension API
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-power-supply-extensions-v1-3-b45669290bdc@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717685463; l=10504;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/m4iyYTbnF7Xxg6MP0Zi26UwXuOjb4EQbmnW0m/H6qk=;
 b=7v5WKE9zgw1bFIvofJWwz8qboePxFe3Bo2RbWZiBTP6ChUauCfhvoni2LjeqmwAPp74fG2S/3
 b3Sp/F2d30kANAyLe6rEQpIcVKQ7Z5v5C/qpq+WFrhef5leX98KYBfa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       |  6 +-
 drivers/power/supply/power_supply_core.c  | 93 ++++++++++++++++++++++++++++---
 drivers/power/supply/power_supply_hwmon.c |  2 +-
 drivers/power/supply/power_supply_sysfs.c | 22 +++++++-
 include/linux/power_supply.h              | 23 ++++++++
 5 files changed, 132 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 622be1f0a180..7f9e139064cc 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,8 +13,10 @@ struct device;
 struct device_type;
 struct power_supply;
 
-extern bool power_supply_has_property(const struct power_supply_desc *psy_desc,
-				      enum power_supply_property psp);
+bool power_supply_has_property(const struct power_supply *psy,
+			       enum power_supply_property psp);
+bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
+				   enum power_supply_property psp);
 
 #ifdef CONFIG_SYSFS
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d57ecdd966e0..b32bbca9a848 100644
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
@@ -1199,6 +1199,33 @@ bool power_supply_has_property(const struct power_supply_desc *psy_desc,
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
+	if (power_supply_ext_has_property(psy->ext, psp))
+		return true;
+	return psy_desc_has_property(psy->desc, psp);
+}
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
@@ -1209,7 +1236,9 @@ int power_supply_get_property(struct power_supply *psy,
 		return -ENODEV;
 	}
 
-	if (power_supply_has_property(psy->desc, psp))
+	if (power_supply_ext_has_property(psy->ext, psp))
+		return psy->ext->get_property(psy, psp, val);
+	else if (psy_desc_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
@@ -1222,7 +1251,17 @@ int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 || !psy->desc->set_property)
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	if (power_supply_ext_has_property(psy->ext, psp)) {
+		if (psy->ext->set_property)
+			return psy->ext->set_property(psy, psp, val);
+		else
+			return -ENODEV;
+	}
+
+	if (!psy->desc->set_property)
 		return -ENODEV;
 
 	return psy->desc->set_property(psy, psp, val);
@@ -1232,8 +1271,17 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
 int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 ||
-			!psy->desc->property_is_writeable)
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	if (power_supply_ext_has_property(psy->ext, psp)) {
+		if (psy->ext->property_is_writeable)
+			return psy->ext->property_is_writeable(psy, psp);
+		else
+			return -ENODEV;
+	}
+
+	if (!psy->desc->property_is_writeable)
 		return -ENODEV;
 
 	return psy->desc->property_is_writeable(psy, psp);
@@ -1256,6 +1304,35 @@ int power_supply_powers(struct power_supply *psy, struct device *dev)
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
+	if (psy->ext)
+		return -EEXIST;
+
+	psy->ext = ext;
+	return power_supply_update_groups(psy);
+}
+EXPORT_SYMBOL_GPL(power_supply_register_extension);
+
+void power_supply_unregister_extension(struct power_supply *psy, const struct power_supply_ext *ext)
+{
+	if (psy->ext != ext)
+		dev_warn(&psy->dev, "Trying to unregister invalid extension");
+
+	psy->ext = NULL;
+	power_supply_update_groups(psy);
+}
+EXPORT_SYMBOL_GPL(power_supply_unregister_extension);
+
 static void power_supply_dev_release(struct device *dev)
 {
 	struct power_supply *psy = to_power_supply(dev);
@@ -1308,7 +1385,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (power_supply_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
+	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
@@ -1361,7 +1438,7 @@ __power_supply_register(struct device *parent,
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
-	if (power_supply_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
+	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
 	    (!desc->usb_types || !desc->num_usb_types))
 		return ERR_PTR(-EINVAL);
 
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
index abd44ebfe6fe..3487f161e9bf 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -304,8 +304,12 @@ static ssize_t power_supply_show_property(struct device *dev,
 						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
-		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
-							 value.intval, buf);
+		if (power_supply_ext_has_property(psy->ext, POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR))
+			ret = power_supply_charge_behaviour_show(dev, psy->ext->charge_behaviours,
+								 value.intval, buf);
+		else
+			ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
+								 value.intval, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
@@ -374,7 +378,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	if (power_supply_has_property(psy->desc, attrno)) {
+	if (power_supply_has_property(psy, attrno)) {
 		if (power_supply_property_is_writeable(psy, attrno) > 0)
 			mode |= S_IWUSR;
 		return mode;
@@ -486,7 +490,19 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (ret)
 		goto out;
 
+	if (psy->ext) {
+		for (j = 0; j < psy->ext->num_properties; j++) {
+			set_bit(psy->ext->properties[j], psy_drv_properties);
+			ret = add_prop_uevent(dev, env, psy->ext->properties[j],
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
index 8e5705a56b85..0c1e23081d2a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -280,6 +280,22 @@ struct power_supply_desc {
 	int use_for_apm;
 };
 
+struct power_supply_ext {
+	u8 charge_behaviours;
+	const enum power_supply_property *properties;
+	size_t num_properties;
+
+	int (*get_property)(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val);
+	int (*set_property)(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val);
+
+	int (*property_is_writeable)(struct power_supply *psy,
+				     enum power_supply_property psp);
+};
+
 struct power_supply {
 	const struct power_supply_desc *desc;
 
@@ -290,6 +306,8 @@ struct power_supply {
 	size_t num_supplies;
 	struct device_node *of_node;
 
+	const struct power_supply_ext *ext;
+
 	/* Driver private data */
 	void *drv_data;
 
@@ -892,6 +910,11 @@ devm_power_supply_register_no_ws(struct device *parent,
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


