Return-Path: <linux-pm+bounces-13620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DB96C77E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F081F24635
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291A1E974B;
	Wed,  4 Sep 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Pj3MBOzu"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AB1E7670;
	Wed,  4 Sep 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477957; cv=none; b=E1cnGIZJEtEPIqDZrqhw2cdmBOmwJXcrM63Y7asOkdV2J4BAxm0lupLIePvzDrgkLJDYW7GQuXIOEOLynnHKe2ARdY/SD/T/wNLdd+ccmTYI69pNMGcBmtOx/dQUvSW2z5Q8+u0NAobpRbNWISOqOGwn7C3WC1swcyE0BUuIvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477957; c=relaxed/simple;
	bh=tHNlvPi7yYkH3oqJ16GU7YD6XTS+KrMh5eA+TUOzR88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SD0kWXFF/p4Y3ELjtNSu3TXKcMOkdiM47yFifx97e9b4Mej0dL7csvbB12Er4PoyehbG0Ny6avOTw8O+cJ3/3utaextJWetDKp5RMi4kpHPw6XxP2RMrohOAEuR8arasoDhEwyVoyg8Yi7Ra74netpm5PRBXUa1TYYuU9nSJH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Pj3MBOzu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477950;
	bh=tHNlvPi7yYkH3oqJ16GU7YD6XTS+KrMh5eA+TUOzR88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pj3MBOzuo2ikhtaUw4vyhPT+lkvtmaMpO0lB3wnTK8umsHiNPoVeFcj2WQd/wql6X
	 anAylPIoWhst/TlKjhKb2ckVSMc8FDjsupRfeeVmBg5MaxqadkgtFdponPVUQ7QMVq
	 +ZGzK0yHYv+H5lUisgSDsq2nFXgLzoNuGXikRyvQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:40 +0200
Subject: [PATCH RFC v3 7/9] power: supply: core: add locking around
 extension access
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-7-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=8384;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tHNlvPi7yYkH3oqJ16GU7YD6XTS+KrMh5eA+TUOzR88=;
 b=RME6lvjAeSoiHtkEuYGRp7ZyQerwE/vV7TLS0ZK8zb93CocCJfBZE4I2QiEbelK5AzREzIZs6
 I0/FrTEuyEFDASazlCi+uKyBMxECqxZu8EW5CRRjamcOAdV1xnxr4m0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
This is only separate for easier review during the RFC phase.
It will be squashed into the actual power supply extension commit later.
---
 drivers/power/supply/power_supply.h       |  3 ++
 drivers/power/supply/power_supply_core.c  | 49 ++++++++++++++++++++++++++-----
 drivers/power/supply/power_supply_leds.c  |  2 ++
 drivers/power/supply/power_supply_sysfs.c |  6 ++++
 include/linux/power_supply.h              |  3 ++
 5 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index fb45f0717bd1..b8e14cc70fcf 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -9,6 +9,8 @@
  *  Modified: 2004, Oct     Szabolcs Gyurko
  */
 
+#include <linux/lockdep.h>
+
 struct device;
 struct device_type;
 struct power_supply;
@@ -25,6 +27,7 @@ struct power_supply_ext_registration {
 };
 
 #define power_supply_for_each_extension(pos, psy) \
