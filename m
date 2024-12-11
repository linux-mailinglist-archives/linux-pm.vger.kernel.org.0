Return-Path: <linux-pm+bounces-19066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C069ED6E4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2151885646
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4720B814;
	Wed, 11 Dec 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TKpJDP+M"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1274209F22;
	Wed, 11 Dec 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947084; cv=none; b=Y50VltA8HK1iYYzW5QRaxvRK1je8SGSX/pL0ZdnqdoJTe1erJpEMpeg9xmgggApX0RESEQdZ/t7OZ2MtxR2rlOLqm2r3Wn/sk5FnQbRi5e5LQznd/WAY3NFm04311GvsFcpsfmWujWaUDsEUPsGHp/aGNHzp1OgDDdVRc7PMOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947084; c=relaxed/simple;
	bh=46WotVaECWG26OkEOVXUg7kQui6ipeeebMh7OoLHVwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSsnaZOrsIiBq3DLQqF7tVOyNwHB0R64sygovffzWws+b6UmEecbgOWY++hsDQtnBENU3/nk/iIXHE5Wi/mpUuqNO6h4fOC8ljDZMgk+u/ka5RNZ0bLROnehiGAMog/lYybDzaeXUtiU6//St4hGpKE8o9Lnghiqp0XHSgnhKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TKpJDP+M; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733947079;
	bh=46WotVaECWG26OkEOVXUg7kQui6ipeeebMh7OoLHVwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TKpJDP+MG1RacbluxG6wPl/2704S1qDCz+fJsaY3RiZbLiUtTIVZcoTK3mZ+Z2mMB
	 TCRgJINQYDoYhY4+cidDfrLVAi61pGGswAIRaz4bA93TQUWRBeqiOVvKi+IetXk3hI
	 t8nmecnqPaYVTD0kWxL4Cdbfy1f8bg+ZnrgmXQ6E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 20:57:58 +0100
Subject: [PATCH v6 4/4] power: supply: core: add UAPI to discover currently
 used extensions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733947078; l=8969;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=46WotVaECWG26OkEOVXUg7kQui6ipeeebMh7OoLHVwk=;
 b=I2vNYp+UAkSebwP2cXbdpyM9j7jV2egrrjlxacXd0Hr0lZrydI1lEXKWzEaYHRdWROJhbiVBA
 GIGldCyYEOqDTaBDah2PImGxtorw71b4di08Hf/Kf13OKBbrQOtXGyt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Userspace wants to now about the used power supply extensions,
for example to handle a device extended by a certain extension
differently or to discover information about the extending device.

Add a sysfs directory to the power supply device.
This directory contains links which are named after the used extension
and point to the device implementing that extension.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/ABI/testing/sysfs-class-power |  9 +++++++++
 drivers/power/supply/cros_charge-control.c  |  5 ++++-
 drivers/power/supply/power_supply.h         |  2 ++
 drivers/power/supply/power_supply_core.c    | 19 +++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c   | 10 ++++++++++
 drivers/power/supply/test_power.c           |  4 +++-
 include/linux/power_supply.h                |  2 ++
 7 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 45180b62d42686c8999eda54f38435cb6c74a879..31e8b33d849cbe99dc93a4ba3723a43440ac3103 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -793,3 +793,12 @@ Description:
 
 		Access: Read
 		Valid values: 1-31
