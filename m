Return-Path: <linux-pm+bounces-19065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FE9ED6E0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FA1639DB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DCE20A5EF;
	Wed, 11 Dec 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="H4BPqkGv"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DD2594BD;
	Wed, 11 Dec 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947083; cv=none; b=N93SDCAwEEBBkrlk5IZ0YrVMx1RK96TEr9orRaeo5icayzFdlcK+Qu7lyLdDq3uDe5bmPHczeYThtCAL8ObVQEaiP8qadl0GVRiye3noT/Yg+tMDudYCu4MYwErEH8TzGl3hco8wcNXtxYx4LlYbFOEp8FjtBvhFrx++aPi4m8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947083; c=relaxed/simple;
	bh=C+1J1UjCBzJdTbCxyPiJWFdz33aLJqi4BWpL1fUhpCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRAnxWShNDUEoZif/FZOPTH3CcE6E+30x9f4KLbizlpMdgr0T5DBgVXJhsKxjblMiTxfCwJfzJeMF2c7Jcu4eJwhFsfgPxFUm/EyplpUbq2Z/bPuy5hRRK1w75ML8bmhey843rleOG967giDcBnfyK8fkU06J4Xy0gm9iE/D5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=H4BPqkGv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733947079;
	bh=C+1J1UjCBzJdTbCxyPiJWFdz33aLJqi4BWpL1fUhpCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H4BPqkGv1USJ7ZBqpUgJPLuFApOj5GYnlmJKxbq4tq4Ttiq1snrdJYJe0SASY43B3
	 hvyEbtjdlRdDhQFlJ6mAa/wAf0IvxDhqUv8CKmyRO8A2irvKxJ+XgBbJzHvVAhnP8P
	 lLLZgvQKGZSmKwF/yFKCcBKke30wDEFSbx4R14Ps=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 20:57:57 +0100
Subject: [PATCH v6 3/4] power: supply: cros_charge-control: implement a
 power supply extension
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-power-supply-extensions-v6-3-9d9dc3f3d387@weissschuh.net>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
In-Reply-To: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733947078; l=10910;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C+1J1UjCBzJdTbCxyPiJWFdz33aLJqi4BWpL1fUhpCA=;
 b=BpVQmsPHo/dDMTMiGxmesoeudNmcFfOsls2YLL/lsebANaxHtZ4qURr2jck/S2zLuSZOp4OjN
 AX4g2Es3pLuCtKWRQmAkcX1p4C+6n/nZDSAR9uOmkm2YYCJOuKnE+SX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Power supply extensions provide an easier mechanism to implement
additional properties for existing power supplies.
Use that instead of reimplementing the sysfs attributes manually.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_charge-control.c | 197 +++++++++++++----------------
 1 file changed, 85 insertions(+), 112 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 9b0a7500296b4d7eb8cd53153e148926bb98aec1..fb4af232721dec1d4f0090f6616922848812b2a2 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -20,13 +20,6 @@
 					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)   | \
 					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
 
-enum CROS_CHCTL_ATTR {
-	CROS_CHCTL_ATTR_START_THRESHOLD,
-	CROS_CHCTL_ATTR_END_THRESHOLD,
-	CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR,
-	_CROS_CHCTL_ATTR_COUNT
-};
-
 /*
  * Semantics of data *returned* from the EC API and Linux sysfs differ
  * slightly, also the v1 API can not return any data.
@@ -43,13 +36,7 @@ struct cros_chctl_priv {
 	struct power_supply *hooked_battery;
 	u8 cmd_version;
 
-	/* The callbacks need to access this priv structure.
-	 * As neither the struct device nor power_supply are under the drivers
-	 * control, embed the attributes within priv to use with container_of().
-	 */
-	struct device_attribute device_attrs[_CROS_CHCTL_ATTR_COUNT];
-	struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
-	struct attribute_group group;
+	const struct power_supply_ext *psy_ext;
 
 	struct mutex lock; /* protects fields below and cros_ec */
 	enum power_supply_charge_behaviour current_behaviour;
