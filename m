Return-Path: <linux-pm+bounces-7972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888388C93BC
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 09:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159D928172A
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7041803E;
	Sun, 19 May 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TaaqmCPg"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B8944F;
	Sun, 19 May 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105051; cv=none; b=u0ZHsDu1ZRPynbERULy+xK4QSWBg9OKetJtEQv9F3cTDkbKebyrYiXQfbbYLOa3UFL7ilJmk+fSy/3j9yWfOMjVtwBNe6P9O6Hze5mKiWBLyuaDL1AIuTTa6QKY/O5CJ7SX/UDUylOFD95Xy9WHmTtNr1bxbJcwRuDu0k31aMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105051; c=relaxed/simple;
	bh=4naJDmc9GC/cDm3OReuCvCN5vKmi4aLzsh8rQbrrKqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkCt+re0iBRnRTeZOb59Q9m/QOXqJrgkEg2RcM0PAso4g06A1aZ2FE9Mfgdt+2ueD5LC7X51gW2oZZaDSf5k6Fcj9YqybethBiz2Z58OhK4zHECDXtyBBiMOM8xeTyZ11xnCt78WXWgzWm6hv8RVpMVXF6gQ7u/iSLEYrpSznaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TaaqmCPg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716105046;
	bh=4naJDmc9GC/cDm3OReuCvCN5vKmi4aLzsh8rQbrrKqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TaaqmCPgF6tYWo946dNb1K7F30c1DXR/6YmG1x2TVCAVGh395L0MKJIbki1+UNPf6
	 HTwtUVdA2nbwNRDbB3e5+LTC4utvhJFMfjPIGxEzVslDZhDDRtNUCv5jluGhpD+xcG
	 FzfNPHLTdbALT+pNAIiDY35W3jTHFk1KPVKsTEG4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 19 May 2024 09:50:20 +0200
Subject: [PATCH 2/3] power: supply: add ChromeOS EC based charge control
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240519-cros_ec-charge-control-v1-2-baf305dc79b8@weissschuh.net>
References: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
In-Reply-To: <20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716105045; l=12046;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4naJDmc9GC/cDm3OReuCvCN5vKmi4aLzsh8rQbrrKqk=;
 b=GxHDNDObQCibfC4kDrIGj1kP4UQh+Xv1kFOYL/VQVOiKtPaNlBNwvj1CWxcEt0ehps0AJ/y8v
 gHxyWEtgf+/C1IuJk8Yee861eYrERM5RtdZlnto4ihcleDA+Acy5UF2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ChromeOS Embedded Controller implements a command to control charge
thresholds and behaviour.

Use it to implement the standard Linux charge_control_start_threshold,
charge_control_end_threshold and charge_behaviour sysfs UAPIs.

The driver is designed to be probed via the cros_ec mfd device.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS                                |   6 +
 drivers/power/supply/Kconfig               |  12 ++
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/cros_charge-control.c | 279 +++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca389fd49d74..9bccc5683044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5097,11 +5097,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
+CHROMEOS EC CHARGE CONTROL
+M:	Thomas Weißschuh <thomas@weissschuh.net>
+S:	Maintained
+F:	drivers/power/supply/cros_charge-control.c
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
+F:	drivers/power/supply/cros_charge-control.c
 F:	drivers/power/supply/cros_usbpd-charger.c
 N:	cros_ec
 N:	cros-ec
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..f6321a42aa53 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -860,6 +860,18 @@ config CHARGER_CROS_PCHG
 	  the peripheral charge ports from the EC and converts that into
 	  power_supply properties.
 
+config CHARGER_CROS_CONTROL
+	tristate "ChromeOS EC based charge control"
+	depends on MFD_CROS_EC_DEV
+	depends on ACPI_BATTERY
+	default MFD_CROS_EC_DEV
+	help
+	  Say Y here to enable ChromeOS EC based battery charge control.
+	  This driver can manage charge thresholds and behaviour.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called cros_charge-control.
+
 config CHARGER_SC2731
 	tristate "Spreadtrum SC2731 charger driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..31ca6653a564 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