+
+What:		/sys/class/power_supply/<supply_name>/extensions/<extension_name>
+Date:		March 2025
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the extensions registered to the power supply.
+		Each entry is a link to the device which registered the extension.
+
+		Access: Read
diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index fb4af232721dec1d4f0090f6616922848812b2a2..02d5bdbe2e8d45108dd8f2d3ab6a927b94864b9e 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -31,6 +31,7 @@
  */
 
 struct cros_chctl_priv {
+	struct device *dev;
 	struct cros_ec_device *cros_ec;
 	struct acpi_battery_hook battery_hook;
 	struct power_supply *hooked_battery;
@@ -202,6 +203,7 @@ static int cros_chctl_psy_prop_is_writeable(struct power_supply *psy,
 	};									\
 										\
 	static const struct power_supply_ext _name = {				\
+		.name			= "cros-charge-control",		\
 		.properties		= _name ## _props,			\
 		.num_properties		= ARRAY_SIZE(_name ## _props),		\
 		.charge_behaviours	= EC_CHARGE_CONTROL_BEHAVIOURS,		\
@@ -233,7 +235,7 @@ static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_batt
 		return 0;
 
 	priv->hooked_battery = battery;
-	return power_supply_register_extension(battery, priv->psy_ext, priv);
+	return power_supply_register_extension(battery, priv->psy_ext, priv->dev, priv);
 }
 
 static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
@@ -299,6 +301,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version);
 
+	priv->dev = dev;
 	priv->cros_ec = cros_ec;
 
 	if (priv->cmd_version == 1)
diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 531785516d2ac31f9a7f73a58e15e64cb81820ed..9ed749cd09369f0f13017847687509736b30aae8 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -25,6 +25,7 @@ extern bool power_supply_ext_has_property(const struct power_supply_ext *ext,
 struct power_supply_ext_registration {
 	struct list_head list_head;
 	const struct power_supply_ext *ext;
+	struct device *dev;
 	void *data;
 };
 
@@ -39,6 +40,7 @@ struct power_supply_ext_registration {
 
 extern void __init power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
+extern const struct attribute_group power_supply_extension_group;
 extern const struct attribute_group *power_supply_attr_groups[];
 
 #else
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index bc22edbd0e6a02c27500132075f5c98d814a7330..5142fbd580ee3d629a2aae7d0b9bcd5709162129 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1346,17 +1346,21 @@ static int power_supply_update_sysfs_and_hwmon(struct power_supply *psy)
 }
 
 int power_supply_register_extension(struct power_supply *psy, const struct power_supply_ext *ext,
-				    void *data)
+				    struct device *dev, void *data)
 {
 	struct power_supply_ext_registration *reg;
 	size_t i;
 	int ret;
 
-	if (!psy || !ext || !ext->properties || !ext->num_properties)
+	if (!psy || !dev || !ext || !ext->name || !ext->properties || !ext->num_properties)
 		return -EINVAL;
 
 	guard(rwsem_write)(&psy->extensions_sem);
 
+	power_supply_for_each_extension(reg, psy)
+		if (strcmp(ext->name, reg->ext->name) == 0)
+			return -EEXIST;
+
 	for (i = 0; i < ext->num_properties; i++)
 		if (power_supply_has_property(psy, ext->properties[i]))
 			return -EEXIST;
@@ -1366,9 +1370,15 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
 		return -ENOMEM;
 
 	reg->ext = ext;
+	reg->dev = dev;
 	reg->data = data;
 	list_add(&reg->list_head, &psy->extensions);
 
+	ret = sysfs_add_link_to_group(&psy->dev.kobj, power_supply_extension_group.name,
+				      &dev->kobj, ext->name);
+	if (ret)
+		goto sysfs_link_failed;
+
 	ret = power_supply_update_sysfs_and_hwmon(psy);
 	if (ret)
 		goto sysfs_hwmon_failed;
@@ -1376,6 +1386,8 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
 	return 0;
 
 sysfs_hwmon_failed:
+	sysfs_remove_link_from_group(&psy->dev.kobj, power_supply_extension_group.name, ext->name);
+sysfs_link_failed:
 	list_del(&reg->list_head);
 	kfree(reg);
 	return ret;
@@ -1392,6 +1404,9 @@ void power_supply_unregister_extension(struct power_supply *psy, const struct po
 		if (reg->ext == ext) {
 			list_del(&reg->list_head);
 			kfree(reg);
+			sysfs_remove_link_from_group(&psy->dev.kobj,
+						     power_supply_extension_group.name,
+						     reg->ext->name);
 			power_supply_update_sysfs_and_hwmon(psy);
 			return;
 		}
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 927ddb9d83bb7259809ba695cb9398d1ad654b46..aadc41ca741d8acd27a83f6bd01d578d7877e7c2 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -421,8 +421,18 @@ static const struct attribute_group power_supply_attr_group = {
 	.is_visible = power_supply_attr_is_visible,
 };
 
+static struct attribute *power_supply_extension_attrs[] = {
+	NULL
+};
+
+const struct attribute_group power_supply_extension_group = {
+	.name = "extensions",
+	.attrs = power_supply_extension_attrs,
+};
+
 const struct attribute_group *power_supply_attr_groups[] = {
 	&power_supply_attr_group,
+	&power_supply_extension_group,
 	NULL
 };
 
diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 66f9ef52e0f3e6e6e6bebcfd438c2acd421284ec..2a975a110f4859a77f7689369675f2008816d704 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -293,6 +293,7 @@ static int test_power_battery_extproperty_is_writeable(struct power_supply *psy,
 }
 
 static const struct power_supply_ext test_power_battery_ext = {
+	.name			= "test_power",
 	.properties		= test_power_battery_extprops,
 	.num_properties		= ARRAY_SIZE(test_power_battery_extprops),
 	.get_property		= test_power_battery_extget_property,
@@ -307,7 +308,8 @@ static void test_power_configure_battery_extension(bool enable)
 	psy = test_power_supplies[TEST_BATTERY];
 
 	if (enable) {
-		if (power_supply_register_extension(psy, &test_power_battery_ext, NULL)) {
+		if (power_supply_register_extension(psy, &test_power_battery_ext, &psy->dev,
+						    NULL)) {
 			pr_err("registering battery extension failed\n");
 			return;
 		}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e434516086f032cdb4698005bb1a99eda303a307..88a7bd34c8a74d694013aaaebd30269b30509e8b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -284,6 +284,7 @@ struct power_supply_desc {
 };
 
 struct power_supply_ext {
+	const char *const name;
 	u8 charge_behaviours;
 	const enum power_supply_property *properties;
 	size_t num_properties;
@@ -907,6 +908,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 extern int __must_check
 power_supply_register_extension(struct power_supply *psy,
 				const struct power_supply_ext *ext,
+				struct device *dev,
 				void *data);
 extern void power_supply_unregister_extension(struct power_supply *psy,
 					      const struct power_supply_ext *ext);

-- 
2.47.1