+	lockdep_assert_held(&(psy)->extensions_sem); \
 	list_for_each_entry(pos, &(psy)->extensions, list_head)
 
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index db5e7af57e67..4839be25e6be 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -80,6 +81,7 @@ static int __power_supply_changed_work(struct device *dev, void *data)
 
 static void power_supply_changed_work(struct work_struct *work)
 {
+	int ret;
 	unsigned long flags;
 	struct power_supply *psy = container_of(work, struct power_supply,
 						changed_work);
@@ -87,6 +89,16 @@ static void power_supply_changed_work(struct work_struct *work)
 	dev_dbg(&psy->dev, "%s\n", __func__);
 
 	spin_lock_irqsave(&psy->changed_lock, flags);
+
+	if (unlikely(psy->update_groups)) {
+		psy->update_groups = false;
+		spin_unlock_irqrestore(&psy->changed_lock, flags);
+		ret = sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.groups);
+		if (ret)
+			dev_warn(&psy->dev, "failed to update sysfs groups: %pe\n", ERR_PTR(ret));
+		spin_lock_irqsave(&psy->changed_lock, flags);
+	}
+
 	/*
 	 * Check 'changed' here to avoid issues due to race between
 	 * power_supply_changed() and this routine. In worst case
@@ -1218,17 +1230,26 @@ bool power_supply_ext_has_property(const struct power_supply_ext *psy_ext,
 	return found;
 }
 
-bool power_supply_has_property(struct power_supply *psy,
-			       enum power_supply_property psp)
+static bool psy_has_property_no_ext(struct power_supply *psy,
+				    enum power_supply_property psp)
 {
-	struct power_supply_ext_registration *reg;
-
 	if (psy_desc_has_property(psy->desc, psp))
 		return true;
 
 	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return true;
 
+	return false;
+}
+
+bool power_supply_has_property(struct power_supply *psy,
+			       enum power_supply_property psp)
+{
+	struct power_supply_ext_registration *reg;
+
+	if (psy_has_property_no_ext(psy, psp))
+		return true;
+
 	power_supply_for_each_extension(reg, psy)
 		if (power_supply_ext_has_property(reg->ext, psp))
 			return true;
@@ -1329,11 +1350,14 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
 
 static int power_supply_update_groups(struct power_supply *psy)
 {
-	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&psy->changed_lock, flags);
+	psy->update_groups = true;
+	spin_unlock_irqrestore(&psy->changed_lock, flags);
 
-	ret = sysfs_update_groups(&psy->dev.kobj, power_supply_dev_type.groups);
 	power_supply_changed(psy);
-	return ret;
+	return 0;
 }
 
 int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
@@ -1342,6 +1366,8 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
 	struct power_supply_ext_registration *reg;
 	size_t i;
 
+	guard(rwsem_write)(&psy->extensions_sem);
+
 	for (i = 0; i < ext->num_properties; i++) {
 		if (power_supply_has_property(psy, ext->properties[i]))
 			return -EEXIST;
@@ -1362,6 +1388,8 @@ void power_supply_unregister_extension(struct power_supply *psy, const struct po
 {
 	struct power_supply_ext_registration *reg;
 
+	guard(rwsem_write)(&psy->extensions_sem);
+
 	power_supply_for_each_extension(reg, psy) {
 		if (reg->ext == ext) {
 			list_del(&reg->list_head);
@@ -1405,6 +1433,7 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 
 	WARN_ON(tzd == NULL);
 	psy = thermal_zone_device_priv(tzd);
+	guard(rwsem_read)(&psy->extensions_sem);
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
 	if (ret)
 		return ret;
@@ -1427,7 +1456,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
+	if (psy_has_property_no_ext(psy, POWER_SUPPLY_PROP_TEMP)) {
 		/* Prefer our hwmon device and avoid duplicates */
 		struct thermal_zone_params tzp = {
 			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
@@ -1534,7 +1563,9 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	init_rwsem(&psy->extensions_sem);
 	INIT_LIST_HEAD(&psy->extensions);
+
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
@@ -1547,6 +1578,8 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
+	guard(rwsem_read)(&psy->extensions_sem);
+
 	rc = power_supply_create_triggers(psy);
 	if (rc)
 		goto create_triggers_failed;
diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index f4a7e566bea1..09a6f3fe2f85 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -195,6 +195,8 @@ static void power_supply_remove_gen_triggers(struct power_supply *psy)
 
 void power_supply_update_leds(struct power_supply *psy)
 {
+	guard(rwsem_read)(&psy->extensions_sem);
+
 	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
 		power_supply_update_bat_leds(psy);
 	else
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index e7c306afd846..b56e0bd424f5 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -371,6 +371,8 @@ static ssize_t power_supply_store_property(struct device *dev,
 
 	value.intval = ret;
 
+	guard(rwsem_read)(&psy->extensions_sem);
+
 	ret = power_supply_set_property(psy, psp, &value);
 	if (ret < 0)
 		return ret;
@@ -392,6 +394,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
+	guard(rwsem_read)(&psy->extensions_sem);
+
 	if (power_supply_has_property(psy, attrno)) {
 		if (power_supply_property_is_writeable(psy, attrno) > 0)
 			mode |= S_IWUSR;
@@ -497,6 +501,8 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (ret)
 		goto out;
 
+	guard(rwsem_read)(&psy->extensions_sem);
+
 	for (j = 0; j < POWER_SUPPLY_ATTR_CNT; j++) {
 		ret = add_prop_uevent(dev, env, j, prop_buf);
 		if (ret)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 51788faf1d66..87bc50698649 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/leds.h>
+#include <linux/rwsem.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
@@ -322,10 +323,12 @@ struct power_supply {
 	struct delayed_work deferred_register_work;
 	spinlock_t changed_lock;
 	bool changed;
+	bool update_groups;
 	bool initialized;
 	bool removing;
 	atomic_t use_cnt;
 	struct power_supply_battery_info *battery_info;
+	struct rw_semaphore extensions_sem; /* protects "extensions" */
 	struct list_head extensions;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;

-- 
2.46.0