@@ -119,26 +106,39 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
 	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
 }
 
-static struct cros_chctl_priv *cros_chctl_attr_to_priv(struct attribute *attr,
-						       enum CROS_CHCTL_ATTR idx)
+static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
+				       const struct power_supply_ext *ext,
+				       void *data,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
 {
-	struct device_attribute *dev_attr = container_of(attr, struct device_attribute, attr);
+	struct cros_chctl_priv *priv = data;
 
-	return container_of(dev_attr, struct cros_chctl_priv, device_attrs[idx]);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		val->intval = priv->current_start_threshold;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		val->intval = priv->current_end_threshold;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		val->intval = priv->current_behaviour;
+		return 0;
+	default:
+		return -EINVAL;
+	}
 }
 
-static ssize_t cros_chctl_store_threshold(struct device *dev, struct cros_chctl_priv *priv,
-					  int is_end_threshold, const char *buf, size_t count)
+static int cros_chctl_psy_ext_set_threshold(struct cros_chctl_priv *priv,
+					    enum power_supply_property psp,
+					    int val)
 {
-	int ret, val;
+	int ret;
 
-	ret = kstrtoint(buf, 10, &val);
-	if (ret < 0)
-		return ret;
 	if (val < 0 || val > 100)
 		return -EINVAL;
 
-	if (is_end_threshold) {
+	if (psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
 		/* Start threshold is not exposed, use fixed value */
 		if (priv->cmd_version == 2)
 			priv->current_start_threshold = val == 100 ? 0 : val;
@@ -158,93 +158,72 @@ static ssize_t cros_chctl_store_threshold(struct device *dev, struct cros_chctl_
 			return ret;
 	}
 
-	return count;
-}
-
-static ssize_t charge_control_start_threshold_show(struct device *dev,
-						   struct device_attribute *attr,
-						   char *buf)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_START_THRESHOLD);
-
-	guard(mutex)(&priv->lock);
-	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_threshold);
+	return 0;
 }
 
-static ssize_t charge_control_start_threshold_store(struct device *dev,
-						    struct device_attribute *attr,
-						    const char *buf, size_t count)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_START_THRESHOLD);
-
-	guard(mutex)(&priv->lock);
-	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
-}
 
-static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
-						 char *buf)
+static int cros_chctl_psy_ext_set_prop(struct power_supply *psy,
+				       const struct power_supply_ext *ext,
+				       void *data,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
 {
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_END_THRESHOLD);
+	struct cros_chctl_priv *priv = data;
+	int ret;
 
 	guard(mutex)(&priv->lock);
-	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshold);
-}
-
-static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
-						  const char *buf, size_t count)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_END_THRESHOLD);
 
-	guard(mutex)(&priv->lock);
-	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		return cros_chctl_psy_ext_set_threshold(priv, psp, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		priv->current_behaviour = val->intval;
+		ret = cros_chctl_configure_ec(priv);
+		if (ret < 0)
+			return ret;
+		return 0;
+	default:
+		return -EINVAL;
+	}
 }
 
-static ssize_t charge_behaviour_show(struct device *dev, struct device_attribute *attr, char *buf)
+static int cros_chctl_psy_prop_is_writeable(struct power_supply *psy,
+					    const struct power_supply_ext *ext,
+					    void *data,
+					    enum power_supply_property psp)
 {
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
-
-	guard(mutex)(&priv->lock);
-	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVIOURS,
-						  priv->current_behaviour, buf);
+	return true;
 }
 
