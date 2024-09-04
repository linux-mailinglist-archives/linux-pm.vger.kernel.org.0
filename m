Return-Path: <linux-pm+bounces-13621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6096C780
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FFDB24E86
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF11E9754;
	Wed,  4 Sep 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sz9VChhl"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42301E766F;
	Wed,  4 Sep 2024 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477958; cv=none; b=RIZfBWMEzW0mJAkCBl10Hh1sm5U0hj6k5pc+7L+ldbMhnHx+sTWvau1YqdzpauG6svF6RCqpNMyI42/zjJ5Hg7E3tIKSg6Y5knWnLCDw3Gt8063urjc9o/voQL7YkWi+bSPMyzfUihPPniWhMW9yVJIYC11uA7B61xaYypX0G34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477958; c=relaxed/simple;
	bh=I85wCUmCzAyQhRIqum8155x0h1PMiQC3CXIyjhbPiJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paLTYwW6l0FA2lvgFxAkoMJQmb+XWHEV0Phdf6hODbFUJRQDJ0VSC8cLzmwXsFZ8SWbi4Tcj6RtnLrSeRzozeqOAy1iuFrzuHhwgdj9ztLfmYboK6UbRhd6AEXjb+ZltJfMwz7ha9ppeE27CZKj4EweoCDOUyZKOgFHyQlgIYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sz9VChhl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477950;
	bh=I85wCUmCzAyQhRIqum8155x0h1PMiQC3CXIyjhbPiJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sz9VChhlx6qVOF15zII4e53JOGDau/HSlbADRZS83apgOvxfdV5ap/x63S1/yUBFg
	 l+XV6Ta8hiYlPNPs6qQYsdZNIvCyz6VMbAlKYOvWYPoE+Cd75iVN1huCL/tSn6gABQ
	 SRKq3V5fV5SNJgjZeYEGbazj4ClqoE3c/KiE+lBg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:42 +0200
Subject: [PATCH RFC v3 9/9] power: supply: cros_charge-control: use
 power_supply extensions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-9-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=10831;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=I85wCUmCzAyQhRIqum8155x0h1PMiQC3CXIyjhbPiJ0=;
 b=1JkghiKquNkJ5fqd5PBa1fM0w7b/XqGuuzQNcj7TdMkmJw5BRkFSITensasnFAAFLSQ80sC/x
 5DKM7ASy8+hB8/BudeecqME+JkGGEQdh8Z/MoxlxdK14vmkiUIyQfuK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Power supply extensions provide an easier mechanism to implement
additional properties for existing power supplies.
Use that instead of reimplementing the sysfs attributes manually.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_charge-control.c | 207 +++++++++++------------------
 1 file changed, 78 insertions(+), 129 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 17c53591ce19..dbfd87f8eb1d 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -18,13 +18,6 @@
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
@@ -41,13 +34,7 @@ struct cros_chctl_priv {
 	struct power_supply *hooked_battery;
 	u8 cmd_version;
 
-	/* The callbacks need to access this priv structure.
-	 * As neither the struct device nor power_supply are under the drivers
-	 * control, embed the attributes within priv to use with container_of().
-	 */
-	struct device_attribute device_attrs[_CROS_CHCTL_ATTR_COUNT];
-	struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
-	struct attribute_group group;
+	struct power_supply_ext psy_ext;
 
 	enum power_supply_charge_behaviour current_behaviour;
 	u8 current_start_threshold, current_end_threshold;
@@ -114,123 +101,86 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
 	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
 }
 
-static struct cros_chctl_priv *cros_chctl_attr_to_priv(struct attribute *attr,
-						       enum CROS_CHCTL_ATTR idx)
-{
-	struct device_attribute *dev_attr = container_of(attr, struct device_attribute, attr);
+static const enum power_supply_property cros_chctl_psy_ext_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+};
 
-	return container_of(dev_attr, struct cros_chctl_priv, device_attrs[idx]);
-}
+static const enum power_supply_property cros_chctl_psy_ext_props_v1[] = {
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+};
 
-static ssize_t cros_chctl_store_threshold(struct device *dev, struct cros_chctl_priv *priv,
-					  int is_end_threshold, const char *buf, size_t count)
+static int cros_chctl_psy_ext_get_prop(struct power_supply *psy,
+				       const struct power_supply_ext *ext,
+				       void *data,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
 {
-	int ret, val;
+	struct cros_chctl_priv *priv = data;
 
-	ret = kstrtoint(buf, 10, &val);
-	if (ret < 0)
-		return ret;
-	if (val < 0 || val > 100)
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
 		return -EINVAL;
-
-	if (is_end_threshold) {
-		if (val <= priv->current_start_threshold)
-			return -EINVAL;
-		priv->current_end_threshold = val;
-	} else {
-		if (val >= priv->current_end_threshold)
-			return -EINVAL;
-		priv->current_start_threshold = val;
-	}
-
-	if (priv->current_behaviour == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) {
-		ret = cros_chctl_configure_ec(priv);
-		if (ret < 0)
-			return ret;
 	}
-
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
-	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_threshold);
-}
-
-static ssize_t charge_control_start_threshold_store(struct device *dev,
-						    struct device_attribute *attr,
-						    const char *buf, size_t count)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_START_THRESHOLD);
-
-	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
-}
-
-static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
-						 char *buf)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_END_THRESHOLD);
-
-	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshold);
-}
-
-static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
-						  const char *buf, size_t count)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_END_THRESHOLD);
-
-	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
 }
 
