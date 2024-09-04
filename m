Return-Path: <linux-pm+bounces-13619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C796C77C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75F9288010
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38871E9744;
	Wed,  4 Sep 2024 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="N+9+k8GY"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69131E7671;
	Wed,  4 Sep 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477957; cv=none; b=qfNNSn/ETA+GLWXal1ICA67kjWFXkFC0xryQFejkOgn133Il1z6kdCYubL2PkUOcsjo5oQ6oMv09cP+yGcTD05GnYv24Ino6cmSCsZIkTNOslkMUmEnIK1i5+Oi8nzcwjusZA/rqNyaa3cOSD2vh6ZPqlgxkxoQNuM1vjVqY4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477957; c=relaxed/simple;
	bh=eMUeVr6CvVJ8cr1bCvgkx350hCvdH3yQPf0m+2CqLHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=au4rxh3IpGxpdmWvu5uBB82RxFzDvdU9PD661/vY2V+0XBHWe4kJwsgWFNRZeQEiHbrbApYnJhgFsd2necwIVs6MVy4NKJ//GGN9LLLiWGwf+DOI8ZVovL97q89hSjPfPS/6qp9Kt6peWau7mqPBDXaGo69pvQWJwmB/wiebsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=N+9+k8GY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477950;
	bh=eMUeVr6CvVJ8cr1bCvgkx350hCvdH3yQPf0m+2CqLHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+9+k8GYmSNeqEvDMpLl/yTpau1e+PG/LfotsR4LTszfI7g8mpZUY5+V1c4qpaTLu
	 csBDR28ReJz/bNAlfSg1KVHy6rMt4iu+cpkFmogfhDwP0fu7AUlFmTvi1Jt34Zc0Qh
	 7vK/vyL+raSeVFtNUjbG1/Pu9RbvXN0lQji0Jzp8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:39 +0200
Subject: [PATCH RFC v3 6/9] power: supply: core: implement extension API
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-6-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=9950;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eMUeVr6CvVJ8cr1bCvgkx350hCvdH3yQPf0m+2CqLHA=;
 b=VmHC8xkSL0OqF2WzBDCzpSAcRUfXNZuWUz2So291TAyozjryq8RSMOxMweIsleqbqo3uKPUK4
 YdMk4zKczb+AZGDvr6C31jOu0wi4PCbb+1L9x+gggxajsnk/sNmMFdD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       |  12 ++++
 drivers/power/supply/power_supply_core.c  | 114 +++++++++++++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c |  20 +++++-
 include/linux/power_supply.h              |  30 ++++++++
 4 files changed, 171 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index b01faeaf7827..fb45f0717bd1 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -15,6 +15,18 @@ struct power_supply;
 
 extern bool power_supply_has_property(struct power_supply *psy,
 				      enum power_supply_property psp);
+extern bool power_supply_ext_has_property(const struct power_supply_ext *ext,
+				          enum power_supply_property psp);
+
+struct power_supply_ext_registration {
+	struct list_head list_head;
+	const struct power_supply_ext *ext;
+	void *data;
+};
+
+#define power_supply_for_each_extension(pos, psy) \
+	list_for_each_entry(pos, &(psy)->extensions, list_head)
+
 
 #ifdef CONFIG_SYSFS
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index dcb7e4853030..db5e7af57e67 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1199,15 +1199,40 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
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
 bool power_supply_has_property(struct power_supply *psy,
 			       enum power_supply_property psp)
 {
+	struct power_supply_ext_registration *reg;
+
 	if (psy_desc_has_property(psy->desc, psp))
 		return true;
 
 	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return true;
 
+	power_supply_for_each_extension(reg, psy)
+		if (power_supply_ext_has_property(reg->ext, psp))
+			return true;
+
 	return false;
 }
 
@@ -1215,12 +1240,19 @@ int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
+	struct power_supply_ext_registration *reg;
+
 	if (atomic_read(&psy->use_cnt) <= 0) {
 		if (!psy->initialized)
 			return -EAGAIN;
 		return -ENODEV;
 	}
 