+obj-$(CONFIG_CHARGER_CROS_CONTROL)	+= cros_charge-control.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
new file mode 100644
index 000000000000..1387c9468c06
--- /dev/null
+++ b/drivers/power/supply/cros_charge-control.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  ChromesOS EC driver for charge control
+ *
+ *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#include <acpi/battery.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME	"cros-charge-control"
+
+#define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)   | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
+
+/*
+ * Semantics of data *returned* from the EC API and Linux sysfs differ
+ * slightly. To match the expected sysfs API, data is never read back from the
+ * EC but cached in the driver.
+ *
+ * Changes to the EC bypassing the driver will not be reflected in sysfs.
+ * Any change to "charge_behaviour" will synchronize the EC with the driver state.
+ */
+
+struct cros_chctl_priv {
+	struct cros_ec_device *cros_ec;
+	struct acpi_battery_hook battery_hook;
+
+	struct device_attribute start_threshold;
+	struct device_attribute end_threshold;
+	struct device_attribute charge_behaviour;
+	struct attribute *attributes[4];
+	struct attribute_group group;
+
+	enum power_supply_charge_behaviour current_behaviour;
+	u8 current_start_threshold, current_end_threshold;
+};
+
+static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
+					      struct ec_params_charge_control *req)
+{
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_charge_control req;
+			struct ec_response_charge_control resp;
+		} __packed data;
+	} __packed buf = {
+		.msg = {
+			.command = EC_CMD_CHARGE_CONTROL,
+			.version = EC_VER_CHARGE_CONTROL,
+			.insize  = sizeof(buf.data.resp),
+			.outsize = sizeof(buf.data.req),
+		},
+		.data.req = *req,
+	};
+
+	return cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+}
+
+static int cros_chctl_configure_ec(struct device *dev, struct cros_chctl_priv *priv)
+{
+	struct ec_params_charge_control req = { };
+
+	req.cmd = EC_CHARGE_CONTROL_CMD_SET;
+
+	switch (priv->current_behaviour) {
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+		req.mode = CHARGE_CONTROL_NORMAL;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+		req.mode = CHARGE_CONTROL_IDLE;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+		req.mode = CHARGE_CONTROL_DISCHARGE;
+		break;
+	default:
+		dev_warn_ratelimited(dev, "Unexpected behaviour %d", priv->current_behaviour);
+		return -EINVAL;
+	}
+
+	if (priv->current_behaviour == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO &&
+	    !(priv->current_start_threshold == 0 && priv->current_end_threshold == 100)) {
+		req.sustain_soc.lower = priv->current_start_threshold;
+		req.sustain_soc.upper = priv->current_end_threshold;
+	} else {
+		/* Disable charging limits */
+		req.sustain_soc.lower = -1;
+		req.sustain_soc.upper = -1;
+	}
+
+	return cros_chctl_send_charge_control_cmd(priv->cros_ec, &req);
+}
+
+static ssize_t cros_chctl_store_threshold(struct device *dev,
+					  struct cros_chctl_priv *priv,
+					  int is_end_threshold,
+					  const char *buf, size_t count)
+{
+	int ret, val;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val < 1 || val > 100)
+		return -EINVAL;
+
+	if (is_end_threshold) {
+		if (val <= priv->current_start_threshold)
+			return -EINVAL;
+		priv->current_end_threshold = val;
+	} else {
+		if (val >= priv->current_end_threshold)
+			return -EINVAL;
+		priv->current_start_threshold = val;
+	}
+
+	if (priv->current_behaviour == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) {
+		ret = cros_chctl_configure_ec(dev, priv);
+		if (ret < 0)
+			return ret;
+	}
+
+	return count;
+}
+
+static ssize_t charge_control_start_threshold_show(struct device *dev,
+						   struct device_attribute *attr,
+						   char *buf)
+{
+	struct cros_chctl_priv *priv = container_of(attr, struct cros_chctl_priv, start_threshold);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_threshold);
+}
+
+static ssize_t charge_control_start_threshold_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
+{
+	struct cros_chctl_priv *priv = container_of(attr, struct cros_chctl_priv, start_threshold);
+
+	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	struct cros_chctl_priv *priv = container_of(attr, struct cros_chctl_priv, end_threshold);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshold);
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	struct cros_chctl_priv *priv = container_of(attr, struct cros_chctl_priv, end_threshold);
+
+	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
+}
+
+static ssize_t charge_behaviour_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cros_chctl_priv *priv = container_of(attr, struct cros_chctl_priv, charge_behaviour);
+
+	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVIOURS,
+						  priv->current_behaviour, buf);
+}
+
+static ssize_t charge_behaviour_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct cros_chctl_priv *priv = container_of(attr, struct cros_chctl_priv, charge_behaviour);
+	enum power_supply_charge_behaviour behaviour;
+	int ret;
+
+	behaviour = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
+	if (behaviour < 0)
+		return behaviour;
+
+	priv->current_behaviour = behaviour;
+
+	ret = cros_chctl_configure_ec(dev, priv);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct cros_chctl_priv *priv = container_of(hook, struct cros_chctl_priv, battery_hook);
+
+	return device_add_group(&battery->dev, &priv->group);
+}
+
+static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct cros_chctl_priv *priv = container_of(hook, struct cros_chctl_priv, battery_hook);
+
+	device_remove_group(&battery->dev, &priv->group);
+
+	return 0;
+}
+
+static int cros_chctl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct cros_chctl_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->cros_ec = cros_ec;
+	priv->start_threshold = (struct device_attribute)__ATTR_RW(charge_control_start_threshold);
+	priv->end_threshold = (struct device_attribute)__ATTR_RW(charge_control_end_threshold);
+	priv->charge_behaviour = (struct device_attribute)__ATTR_RW(charge_behaviour);
+	priv->attributes[0] = &priv->start_threshold.attr;
+	priv->attributes[1] = &priv->end_threshold.attr;
+	priv->attributes[2] = &priv->charge_behaviour.attr;
+	priv->attributes[3] = NULL;
+	priv->group.attrs = priv->attributes;
+
+	priv->battery_hook.name = dev_name(dev),
+	priv->battery_hook.add_battery = cros_chctl_add_battery,
+	priv->battery_hook.remove_battery = cros_chctl_remove_battery,
+
+	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+	priv->current_start_threshold = 0;
+	priv->current_end_threshold = 100;
+
+	/* Bring EC into well-known state and validate command availability */
+	ret = cros_chctl_configure_ec(dev, priv);
+	if (ret == -EOPNOTSUPP)
+		return -ENODEV;
+	else if (ret < 0)
+		return ret;
+
+	battery_hook_register(&priv->battery_hook);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int cros_chctl_remove(struct platform_device *pdev)
+{
+	struct cros_chctl_priv *priv = platform_get_drvdata(pdev);
+
+	battery_hook_unregister(&priv->battery_hook);
+
+	return 0;
+}
+
+static const struct platform_device_id cros_chctl_id[] = {
+	{ DRV_NAME, 0 },
+	{ }
+};
+
+static struct platform_driver cros_chctl_driver = {
+	.driver.name	= DRV_NAME,
+	.probe		= cros_chctl_probe,
+	.remove		= cros_chctl_remove,
+	.id_table	= cros_chctl_id,
+};
+module_platform_driver(cros_chctl_driver);
+
+MODULE_DEVICE_TABLE(platform, cros_chctl_id);
+MODULE_DESCRIPTION("ChromeOS EC charge control");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_LICENSE("GPL");

-- 
2.45.1