-static ssize_t charge_behaviour_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
-
-	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVIOURS,
-						  priv->current_behaviour, buf);
-}
 
-static ssize_t charge_behaviour_store(struct device *dev, struct device_attribute *attr,
-				      const char *buf, size_t count)
+static int cros_chctl_psy_ext_set_prop(struct power_supply *psy,
+				       const struct power_supply_ext *ext,
+				       void *data,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
 {
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
-							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
+	struct cros_chctl_priv *priv = data;
 	int ret;
 
-	ret = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
-	if (ret < 0)
-		return ret;
-
-	priv->current_behaviour = ret;
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval < 0 || val->intval > 100)
+			return -EINVAL;
 
-	ret = cros_chctl_configure_ec(priv);
-	if (ret < 0)
-		return ret;
+		if (psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
+			if (val->intval <= priv->current_start_threshold)
+				return -EINVAL;
+			priv->current_end_threshold = val->intval;
+		} else {
+			if (val->intval >= priv->current_end_threshold)
+				return -EINVAL;
+			priv->current_start_threshold = val->intval;
+		}
+
+		if (priv->current_behaviour == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) {
+			ret = cros_chctl_configure_ec(priv);
+			if (ret < 0)
+				return ret;
+		}
 
-	return count;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		priv->current_behaviour = val->intval;
+		return cros_chctl_configure_ec(priv); /* FIXME > 0 */
+	default:
+		return -EINVAL;
+	}
 }
 
-static umode_t cros_chtl_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+static int cros_chctl_psy_prop_is_writeable(struct power_supply *psy,
+					    const struct power_supply_ext *ext,
+					    void *data,
+					    enum power_supply_property psp)
 {
-	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(attr, n);
-
-	if (priv->cmd_version < 2) {
-		if (n == CROS_CHCTL_ATTR_START_THRESHOLD)
-			return 0;
-		if (n == CROS_CHCTL_ATTR_END_THRESHOLD)
-			return 0;
-	}
-
-	return attr->mode;
+	return true;
 }
 
 static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
@@ -241,7 +191,7 @@ static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_batt
 		return 0;
 
 	priv->hooked_battery = battery;
-	return device_add_group(&battery->dev, &priv->group);
+	return power_supply_register_extension(battery, &priv->psy_ext, priv);
 }
 
 static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
@@ -249,7 +199,7 @@ static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_b
 	struct cros_chctl_priv *priv = container_of(hook, struct cros_chctl_priv, battery_hook);
 
 	if (priv->hooked_battery == battery) {
-		device_remove_group(&battery->dev, &priv->group);
+		power_supply_unregister_extension(battery, &priv->psy_ext);
 		priv->hooked_battery = NULL;
 	}
 
@@ -275,7 +225,6 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
 	struct cros_chctl_priv *priv;
-	size_t i;
 	int ret;
 
 	ret = cros_chctl_fwk_charge_control_versions(cros_ec);
@@ -305,23 +254,23 @@ static int cros_chctl_probe(struct platform_device *pdev)
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
 
 	priv->battery_hook.name = dev_name(dev);
 	priv->battery_hook.add_battery = cros_chctl_add_battery;
 	priv->battery_hook.remove_battery = cros_chctl_remove_battery;
 
+	if (priv->cmd_version == 1) {
+		priv->psy_ext.properties = cros_chctl_psy_ext_props_v1;
+		priv->psy_ext.num_properties = ARRAY_SIZE(cros_chctl_psy_ext_props_v1);
+	} else {
+		priv->psy_ext.properties = cros_chctl_psy_ext_props;
+		priv->psy_ext.num_properties = ARRAY_SIZE(cros_chctl_psy_ext_props);
+	}
+	priv->psy_ext.charge_behaviours = EC_CHARGE_CONTROL_BEHAVIOURS;
+	priv->psy_ext.get_property = cros_chctl_psy_ext_get_prop;
+	priv->psy_ext.set_property = cros_chctl_psy_ext_set_prop;
+	priv->psy_ext.property_is_writeable = cros_chctl_psy_prop_is_writeable;
+
 	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
 	priv->current_start_threshold = 0;
 	priv->current_end_threshold = 100;

-- 
2.46.0