+	power_supply_for_each_extension(reg, psy) {
+		if (power_supply_ext_has_property(reg->ext, psp))
+			return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
+	}
+
 	if (psy_desc_has_property(psy->desc, psp))
 		return psy->desc->get_property(psy, psp, val);
 	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
@@ -1234,7 +1266,21 @@ int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 || !psy->desc->set_property)
+	struct power_supply_ext_registration *reg;
+
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	power_supply_for_each_extension(reg, psy) {
+		if (power_supply_ext_has_property(reg->ext, psp)) {
+			if (reg->ext->set_property)
+				return reg->ext->set_property(psy, reg->ext, reg->data, psp, val);
+			else
+				return -ENODEV;
+		}
+	}
+
+	if (!psy->desc->set_property)
 		return -ENODEV;
 
 	return psy->desc->set_property(psy, psp, val);
@@ -1244,8 +1290,21 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
 int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 ||
-			!psy->desc->property_is_writeable)
+	struct power_supply_ext_registration *reg;
+
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	power_supply_for_each_extension(reg, psy) {
+		if (power_supply_ext_has_property(reg->ext, psp)) {
+			if (reg->ext->property_is_writeable)
+				return reg->ext->property_is_writeable(psy, reg->ext, reg->data, psp);
+			else
+				return -ENODEV;
+		}
+	}
+
+	if (!psy->desc->property_is_writeable)
 		return -ENODEV;
 
 	return psy->desc->property_is_writeable(psy, psp);
@@ -1268,6 +1327,54 @@ int power_supply_powers(struct power_supply *psy, struct device *dev)
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
+int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
+				    void *ext_data)
+{
+	struct power_supply_ext_registration *reg;
+	size_t i;
+
+	for (i = 0; i < ext->num_properties; i++) {
+		if (power_supply_has_property(psy, ext->properties[i]))
+			return -EEXIST;
+	}
+
+	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
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
+	struct power_supply_ext_registration *reg;
+
+	power_supply_for_each_extension(reg, psy) {
+		if (reg->ext == ext) {
+			list_del(&reg->list_head);
+			kfree(reg);
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
@@ -1427,6 +1534,7 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	INIT_LIST_HEAD(&psy->extensions);
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 915a4ba62258..e7c306afd846 100644
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
+	struct power_supply_ext_registration *reg;
+
+	power_supply_for_each_extension(reg, psy) {
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
@@ -306,8 +323,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
-		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
-							 value.intval, buf);
+		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 72dc7e45c90c..51788faf1d66 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/leds.h>
+#include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 
@@ -280,6 +281,28 @@ struct power_supply_desc {
 	int use_for_apm;
 };
 
+struct power_supply_ext {
+	u8 charge_behaviours;
+	const enum power_supply_property *properties;
+	size_t num_properties;
+
+	int (*get_property)(struct power_supply *psy,
+			    const struct power_supply_ext *ext,
+			    void *ext_data,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val);
+	int (*set_property)(struct power_supply *psy,
+			    const struct power_supply_ext *ext,
+			    void *ext_data,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val);
+
+	int (*property_is_writeable)(struct power_supply *psy,
+				     const struct power_supply_ext *ext,
+				     void *ext_data,
+				     enum power_supply_property psp);
+};
+
 struct power_supply {
 	const struct power_supply_desc *desc;
 
@@ -303,6 +326,7 @@ struct power_supply {
 	bool removing;
 	atomic_t use_cnt;
 	struct power_supply_battery_info *battery_info;
+	struct list_head extensions;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
 	struct thermal_cooling_device *tcd;
@@ -887,6 +911,12 @@ devm_power_supply_register_no_ws(struct device *parent,
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
+extern int power_supply_register_extension(struct power_supply *psy,
+					   const struct power_supply_ext *ext,
+					   void *ext_data);
+extern void power_supply_unregister_extension(struct power_supply *psy,
+					      const struct power_supply_ext *ext);
+
 #define to_power_supply(device) container_of(device, struct power_supply, dev)
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);

-- 
2.46.0