-static ssize_t charge_behaviour_store(struct device *dev, struct device_attribute *attr,
-				      const char *buf, size_t count)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
-	int ret;
-
-	ret = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
-	if (ret < 0)
-		return ret;
-
-	guard(mutex)(&priv->lock);
-	priv->current_behaviour = ret;
+#define DEFINE_CROS_CHCTL_POWER_SUPPLY_EXTENSION(_name, ...)			\
+	static const enum power_supply_property _name ## _props[] = {		\
+		__VA_ARGS__,							\
+	};									\
+										\
+	static const struct power_supply_ext _name = {				\
+		.properties		= _name ## _props,			\
+		.num_properties		= ARRAY_SIZE(_name ## _props),		\
+		.charge_behaviours	= EC_CHARGE_CONTROL_BEHAVIOURS,		\
+		.get_property		= cros_chctl_psy_ext_get_prop,		\
+		.set_property		= cros_chctl_psy_ext_set_prop,		\
+		.property_is_writeable	= cros_chctl_psy_prop_is_writeable,	\
+	}
 
-	ret = cros_chctl_configure_ec(priv);
-	if (ret < 0)
-		return ret;
+DEFINE_CROS_CHCTL_POWER_SUPPLY_EXTENSION(cros_chctl_psy_ext_v1,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
+);
 
-	return count;
-}
+DEFINE_CROS_CHCTL_POWER_SUPPLY_EXTENSION(cros_chctl_psy_ext_v2,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
+);
 
-static umode_t cros_chtl_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(attr, n);
-
-	if (n == CROS_CHCTL_ATTR_START_THRESHOLD && priv->cmd_version < 3)
-		return 0;
-	else if (n == CROS_CHCTL_ATTR_END_THRESHOLD && priv->cmd_version < 2)
-		return 0;
-
-	return attr->mode;
-}
+DEFINE_CROS_CHCTL_POWER_SUPPLY_EXTENSION(cros_chctl_psy_ext_v3,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
+);
 
 static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
@@ -254,7 +233,7 @@ static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_batt
 		return 0;
 
 	priv->hooked_battery = battery;
-	return device_add_group(&battery->dev, &priv->group);
+	return power_supply_register_extension(battery, priv->psy_ext, priv);
 }
 
 static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
@@ -262,7 +241,7 @@ static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_b
 	struct cros_chctl_priv *priv = container_of(hook, struct cros_chctl_priv, battery_hook);
 
 	if (priv->hooked_battery == battery) {
-		device_remove_group(&battery->dev, &priv->group);
+		power_supply_unregister_extension(battery, priv->psy_ext);
 		priv->hooked_battery = NULL;
 	}
 
@@ -288,7 +267,6 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
 	struct cros_chctl_priv *priv;
-	size_t i;
 	int ret;
 
 	ret = cros_chctl_fwk_charge_control_versions(cros_ec);
@@ -322,18 +300,13 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version);
 
 	priv->cros_ec = cros_ec;
-	priv->device_attrs[CROS_CHCTL_ATTR_START_THRESHOLD] =
-		(struct device_attribute)__ATTR_RW(charge_control_start_threshold);
-	priv->device_attrs[CROS_CHCTL_ATTR_END_THRESHOLD] =
-		(struct device_attribute)__ATTR_RW(charge_control_end_threshold);
-	priv->device_attrs[CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR] =
-		(struct device_attribute)__ATTR_RW(charge_behaviour);
-	for (i = 0; i < _CROS_CHCTL_ATTR_COUNT; i++) {
-		sysfs_attr_init(&priv->device_attrs[i].attr);
-		priv->attributes[i] = &priv->device_attrs[i].attr;
-	}
-	priv->group.is_visible = cros_chtl_attr_is_visible;
-	priv->group.attrs = priv->attributes;
+
+	if (priv->cmd_version == 1)
+		priv->psy_ext = &cros_chctl_psy_ext_v1;
+	else if (priv->cmd_version == 2)
+		priv->psy_ext = &cros_chctl_psy_ext_v2;
+	else
+		priv->psy_ext = &cros_chctl_psy_ext_v3;
 
 	priv->battery_hook.name = dev_name(dev);
 	priv->battery_hook.add_battery = cros_chctl_add_battery;

-- 
2.47.1


